import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_doki/flutter_doki.dart';
import 'package:flutter_doki/src/models/device.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

/// A utility class for interacting with the "Don't Kill My App" service.
///
/// This class provides static methods to:
/// * Open device-specific pages on dontkillmyapp.com
/// * Retrieve device information and manufacturer-specific optimization guidelines
/// * Fetch and parse content from the dontkillmyapp.com API
///
/// The class is designed to help developers understand and handle device-specific
/// battery optimization settings that might affect their app's background operations.
///
/// Example usage:
/// ```dart
/// // Open the manufacturer-specific page
/// await Doki.open(appName: 'MyApp');
///
/// // Get device-specific optimization guidelines
/// final response = await Doki.getDokiResponse();
/// print(response.explanation);
/// ```
///
/// All methods in this class are static and do not require instantiation of the class.
class Doki {
  /// Opens the "Don't Kill My App" website for the user's device manufacturer.
  ///
  /// This static method constructs and launches a URL to the appropriate page on
  /// dontkillmyapp.com based on the device manufacturer and specified parameters.
  ///
  /// Parameters:
  /// - [appName] Optional name of the app to be included in the URL query
  /// - [type] Type of badge to display (defaults to BadgeType.landscape)
  ///
  /// Returns a [Future<bool>] that completes with:
  /// - true if the URL was successfully launched
  /// - false if the URL launch failed
  ///
  /// Example:
  /// ```dart
  /// await FlutterDoki.open(appName: 'MyApp', type: BadgeType.portrait);
  /// ```
  static Future<bool> open({String? appName, BadgeType type = BadgeType.landscape}) async {
    final device = await getDevice();
    final uri = Uri(
      scheme: 'https',
      host: DontkillmyApp.baseUurl,
      path: device.manufacturer,
      query: '${type.value}&app=$appName',
    );

    return await _launchUrl(uri);
  }

  /// Returns a [DokiResponse] containing device information.
  ///
  /// This method first retrieves the device information using [getDevice] and then
  /// processes it through [_getContent] to generate the final response.
  ///
  /// Returns a [Future] that completes with a [DokiResponse] object containing
  /// the processed device information.

  static Future<DokiResponse> getDokiResponse() async {
    final device = await getDevice();
    return await _getContent(device);
  }

  /// Launches the given URL in an in-app browser.
  ///
  /// Takes a [Uri] parameter and attempts to launch it using the device's
  /// URL launcher capability. The URL is opened in an in-app browser view.
  ///
  /// Returns a [Future<bool>] that completes with:
  /// * true - if the URL was successfully launched
  /// * false - if the URL could not be launched
  static Future<bool> _launchUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      return await launchUrl(
        url,
        mode: LaunchMode.inAppBrowserView,
      );
    } else {
      return false;
    }
  }

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
  static Future<DokiResponse> _getContent(Device device) async {
    final uri = Uri(
      scheme: 'https',
      host: DontkillmyApp.baseUurl,
      path: '${DontkillmyApp.endpoint}/${device.manufacturer}.json',
    );
    debugPrint(uri.toString());
    final data = await http.get(uri);
    if (data.statusCode != 200) {
      throw Exception('Failed to load content');
    }
    return DokiResponse.fromJson(jsonDecode(data.body));
  }

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
  static Future<Device> getDevice() async {
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
}

/// A utility class for interacting with dontkillmyapp.com API
///
/// This class provides static constants for accessing the dontkillmyapp.com API
/// which provides information about aggressive battery saving mechanisms
/// on different Android devices.
///
/// The class contains:
/// - Base URL for API access
/// - API endpoint path
/// - Fallback manufacturer name when device maker is unknown
///
/// Example:
/// ```dart
/// final apiUrl = DontkillmyApp.baseUurl + DontkillmyApp.endpoint;
/// ```
class DontkillmyApp {
  /// Base URL for the dontkillmyapp.com API
  static String baseUurl = "dontkillmyapp.com";

  /// Base endpoint for the dontkillmyapp.com API
  static String endpoint = "/api/v2/";

  /// Fallback manufacturer for when the device manufacturer cannot be determined
  static String fallbackManufacturer = "general";
}
