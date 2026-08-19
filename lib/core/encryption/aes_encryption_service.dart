import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt_lib;

class AesEncryptionService {
  AesEncryptionService._();

  static const _passphrase = 'abcdefghijuklmno0123456789012345';
  static const _saltLength = 8;
  static const _keyLength = 32;
  static const _ivLength = 16;

  static Uint8List _evpBytesToKey(
    Uint8List password,
    Uint8List salt, {
    int keyLength = 32,
    int ivLength = 16,
  }) {
    final totalLength = keyLength + ivLength;
    final result = <int>[];
    Uint8List previous = Uint8List(0);

    while (result.length < totalLength) {
      final hash = md5.convert([...previous, ...password, ...salt]).bytes;
      previous = Uint8List.fromList(hash);
      result.addAll(hash);
    }

    return Uint8List.fromList(result.sublist(0, totalLength));
  }

  static String encryptPayload(String plainText) {
    final random = Random.secure();
    final salt = Uint8List.fromList(
      List.generate(_saltLength, (_) => random.nextInt(256)),
    );

    final passwordBytes = Uint8List.fromList(utf8.encode(_passphrase));
    final keyMaterial = _evpBytesToKey(
      passwordBytes,
      salt,
      keyLength: _keyLength,
      ivLength: _ivLength,
    );

    final key = encrypt_lib.Key(keyMaterial.sublist(0, _keyLength));
    final iv = encrypt_lib.IV(keyMaterial.sublist(_keyLength, _keyLength + _ivLength));

    final encrypter = encrypt_lib.Encrypter(
      encrypt_lib.AES(key, mode: encrypt_lib.AESMode.cbc),
    );
    final encrypted = encrypter.encrypt(plainText, iv: iv);

    final output = Uint8List.fromList(
      utf8.encode('Salted__') + salt + encrypted.bytes,
    );
    return base64Encode(output);
  }

  static String decryptPayload(String cipherBase64) {
    final fullBytes = base64Decode(cipherBase64);

    final prefix = utf8.decode(fullBytes.sublist(0, 8));
    if (prefix != 'Salted__') {
      throw Exception('Invalid OpenSSL salted format');
    }

    final salt = fullBytes.sublist(8, 8 + _saltLength);
    final ciphertext = fullBytes.sublist(8 + _saltLength);

    final passwordBytes = Uint8List.fromList(utf8.encode(_passphrase));
    final keyMaterial = _evpBytesToKey(
      passwordBytes,
      Uint8List.fromList(salt),
      keyLength: _keyLength,
      ivLength: _ivLength,
    );

    final key = encrypt_lib.Key(keyMaterial.sublist(0, _keyLength));
    final iv = encrypt_lib.IV(keyMaterial.sublist(_keyLength, _keyLength + _ivLength));

    final encrypter = encrypt_lib.Encrypter(
      encrypt_lib.AES(key, mode: encrypt_lib.AESMode.cbc),
    );
    final encrypted = encrypt_lib.Encrypted(Uint8List.fromList(ciphertext));
    return encrypter.decrypt(encrypted, iv: iv);
  }

  static Map<String, dynamic> encryptBody(Map<String, dynamic> body) {
    final jsonStr = jsonEncode(body);
    final encrypted = encryptPayload(jsonStr);
    return {'payload': encrypted};
  }

  static Map<String, dynamic> decryptResponse(dynamic data) {
    if (data is Map<String, dynamic>) {
      final payload = data['payload'];
      if (payload is String && payload.isNotEmpty) {
        try {
          final decrypted = decryptPayload(payload);
          final decoded = jsonDecode(decrypted);
          if (decoded is Map<String, dynamic>) return decoded;
          return {'data': decoded};
        } catch (_) {
          return data;
        }
      }
      return data;
    }
    if (data is String) {
      try {
        final decrypted = decryptPayload(data);
        final decoded = jsonDecode(decrypted);
        if (decoded is Map<String, dynamic>) return decoded;
        return {'data': decoded};
      } catch (_) {
        return {'data': data};
      }
    }
    return {'data': data};
  }

  static String decryptToken(String encryptedToken) {
    try {
      return decryptPayload(encryptedToken);
    } catch (_) {
      return encryptedToken;
    }
  }
}
