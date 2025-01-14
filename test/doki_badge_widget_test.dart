import 'package:flutter/material.dart';
import 'package:flutter_doki/src/models/badge_state.dart';
import 'package:flutter_doki/src/models/badge_type.dart';
import 'package:flutter_doki/src/models/doki_response.dart';
import 'package:flutter_doki/src/view_model.dart';
import 'package:flutter_doki/src/widget/doki_badge_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockViewModel extends Mock implements BadgeViewModel {}

class FakeDockiResponse extends Fake implements DokiResponse {
  @override
  String get name => 'name';

  @override
  int get award => 1;
}

void main() {
  late MockViewModel mockViewModel;
  late FakeDockiResponse fakeDockiResponse;

  setUp(() {
    fakeDockiResponse = FakeDockiResponse();
    mockViewModel = MockViewModel();
  });

  testWidgets('shows loading widget when state is init', (tester) async {
    when(() => mockViewModel.state).thenReturn(BadgeState.init);
    when(() => mockViewModel.error).thenReturn(null);
    when(() => mockViewModel.response).thenReturn(null);
    when(() => mockViewModel.load()).thenAnswer((_) async {});

    await tester.pumpWidget(
      MaterialApp(
        home: DokiBadgeWidget(
          viewModel: mockViewModel,
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows error widget when state is error', (tester) async {
    when(() => mockViewModel.state).thenReturn(BadgeState.error);
    when(() => mockViewModel.error).thenReturn(Exception('Error'));
    when(() => mockViewModel.response).thenReturn(null);
    when(() => mockViewModel.load()).thenAnswer((_) async {});

    await tester.pumpWidget(
      MaterialApp(
        home: DokiBadgeWidget(
          viewModel: mockViewModel,
        ),
      ),
    );

    expect(find.text('Error'), findsOneWidget);
  });

  testWidgets('shows custom error widget when provided', (tester) async {
    when(() => mockViewModel.state).thenReturn(BadgeState.error);

    await tester.pumpWidget(
      MaterialApp(
        home: DokiBadgeWidget(
          viewModel: mockViewModel,
          errorBuilder: (context) => Text('Custom Error'),
        ),
      ),
    );

    expect(find.text('Custom Error'), findsOneWidget);
  });

  testWidgets('shows badge widget when state is loaded', (tester) async {
    when(() => mockViewModel.state).thenReturn(BadgeState.loaded);
    when(() => mockViewModel.response).thenReturn(fakeDockiResponse);

    await tester.pumpWidget(
      MaterialApp(
        home: DokiBadgeWidget(
          viewModel: mockViewModel,
          type: BadgeType.rectangle,
        ),
      ),
    );

    expect(find.byType(GestureDetector), findsOneWidget);
  });

  testWidgets('changes badge type based on provided type', (tester) async {
    when(() => mockViewModel.state).thenReturn(BadgeState.loaded);
    when(() => mockViewModel.response).thenReturn(fakeDockiResponse);
    when(() => mockViewModel.error).thenReturn(null);

    await tester.pumpWidget(
      MaterialApp(
        home: DokiBadgeWidget(
          viewModel: mockViewModel,
          type: BadgeType.square,
        ),
      ),
    );

    expect(find.byType(GestureDetector), findsOneWidget);
  });
}
