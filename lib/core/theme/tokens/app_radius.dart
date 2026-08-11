import 'package:flutter/material.dart';

class AppRadius {
  AppRadius._();

  static const Radius small = Radius.circular(8);
  static const Radius medium = Radius.circular(12);
  static const Radius large = Radius.circular(20);

  static const BorderRadius smallAll = BorderRadius.all(small);
  static const BorderRadius mediumAll = BorderRadius.all(medium);
  static const BorderRadius largeAll = BorderRadius.all(large);
}
