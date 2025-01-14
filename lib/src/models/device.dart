import 'package:flutter/foundation.dart';

@immutable
class Device {
  Device({
    required String manufacturer,
    required this.model,
    required this.androidVersion,
  }) : manufacturer = manufacturer.toLowerCase().replaceAll(' ', '-');
  final String manufacturer;
  final String model;
  final String androidVersion;
}
