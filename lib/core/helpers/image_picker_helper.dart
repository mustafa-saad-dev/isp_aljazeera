import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

/// مساعد مركزي لالتقاط وضغط الصور.
/// كل الدوال ترجع الصورة أو `null` عند الإلغاء/الخطأ ولا ترمي استثناءً أبداً.
/// الاستخدام المباشر:
/// ```dart
/// final image = await ImagePickerHelper.pickFromGallery();
/// if (image == null) return; // لا توجد صورة
/// ```
class ImagePickerHelper {
  ImagePickerHelper._();

  static final ImagePicker _picker = ImagePicker();

  /// يلتقط صورة من [source] ويرجعها، أو `null` إن لم تُلتقط.
  static Future<XFile?> pick({
    ImageSource source = ImageSource.gallery,
    double? maxWidth,
    double? maxHeight,
    int? quality,
  }) async {
    try {
      return await _picker.pickImage(
        source: source,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: quality,
      );
    } catch (_) {
      return null;
    }
  }

  static Future<XFile?> pickFromGallery({
    double? maxWidth,
    double? maxHeight,
    int? quality,
  }) =>
      pick(
        source: ImageSource.gallery,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        quality: quality,
      );

  static Future<XFile?> pickFromCamera({
    double? maxWidth,
    double? maxHeight,
    int? quality,
  }) =>
      pick(
        source: ImageSource.camera,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        quality: quality,
      );

  /// يلتقط عدة صور ويرجعها، أو قائمة فارغة عند الإلغاء/الخطأ.
  static Future<List<XFile>> pickMultiFromGallery() async {
    try {
      final files = await _picker.pickMultiImage();
      return files;
    } catch (_) {
      return const [];
    }
  }

  /// يلتقط صورة ثم يضغطها لتصبح أصغر من [maxBytes] (افتراضياً 15 ميجابايت).
  /// يرجع `null` عند الإلغاء/الخطأ.
  static Future<XFile?> pickCompressed({
    ImageSource source = ImageSource.gallery,
    int maxBytes = 15 * 1024 * 1024,
    int quality = 80,
    double? maxWidth,
    double? maxHeight,
  }) async {
    final file = await pick(
      source: source,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      quality: quality,
    );
    if (file == null) return null;
    return compress(file, maxBytes: maxBytes, quality: quality);
  }

  static Future<XFile?> pickCompressedFromGallery({
    int maxBytes = 15 * 1024 * 1024,
    int quality = 80,
    double? maxWidth,
    double? maxHeight,
  }) =>
      pickCompressed(
        source: ImageSource.gallery,
        maxBytes: maxBytes,
        quality: quality,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
      );

  static Future<XFile?> pickCompressedFromCamera({
    int maxBytes = 15 * 1024 * 1024,
    int quality = 80,
    double? maxWidth,
    double? maxHeight,
  }) =>
      pickCompressed(
        source: ImageSource.camera,
        maxBytes: maxBytes,
        quality: quality,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
      );

  /// يضغط [file] حتى يصبح حجمه أقل من أو يساوي [maxBytes].
  /// إن كان أصغر مسبقاً، أو فشل الضغط، يُعاد الملف كما هو.
  static Future<XFile?> compress(
    XFile file, {
    int maxBytes = 15 * 1024 * 1024,
    int quality = 80,
    int maxWidth = 1920,
    int maxHeight = 1920,
  }) async {
    try {
      final bytes = await file.readAsBytes();
      if (bytes.length <= maxBytes) return file;

      var q = quality;
      var w = maxWidth;
      var h = maxHeight;

      Uint8List? result = await FlutterImageCompress.compressWithList(
        bytes,
        quality: q,
        minWidth: w,
        minHeight: h,
        format: CompressFormat.jpeg,
      );

      while (result != null &&
          result.length > maxBytes &&
          (q > 10 || w > 200)) {
        if (q > 10) q -= 10;
        if (w > 200) {
          w = (w * 0.8).round();
          h = (h * 0.8).round();
        }
        result = await FlutterImageCompress.compressWithList(
          bytes,
          quality: q,
          minWidth: w,
          minHeight: h,
          format: CompressFormat.jpeg,
        );
      }

      if (result == null) return file;

      return XFile.fromData(
        result,
        name: '${DateTime.now().microsecondsSinceEpoch}.jpg',
        mimeType: 'image/jpeg',
      );
    } catch (_) {
      return file;
    }
  }

  /// يضغط مجموعة صور كل على حدة ويرجع القائمة المضغوطة.
  static Future<List<XFile>> compressMulti(
    List<XFile> files, {
    int maxBytes = 15 * 1024 * 1024,
    int quality = 80,
  }) async {
    final out = <XFile>[];
    for (final file in files) {
      out.add(await compress(file, maxBytes: maxBytes, quality: quality) ?? file);
    }
    return out;
  }
}
