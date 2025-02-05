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
    unawaited(Doki().fetch().then((value) {
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
      theme: ThemeData.light(),
      darkTheme: ThemeData.from(
          colorScheme: ColorScheme.dark(
        primary: Colors.blue,
        secondary: Colors.red,
      )),
      themeMode: ThemeMode.dark,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Doki Example'),
        ),
        body: ListView(
          children: [
            TextButton(
                onPressed: () {
                  Doki().open();
                },
                child: Text('Open in Webbrowser')),
            TextButton(
                onPressed: getDokiResponse, child: Text('Get Doki Response')),
            SizedBox(
              height: 100,
              child: Center(
                child: DokiBadgeWidget(
                  type: BadgeType.square,
                ),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: Center(
                child: DokiBadgeWidget(
                  type: BadgeType.rectangle,
                ),
              ),
            ),
            SizedBox(height: 16),
            if (dokiResponse != null)
              Column(
                children: [
                  Text('Name: ${dokiResponse!.name}'),
                  Text('Award: ${dokiResponse!.award}'),
                  Text('Position: ${dokiResponse!.position}'),
                  Text('Url: ${dokiResponse!.url}'),
                ],
              ),
            if (error != null) Text('Error: $error'),
          ],
        ),
      ),
    );
  }
}
