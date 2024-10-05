# ⏱️ Slide Countdown
A Flutter package to create easy slide animation countdown / countup timer

[![flutter][]][web flutter] [![badge paypal][]][paypal account] [![badge linktree][]][linktree account] <br>

- ⏱️ Support Count down and Count up
- ⏯️ Control duration
- 🔔 Callback finished
- 🎨 Easily custom duration layout with `RawSlideCountdown` and `RawDigitItem` widget.

Thanks to [pausable_timer](https://pub.dev/packages/pausable_timer), this package use [pausable_timer](https://pub.dev/packages/pausable_timer) for helping control duration.

<img src="https://raw.githubusercontent.com/farhanfadila1717/flutter_package/master/display/likes_card.png" width="400" alt="likes card">
</img>

---

## 🌟 Open To Work

Farhan The author of this package is available for hiring as Flutter Engineer. See portofolio website [here](https://farhanfadila.site/).

---

## Example


### Basic Usange
```dart
  SlideCountdown(
    duration: Duration(days: 2),
  )
```
<!-- Output -->
<img src="https://raw.githubusercontent.com/farhanfadila1717/flutter_package/master/display/slide_coutdown/basic_slide_countdown.png" width="400" alt="basic slidecountdown">
</img>


```dart
  SlideCountdownSeparated(
    duration: Duration(days: 2),
  )
```
<!-- Output -->
<img src="https://raw.githubusercontent.com/farhanfadila1717/flutter_package/master/display/slide_coutdown/basic_slide_countdown_separatedd.png" width="400" alt="basic slidecountdown separated">
</img>

### Custom time unit
Set the time unit you want to display with this params
`shouldShowDays`, `shouldShowHours`, `shouldShowMinutes`, `shouldShowSeconds`.

```dart
  SlideCountdown(
    duration: Duration(days: 2),
    // Will show seconds only if duration in days is zero
    shouldShowMinutes: (duration) => duration.inDays == 0,
  )
```
<!-- Output -->

### Control duration
You can control duration e.g play, pause, resume, seek, add, subtract duration. See example [here](example/control_duration.dart)

<img src="https://raw.githubusercontent.com/farhanfadila1717/flutter_package/master/display/slide_coutdown/control_duration.png" width="400" alt="contoll duration">
</img>

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