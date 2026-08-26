import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';

void main() => runApp(
      const MyApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ExampleRawSlideCountdown(),
    );
  }
}

const defaultDuration = Duration(days: 2, hours: 2, minutes: 30);

class ExampleRawSlideCountdown extends StatefulWidget {
  const ExampleRawSlideCountdown({super.key});

  @override
  State<ExampleRawSlideCountdown> createState() =>
      _ExampleRawSlideCountdownState();
}

class _ExampleRawSlideCountdownState extends State<ExampleRawSlideCountdown> {
  late final SlideCountdownController controller;

  @override
  void initState() {
    controller = SlideCountdownController(
      duration: defaultDuration,
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Example'),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RawSlideCountdown(
              controller: controller,
              builder: (context, duration) {
                final countUp = controller.isCountUp;
                return Row(
                  children: [
                    RawDigitItem(
                      duration: duration,
                      timeUnit: TimeUnit.seconds,
                      digitType: DigitType.first,
                      countUp: countUp,
                    ),
                    RawDigitItem(
                      duration: duration,
                      timeUnit: TimeUnit.seconds,
                      digitType: DigitType.second,
                      countUp: countUp,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
