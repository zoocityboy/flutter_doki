import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_doki/flutter_doki.dart';
import 'package:flutter_doki/src/models/device.dart';
import 'package:http/http.dart' as http;

abstract class DokiService {
  /// Returns a [Device] object containing device information.
  ///
  /// Uses [DeviceInfoPlugin] to fetch device details including:
  /// * manufacturer
  /// * model
  /// * Android version
  ///
  /// If device information cannot be retrieved, returns a fallback [Device] with:
  /// * manufacturer: DontkillmyApp.fallbackManufacturer
  /// * model: 'samsung'
  /// * androidVersion: '13'
  ///
  /// Throws no exceptions as errors are handled internally.
  Future<Device> device();

  /// Fetches device-specific content from the dontkillmyapp.com API.
  ///
  /// Takes a [Device] parameter containing device manufacturer information.
  /// Constructs a URI to fetch JSON data for the specific manufacturer.
  ///
  /// Returns a [Future] that completes with a [DokiResponse] containing the parsed JSON data.
  ///
  /// Throws an [Exception] if the HTTP request fails (status code != 200).
  ///
  /// Example URI format: https://dontkillmyapp.com/api/{manufacturer}.json
  Future<DokiResponse> fetch(Device device);
}

class DokiServiceImpl implements DokiService {
  @override
  Future<Device> device() async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return Device(
        manufacturer: androidInfo.manufacturer,
        model: androidInfo.model,
        androidVersion: androidInfo.version.release,
      );
    } catch (e) {
      return Device(
        manufacturer: DontkillmyApp.fallbackManufacturer,
        model: 'samsung',
        androidVersion: '13',
      );
    }
  }

  @override
  Future<DokiResponse> fetch(Device device) async {
    final uri = Uri(
      scheme: 'https',
      host: DontkillmyApp.baseUurl,
      path: '${DontkillmyApp.endpoint}/${device.manufacturer}.json',
    );

    final data = await http.get(uri);
    if (data.statusCode != 200) {
      throw Exception('Failed to load content');
    }
    return DokiResponse.fromJson(jsonDecode(data.body));
  }
}
