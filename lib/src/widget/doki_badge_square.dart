import 'package:flutter/material.dart';
import 'package:flutter_doki/flutter_doki.dart';
import 'package:flutter_doki/src/models/award.dart';

class DokiBadgeSquare extends StatelessWidget {
  const DokiBadgeSquare({super.key, required this.response, this.minHeight = 140});
  final DokiResponse response;
  final double minHeight;
  @override
  Widget build(BuildContext context) {
    Color color = Award.values
        .firstWhere((element) => element.position == response.award, orElse: () => Award.defaultAward)
        .color;
    return SizedBox.square(
      dimension: 96,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FractionallySizedBox(
              child: Text(
                response.name,
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            FractionallySizedBox(
              child: Text(
                '#${response.award}',
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: TextStyle(fontSize: 20, color: color),
              ),
            ),
            Text(
              'dotkillmyapp',
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: TextStyle(
                color: Colors.white60,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
