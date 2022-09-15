## [![cover][]][pubdev]
[![flutter][]][web flutter] [![badge paypal][]][paypal account] [![badge linktree][]][linktree account] <br>
A Flutter package to create easy slide animation countdown / countup timer.

---

## Example SlideCountdown

#### Slidecountdown(Default)
```dart
SlideCountdown(
  duration: const Duration(days: 2),
)
```
#### Output SlideCountdown(Default)
[![slidecountdown][]][slidecountdown]

<br>

#### SlideCountdownSeparated(Default)
```dart
SlideCountdownSeparated(
  duration: const Duration(days: 2),
)
```
#### Output SlideCountdownSeparated(Default)
[![slidecountdown separated][]][slidecountdown separated]

<br>

#### Slidecountdown countUp
```dart
SlideCountdown(
  duration: const Duration(days: 2),
  countUp: true,
)
```
#### Output Slidecountdown countUp
[![slidecountdown countup][]][slidecountdown countup]

<br>

#### Slidecountdown sparatorType.title
```dart
SlideCountdown(
  duration: const Duration(days: 2),
  separatorType: SeparatorType.title,
  slideDirection: SlideDirection.up,
)
```
#### Output Slidecountdown sparatorType.title
[![slidecountdown separatortype][]][slidecountdown separatortype]


## Example control duration
If you want to control duration more advanced, you can override property `StreamDuration`. <br>
You can `play`, `pause`, `change`, `add`, `subtract` duration.

> If you override/custom `StreamDuration` duration property has no effect anymore. <br>
> See Full example control duration [here](https://github.com/farhanfadila1717/slide_countdown/blob/master/example/example.dart#L111).

```dart
final streamDuration = StreamDuration(const Duration(hours: 2));

SlideCountdown(
  // This duration no effect if you customize stream duration
  duration: const Duration(seconds: 10),
  streamDuration: streamDuration,
),
```


---

### 🚧 Maintener 
[![account avatar][]][github account] <br>
**Farhan Fadila** <br>
📫 How to reach me: farhan.fadila1717@gmail.com

### ❤️ Suport Maintener
[![badge paypal][]][paypal account] [![badge linktree][]][linktree account]


[cover]:https://github.com/farhanfadila1717/flutter_package/blob/master/display/slide_coutdown/slide_countdown.png
[slidecountdown]: https://github.com/farhanfadila1717/flutter_package/blob/master/display/slide_coutdown/slidecountdown.gif
[slidecountdown separated]: https://github.com/farhanfadila1717/flutter_package/blob/master/display/slide_coutdown/slidecountdown_separated.gif
[slidecountdown countup]: https://github.com/farhanfadila1717/flutter_package/blob/master/display/slide_coutdown/slidecountdown_countup.gif
[slidecountdown separatortype]: https://github.com/farhanfadila1717/flutter_package/blob/master/display/slide_coutdown/slidecountdown_separatortype.gif 
[pubdev]: https://pub.dev/packages/slide_countdown
[flutter]: https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter
[web flutter]: https://flutter.dev
[account avatar]: https://avatars.githubusercontent.com/u/43161050?s=80
[github account]: https://github.com/farhanfadila1717
[badge linktree]: https://img.shields.io/badge/Donate-farhanfadila-orange
[linktree account]: https://linktr.ee/farhanfadila
[badge paypal]: https://img.shields.io/badge/Donate-PayPal-00457C?logo=paypal
[paypal account]: https://www.paypal.me/farhanfadila1717
[stream duration]: https://pub.dev/packages/stream_duration