// Flutter imports:
import 'package:flutter/material.dart';

class AppDecorations {
  static const BoxDecoration roundedBox = BoxDecoration(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(12),
      topLeft: Radius.circular(12),
    ),
  );
}
