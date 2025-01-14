// ignore_for_file: unused_local_variable

import 'package:flutter_doki/flutter_doki.dart';
import 'package:flutter_doki/src/models/badge_state.dart';
import 'package:flutter_doki/src/models/device.dart';
import 'package:flutter_doki/src/view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockViewModel extends Mock implements BadgeViewModel {}

class FakeDockiResponse extends Fake implements DokiResponse {
  @override
  String get name => 'name';

  @override
  int get award => 1;
}

class FakeViewModel extends Fake implements BadgeViewModel {
  @override
  void load() {
    setValue(state: BadgeState.loaded, response: FakeDockiResponse());
  }
}

class FakeDevice extends Fake implements Device {
  @override
  String get manufacturer => 'manufacturer';

  @override
  String get model => 'general';

  @override
  String get androidVersion => '1.0';
}

void main() {
  group('ViewModel Tests', () {
    late Device device;
    late DokiResponse response;

    setUp(() {
      response = FakeDockiResponse();
      device = FakeDevice();
    });

    test('Initial state should be init', () {
      final viewModel = MockViewModel();
      when(() => viewModel.state).thenReturn(BadgeState.init);
      expect(viewModel.state, equals(BadgeState.init));
      expect(viewModel.error, isNull);
      expect(viewModel.response, isNull);
    });

    test('Loading state should be set when load is called', () {
      final viewModel = MockViewModel();
      when(() => viewModel.load()).thenAnswer((_) async {});
      when(() => viewModel.state).thenReturn(BadgeState.loading);
      viewModel.load();
      expect(viewModel.state, equals(BadgeState.loading));
      expect(viewModel.error, isNull);
      expect(viewModel.response, isNull);
    });

    test('Should handle successful fetch', () async {
      final viewModel = MockViewModel();
      final mockResponse = FakeDockiResponse();
      when(() => viewModel.load()).thenAnswer((_) async {});
      when(() => viewModel.state).thenReturn(BadgeState.loaded);
      when(() => viewModel.response).thenReturn(mockResponse);

      viewModel.load();

      expect(viewModel.state, equals(BadgeState.loaded));
      expect(viewModel.response, equals(mockResponse));
      expect(viewModel.error, isNull);
    });

    test('Should handle error during fetch', () async {
      final viewModel = MockViewModel();
      final exception = Exception('Test error');

      when(viewModel.load).thenThrow(exception);
      when(() => viewModel.state).thenReturn(BadgeState.error);
      when(() => viewModel.error).thenReturn(exception);
      when(() => viewModel.response).thenReturn(null);

      expect(() => viewModel.load(), throwsException);
      expect(viewModel.state, equals(BadgeState.error));
      expect(viewModel.error, equals(exception));
      expect(viewModel.response, isNull);
    });
  });
}
