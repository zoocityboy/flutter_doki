import 'package:flutter/material.dart';
import 'package:flutter_doki/src/flutter_doki.dart';
import 'package:flutter_doki/src/models/badge_state.dart';
import 'package:flutter_doki/src/models/badge_type.dart';
import 'package:flutter_doki/src/models/doki_response.dart';
import 'package:flutter_doki/src/view_model.dart';
import 'package:flutter_doki/src/widget/doki_badge_landscape.dart';
import 'package:flutter_doki/src/widget/doki_badge_square.dart';

class DokiBadgeWidget extends StatefulWidget {
  const DokiBadgeWidget({
    super.key,
    this.type = BadgeType.rectangle,
    this.errorBuilder,
    this.placeholderBuilder,
    @visibleForTesting BadgeViewModel? viewModel,
  }) : _viewModel = viewModel;
  final BadgeType type;
  final WidgetBuilder? placeholderBuilder;
  final WidgetBuilder? errorBuilder;
  final BadgeViewModel? _viewModel;
  @override
  State<DokiBadgeWidget> createState() => _DokiBadgeWidgetState();
}

class _DokiBadgeWidgetState extends State<DokiBadgeWidget> {
  BadgeViewModel viewModel = BadgeViewModel();
  @override
  void initState() {
    super.initState();
    viewModel = widget._viewModel ?? BadgeViewModel();
    viewModel.load();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) => switch (viewModel.state) {
        BadgeState.init ||
        BadgeState.loading =>
          widget.placeholderBuilder?.call(context) ?? _BadgeLoading(),
        BadgeState.error => widget.errorBuilder?.call(context) ?? _BadgeError(),
        BadgeState.loaded => _BadgeWidget(
            key: ValueKey(viewModel.response!),
            response: viewModel.response!,
            type: widget.type,
          ),
      },
    );
  }
}

class _BadgeError extends StatelessWidget {
  const _BadgeError();

  @override
  Widget build(BuildContext context) {
    return const Text('Error');
  }
}

class _BadgeLoading extends StatelessWidget {
  const _BadgeLoading();

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
        dimension: 80, child: const CircularProgressIndicator());
  }
}

class _BadgeWidget extends StatelessWidget {
  const _BadgeWidget(
      {super.key, required this.response, this.type = BadgeType.rectangle});
  final DokiResponse response;
  final BadgeType type;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Doki().open(appName: 'com.example.app'),
      child: switch (type) {
        BadgeType.rectangle => DokiBadgeLadnscape(response: response),
        BadgeType.square => DokiBadgeSquare(response: response),
      },
    );
  }
}
