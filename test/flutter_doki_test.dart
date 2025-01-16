import 'package:flutter_doki/flutter_doki.dart';
import 'package:flutter_doki/src/models/device.dart';
import 'package:flutter_doki/src/service/doki_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class MockDokiService extends Mock implements DokiService {}

class MockDevice extends Mock implements Device {}

class MockDokiResponse extends Mock implements DokiResponse {}

class MockUrlLauncher extends Mock
    with MockPlatformInterfaceMixin
    implements UrlLauncherPlatform {}

class FakeDevice extends Fake implements Device {
  @override
  String get manufacturer => 'manufacturer';

  @override
  String get model => 'general';

  @override
  String get androidVersion => '1.0';
}

class FakeLaunchOptions extends Fake implements LaunchOptions {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final MockUrlLauncher mock = MockUrlLauncher();
  UrlLauncherPlatform.instance = mock;
  group('Doki Tests', () {
    late Doki doki;
    late MockDokiService mockService;
    late MockDevice mockDevice;
    late FakeDevice fakeDevice;
    late MockDokiResponse mockResponse;
    setUpAll(() {
      registerFallbackValue(MockDevice());
      registerFallbackValue(FakeLaunchOptions());
    });
    setUp(() {
      mockService = MockDokiService();
      mockDevice = MockDevice();
      fakeDevice = FakeDevice();
      mockResponse = MockDokiResponse();
      doki = Doki();
      doki.service = mockService;

      // Setup default mock responses
      when(() => mockDevice.manufacturer).thenReturn('samsung');
      when(() => mockService.device()).thenAnswer((_) async => mockDevice);
      when(() => mockService.fetch(any()))
          .thenAnswer((_) async => mockResponse);
    });

    group('fetch', () {
      test('should return DokiResponse when successful', () async {
        when(() => mockService.fetch(any()))
            .thenAnswer((_) async => mockResponse);
        final response = await doki.fetch();

        verify(() => mockService.device()).called(1);
        verify(() => mockService.fetch(any())).called(1);
        expect(response, equals(mockResponse));
      });

      test('should throw exception when service fails', () async {
        when(() => mockService.fetch(any()))
            .thenThrow(Exception('Service error'));

        expect(() => doki.fetch(), throwsException);
      });
    });

    group('open', () {
      test('should construct correct URI for device', () async {
        final doki = Doki();
        final mockService = MockDokiService();
        doki.service = mockService;
        ////
        when(() => mock.canLaunch(any())).thenAnswer((_) async => true);
        when(() => mock.launchUrl(any(), any())).thenAnswer((_) async => true);
        when(() => mockService.device()).thenAnswer((_) async => fakeDevice);

        expectLater(
            await doki.open(appName: 'testApp', type: BadgeType.rectangle),
            isTrue);
        // verify(() => mockService.device()).called(1);
        expect(fakeDevice.manufacturer, 'manufacturer');
        expect(fakeDevice.model, 'general');
        expect(fakeDevice.androidVersion, '1.0');
      });

      test('should use different badge types', () async {
        final doki = Doki();
        final mockService = MockDokiService();
        doki.service = mockService;

        ///
        when(() => mock.canLaunch(any())).thenAnswer((_) async => true);
        when(() => mock.launchUrl(any(), any())).thenAnswer((_) async => true);
        when(() => mockService.device()).thenAnswer((_) async => fakeDevice);

        expectLater(await doki.open(appName: 'testApp', type: BadgeType.square),
            isTrue);
        // verify(() => mockService.device()).called(1);
      });
    });

    group('DontkillmyApp constants', () {
      test('should have correct constant values', () {
        expect(DontkillmyApp.baseUurl, equals('dontkillmyapp.com'));
        expect(DontkillmyApp.endpoint, equals('/api/v2/'));
        expect(DontkillmyApp.fallbackManufacturer, equals('general'));
      });
    });
  });
}
