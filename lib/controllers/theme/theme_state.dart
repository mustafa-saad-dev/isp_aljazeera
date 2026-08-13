import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppThemeState extends Equatable {
  final ThemeMode mode;
  final String themeName;
  const AppThemeState(this.mode, this.themeName);

  @override
  List<Object?> get props => [mode, themeName];
}
