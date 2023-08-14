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
      home: const ExampleSlideCountdown(),
    );
  }
}

const defaultDuration = Duration(days: 2, hours: 2, minutes: 30);
const defaultPadding = EdgeInsets.symmetric(horizontal: 10, vertical: 5);

class ExampleSlideCountdown extends StatelessWidget {
  const ExampleSlideCountdown({Key? key}) : super(key: key);
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
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Text('Default'),
            ),
            SlideCountdown(
              duration: defaultDuration,
              padding: defaultPadding,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Text('Default SlideCountdownSeparated'),
            ),
            const SlideCountdownSeparated(
              duration: defaultDuration,
              padding: defaultPadding,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Text('With Icon, Fade true, & SlideDirection.up'),
            ),
            SlideCountdown(
              duration: defaultDuration,
              padding: defaultPadding,
              slideDirection: SlideDirection.up,
              icon: Padding(
                padding: EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.alarm,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Text('Custom BoxDecoration & SeparatorType.title'),
            ),
            SlideCountdown(
              duration: defaultDuration,
              padding: defaultPadding,
              separatorType: SeparatorType.title,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Text('Localization Custom Duration Title'),
            ),
            SlideCountdown(
              duration: defaultDuration,
              padding: defaultPadding,
              separatorType: SeparatorType.title,
              durationTitle: DurationTitle.id(),
              icon: const Padding(
                padding: EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.alarm,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExampleControlDuration extends StatefulWidget {
  const ExampleControlDuration({Key? key}) : super(key: key);

  @override
  State<ExampleControlDuration> createState() => _ExampleControlDurationState();
}

class _ExampleControlDurationState extends State<ExampleControlDuration> {
  late final StreamDuration _streamDuration;

  @override
  void initState() {
    super.initState();
    _streamDuration = StreamDuration(
      const Duration(hours: 2),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamDuration.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Control Duration'),
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideCountdown(
              // This duration no effect if you customize stream duration
              streamDuration: _streamDuration,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _streamDuration.pause(),
              child: Text('Pause'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _streamDuration.play(),
              child: Text('Play'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // this will add 10 minutes to the remaining duration
                _streamDuration.add(Duration(minutes: 10));
              },
              child: Text('Add Duration'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // this will subtract 10 minutes to the remaining duration
                _streamDuration.subtract(Duration(minutes: 10));
              },
              child: Text('Subtract Duration'),
            ),
          ],
        ),
      ),
    );
  }
}
