// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DokiBadgeTheme with Diagnosticable {
  final Color placeholderColor;
  final Color backgroundColor;
  final Color foregroundColor;
  const DokiBadgeTheme({
    required this.placeholderColor,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  factory DokiBadgeTheme.defaultTheme(Brightness brightness) {
    return brightness == Brightness.light
        ? DokiBadgeTheme.lightTheme()
        : DokiBadgeTheme.darkTheme();
  }
  factory DokiBadgeTheme.lightTheme() {
    return const DokiBadgeTheme(
      placeholderColor: Colors.grey,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    );
  }
  factory DokiBadgeTheme.darkTheme() {
    return const DokiBadgeTheme(
      placeholderColor: Colors.grey,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    );
  }
}
