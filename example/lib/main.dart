import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_doki/flutter_doki.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  DokiResponse? dokiResponse;
  Exception? error;
  void getDokiResponse() async {
    unawaited(Doki.fetch().then((value) {
      setState(() {
        dokiResponse = value;
      });
    }).catchError((e) {
      setState(() {
        error = e;
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Doki.open(appName: 'com.example.app');
                },
                child: Text('Open in Webbrowser')),
            TextButton(
                onPressed: getDokiResponse, child: Text('Get Doki Response')),
            SizedBox(
              height: 80,
              child: DokiBadgeWidget(
                type: BadgeType.square,
              ),
            ),
            SizedBox(height: 16),
            DokiBadgeWidget(
              type: BadgeType.landscape,
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
