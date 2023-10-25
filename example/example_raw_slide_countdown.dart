import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ExampleRawSlideCountdown(),
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
  late final StreamDuration streamDuration;

  @override
  void initState() {
    streamDuration = StreamDuration(
      config: StreamDurationConfig(
        countDownConfig: CountDownConfig(duration: defaultDuration),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    streamDuration.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basic Example"),
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RawSlideCountdown(
              streamDuration: streamDuration,
              builder: (context, duration) {
                return Row(
                  children: [],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
