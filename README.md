## [![hero][]][hero]
[![paypal][]][paypal account] [![flutter][]][web flutter] <br>
Animation countdown timer for Flutter.

---

## Example
```dart
SizedBox.expand(
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
);
```
## Output
<img src="https://user-images.githubusercontent.com/link-to-your-image.png" height="600" />

### 🚧 Maintener 
<a href="https://github.com/farhanfadila1717"><img src="https://avatars.githubusercontent.com/u/43161050?s=100" width="80px;" alt="Farhan Fadila"/></a><br>
**Farhan Fadila** <br>
📫 How to reach me: farhan.fadila1717@gmail.com


[hero]:https://github.com/farhanfadila1717/flutter_package/blob/master/display/slide_coutdown/hero.gif
[output]: https://github.com/farhanfadila1717/flutter_package/blob/master/display/slide_coutdown/output.gif
[flutter]: https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter
[web flutter]: https://flutter.dev
[paypal]: https://img.shields.io/badge/Donate-PayPal-00457C?logo=paypal
[paypal account]: https://www.paypal.me/farhanfadila1717
