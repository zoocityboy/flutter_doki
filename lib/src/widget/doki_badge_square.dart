import 'package:flutter/material.dart';
import 'package:flutter_doki/flutter_doki.dart';
import 'package:flutter_doki/src/models/award.dart';

class DokiBadgeSquare extends StatelessWidget {
  const DokiBadgeSquare({super.key, required this.response});
  final DokiResponse response;
  @override
  Widget build(BuildContext context) {
    Color color = Award.values
        .firstWhere((element) => element.position == response.award,
            orElse: () => Award.defaultAward)
        .color;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: AspectRatio(
        aspectRatio: .8,
        child: FractionallySizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'dotkillmyapp.com',
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 12,
                ),
              ),
              Text(
                response.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                '#${response.award}',
                style: TextStyle(fontSize: 24, color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DokiBadgeLadnscape extends StatelessWidget {
  const DokiBadgeLadnscape({super.key, required this.response});
  final DokiResponse response;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      height: 80,
      child: Column(
        children: [
          _DokiLandscapeTitleWidget(
              key: ValueKey('title_$response'), response: response),
          _DokiLandscapeThumbsWidget(
              key: ValueKey('thumbs_$response'), response: response),
        ],
      ),
    );
  }
}

class _DokiLandscapeTitleWidget extends StatelessWidget {
  const _DokiLandscapeTitleWidget({super.key, required this.response});
  final DokiResponse response;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Text(
              'dontkillmyapp.com',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              response.name,
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

class _DokiLandscapeThumbsWidget extends StatelessWidget {
  const _DokiLandscapeThumbsWidget({super.key, required this.response});
  final DokiResponse response;

  @override
  Widget build(BuildContext context) {
    Color color = Award.values
        .firstWhere((element) => element.position == response.award,
            orElse: () => Award.defaultAward)
        .color;
    return Container(
      decoration: BoxDecoration(color: color),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(5, (index) {
          return Icon(
            index <= (response.award ?? 0)
                ? Icons.thumb_down_rounded
                : Icons.thumb_down_outlined,
            color: Colors.white70,
            size: 20,
          );
        }),
      ),
    );
  }
}
