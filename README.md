## [![cover][]][pubdev]
# ⏱️ Slide Countdown
A Flutter package to create easy slide animation countdown / countup timer

[![flutter][]][web flutter] [![badge paypal][]][paypal account] [![badge linktree][]][linktree account] <br>

- ⏱️ Support Count down and Count up
- ⏯️ Controll duration with [StreamDuration](https://pub.dev/packages/stream_duration) package
- 🔔 Callback finished
- 🎨 Easily custom duration layout with `RawSlideCountdown` and `RawDigitItem` widget.

<img src="https://raw.githubusercontent.com/farhanfadila1717/flutter_package/master/display/likes_card.png" width="400" alt="likes card">
</img>

---

## 🌟 Open To Work

Farhan The author of this package is available for hiring as Flutter Engineer. See portofolio website [here](https://farhanfadila.site/).

---

## Example

### Slidecountdown(Default)

```dart
SlideCountdown(
  duration: const Duration(days: 2),
)
```

### Output SlideCountdown(Default)

[![slidecountdown][]][slidecountdown]

### SlideCountdownSeparated(Default)

```dart
SlideCountdownSeparated(
  duration: const Duration(days: 2),
)
```

### Output SlideCountdownSeparated(Default)

[![slidecountdown separated][]][slidecountdown separated]

### CountUp is True

When the countup value is the same as the duration, it will call onDone. If you do not set a duration, the countup will continue infinitely and onDone will never be called.

```dart
SlideCountdown(
  duration: const Duration(days: 2),
  countUp: true,
)
```

### Output Slidecountdown countUp

[![slidecountdown countup][]][slidecountdown countup]


### Slidecountdown sparatorType.title

```dart
SlideCountdown(
  duration: const Duration(days: 2),
  separatorType: SeparatorType.title,
  slideDirection: SlideDirection.up,
)
```

### Output Slidecountdown sparatorType.title

[![slidecountdown separatortype][]][slidecountdown separatortype]

---

## 🎨 Full Customize Slidecountdown

You can full customize slidecountdown with `RawSlideCountdown` and `RawDigitItem`
see example [here](https://github.com/farhanfadila1717/slide_countdown/blob/master/example/example_raw_slide_countdown.dart)

## Example Output Customize Slidecountdown

<img src="https://raw.githubusercontent.com/farhanfadila1717/flutter_package/master/display/slide_coutdown/raw_slide_countdown.png" width="300" alt="paypal farhan fadila">
</img>

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

### 🚧 Maintainer

<a href="https://github.com/farhanfadila1717">
<img src="https://avatars.githubusercontent.com/u/43161050?s=100" alt="farhan fadila"  style="border-radius: 10px">
</img>
</a>

**Farhan Fadila**

📫 Email: farhan.fadila1717@gmail.com

⛳ Website: [farhanfadila.site](https://farhanfadila.site/)

### ❤️ Donate for support this open source

<a href="https://www.paypal.me/farhanfadila1717" style="margin-right: 10px">
<img src="https://raw.githubusercontent.com/farhanfadila1717/flutter_package/master/display/btn_paypal.png" width="150" alt="paypal farhan fadila">
</img>
</a>
<a href="https://linktr.ee/farhanfadila">
<img src="https://raw.githubusercontent.com/farhanfadila1717/flutter_package/master/display/btn_linktree.png" width="150" alt="linktree farhan fadila">
</img>
</a>


[cover]: https://raw.githubusercontent.com/farhanfadila1717/flutter_package/master/display/slide_coutdown/slide_countdown.png
[slidecountdown]: https://raw.githubusercontent.com/farhanfadila1717/flutter_package/master/display/slide_coutdown/slidecountdown.gif
[slidecountdown separated]: https://raw.githubusercontent.com/farhanfadila1717/flutter_package/master/display/slide_coutdown/slidecountdown_separated.gif
[slidecountdown countup]: https://raw.githubusercontent.com/farhanfadila1717/flutter_package/master/display/slide_coutdown/slidecountdown_countup.gif
[slidecountdown separatortype]: https://raw.githubusercontent.com/farhanfadila1717/flutter_package/master/display/slide_coutdown/slidecountdown_separatortype.gif
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
[qr-paypal]: https://raw.githubusercontent.com/farhanfadila1717/flutter_package/master/display/qr-paypal.png
[raw-slidecountdown]: https://raw.githubusercontent.com/farhanfadila1717/flutter_package/master/display/slide_coutdown/raw_slide_countdown.png