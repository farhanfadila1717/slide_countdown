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
      home: ExampleSlideCountdown(),
    );
  }
}

//// Example Slide Countdown
class ExampleSlideCountdown extends StatelessWidget {
  const ExampleSlideCountdown({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example Slidecountdown '),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ////------------------Default--------------------------------
            Text('Default'),
            const Padding(padding: const EdgeInsets.only(top: 10)),
            SlideCountdown(
              duration: const Duration(days: 11),
            ),
            ////-----------SlideDirection.up, & onDone-------------------
            const Padding(padding: const EdgeInsets.only(top: 20)),
            Text('SlideDirection.up, & onDone'),
            const Padding(padding: const EdgeInsets.only(top: 10)),
            SlideCountdown(
              duration: const Duration(days: 11),
              slideDirection: SlideDirection.up,
              onDone: () {
                print('Countdown done!');
              },
            ),
            ////---------Fade Animation & Custom TextSyle---------------
            const Padding(padding: const EdgeInsets.only(top: 20)),
            Text('Fade Animation & Custom TextSyle'),
            const Padding(padding: const EdgeInsets.only(top: 10)),
            SlideCountdown(
              duration: const Duration(days: 11),
              fade: true,
              decoration: BoxDecoration(
                color: Colors.black87,
              ),
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            ////----------With icon, SeparatorType.title-----------------
            const Padding(padding: const EdgeInsets.only(top: 20)),
            Text('With icon, SeparatorType.title'),
            const Padding(padding: const EdgeInsets.only(top: 10)),
            SlideCountdown(
              duration: const Duration(days: 11),
              icon: Icon(Icons.alarm_rounded, color: Colors.white),
              durationTitle: DurationTitle.en(),
              slideDirection: SlideDirection.up,
              separatorType: SeparatorType.title,
              onDone: () {
                print('Countdown done!');
              },
            ),
            ////-----------------Custom decoration------------------------
            const Padding(padding: const EdgeInsets.only(top: 20)),
            Text('Custom decoration'),
            const Padding(padding: const EdgeInsets.only(top: 10)),
            SlideCountdown(
              duration: const Duration(hours: 4, minutes: 20),
              icon: Icon(Icons.alarm_rounded, color: Colors.white),
              durationTitle: DurationTitle.en(),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: const BorderRadius.all(Radius.circular(3)),
              ),
              slideDirection: SlideDirection.up,
              separatorType: SeparatorType.title,
              onDone: () {
                print('Countdown done!');
              },
            ),
          ],
        ),
      ),
    );
  }
}
