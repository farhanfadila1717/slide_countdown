import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SlideCountdownPage(),
    );
  }
}

class SlideCountdownPage extends StatefulWidget {
  const SlideCountdownPage({super.key});

  @override
  State<SlideCountdownPage> createState() => _SlideCountdownPageState();
}

class _SlideCountdownPageState extends State<SlideCountdownPage> {
  late final StreamDuration _streamDuration;

  @override
  void initState() {
    super.initState();
    _streamDuration = StreamDuration(
      config: const StreamDurationConfig(
        countDownConfig: CountDownConfig(
          duration: Duration(days: 2),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _streamDuration.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide Countdown Page'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  theme.buttonTheme.colorScheme?.primary ?? Colors.purpleAccent,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Control Duration'),
              const SizedBox(height: 10),
              SlideCountdown(
                streamDuration: _streamDuration,
                decoration: BoxDecoration(
                  color: theme.buttonTheme.colorScheme?.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => _streamDuration.subtract(
                      const Duration(seconds: 10),
                    ),
                    child: const Text('- 10 seconds'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  FloatingActionButton.small(
                    child: const Icon(Icons.pause_rounded),
                    onPressed: () => _streamDuration.pause(),
                  ),
                  FloatingActionButton.small(
                    child: const Icon(Icons.play_arrow_rounded),
                    onPressed: () => _streamDuration.resume(),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: () => _streamDuration.add(
                      const Duration(seconds: 10),
                    ),
                    child: const Text('+ 10 seconds'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
