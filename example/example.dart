import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example'),
        ),
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SlideCountdown(
              duration: Duration(days: 2),
            ),
            SizedBox(height: 20),
            SlideCountdownSeparated(
              duration: Duration(days: 2),
            ),
          ],
        ),
      ),
    );
  }
}
