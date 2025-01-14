import 'package:flutter/material.dart';
import 'package:flutter_doki/src/models/award.dart';
import 'package:flutter_doki/src/models/doki_response.dart';

class DokiBadgeLadnscape extends StatelessWidget {
  const DokiBadgeLadnscape({super.key, required this.response});
  final DokiResponse response;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      height: 80,
      child: Column(
        children: [
          _DokiLandscapeTitleWidget(key: ValueKey('title_$response'), response: response),
          _DokiLandscapeThumbsWidget(key: ValueKey('thumbs_$response'), response: response),
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
    Color color = Award.values
        .firstWhere((element) => element.position == response.award, orElse: () => Award.defaultAward)
        .color;
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Text(
              'dontkillmyapp',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
                text: TextSpan(style: TextStyle(color: Colors.white, fontSize: 20), children: [
              if (response.award != null) TextSpan(text: '#${response.award} ', style: TextStyle(color: color)),
              TextSpan(
                text: response.name,
              )
            ])),
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
        .firstWhere((element) => element.position == response.award, orElse: () => Award.defaultAward)
        .color;
    return Container(
      decoration: BoxDecoration(color: color),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(5, (index) {
          return Icon(
            index <= (response.award ?? 0) ? Icons.thumb_down_rounded : Icons.thumb_down_outlined,
            color: Colors.white70,
            size: 20,
          );
        }),
      ),
    );
  }
}
