## [![cover][]][pubdev]
[![flutter][]][web flutter] [![badge paypal][]][paypal account] [![badge linktree][]][linktree account] <br>
A Flutter package to create easy slide animation countdown timer.

---

## Example
```dart
const defaultDuration = Duration(days: 2, hours: 2, minutes: 30);
const defaultPadding = EdgeInsets.symmetric(horizontal: 10, vertical: 5);

class ExampleSlideCountdown extends StatelessWidget {
  const ExampleSlideCountdown({Key? key}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Space"),
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
            const SlideCountdown(
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
            const SlideCountdown(
              duration: defaultDuration,
              padding: defaultPadding,
              slideDirection: SlideDirection.up,
              fade: true,
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
            const SlideCountdown(
              duration: defaultDuration,
              padding: defaultPadding,
              fade: true,
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
              fade: true,
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
```
## Output
[![output][]][output]

---

### 🚧 Maintener 
[![account avatar][]][github account] <br>
**Farhan Fadila** <br>
📫 How to reach me: farhan.fadila1717@gmail.com

### ❤️ Suport Maintener
[![badge paypal][]][paypal account] [![badge linktree][]][linktree account]


[cover]:https://github.com/farhanfadila1717/flutter_package/blob/master/display/slide_coutdown/slide_countdown.png
[pubdev]: https://pub.dev/packages/slide_countdown
[output]: https://github.com/farhanfadila1717/flutter_package/blob/master/display/slide_coutdown/output.gif
[flutter]: https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter
[web flutter]: https://flutter.dev
[account avatar]: https://avatars.githubusercontent.com/u/43161050?s=80
[github account]: https://github.com/farhanfadila1717
[badge linktree]: https://img.shields.io/badge/Donate-farhanfadila-orange
[linktree account]: https://linktr.ee/farhanfadila
[badge paypal]: https://img.shields.io/badge/Donate-PayPal-00457C?logo=paypal
[paypal account]: https://www.paypal.me/farhanfadila1717
