## 2.0.3-dev.1
- [feat: add shouldDispose parameter to manage StreamDuration disposal](https://github.com/farhanfadila1717/slide_countdown/pull/76). Thanks to [ColtonDevAcc](https://github.com/ColtonDevAcc)

## 2.0.2

- docs: readme update


## 2.0.1

- [feat: ability to custom slide animation duration](https://github.com/farhanfadila1717/slide_countdown/commit/a8898b505b0b0c2848a0ed9b91030e754c99e7d2)


- [feat: add custom slide animation curve](https://github.com/farhanfadila1717/slide_countdown/commit/97ce310b08c74b4aa5b63d119b392406523eca3c)

## 2.0.0
- refactor stream duration to use [pausable_timer](https://pub.dev/packages/pausable_timer) package

## 1.6.1
- Fix RTL digit position [#63](https://github.com/farhanfadila1717/slide_countdown/pull/63). thanks to [F2had](https://github.com/F2had)

## 1.6.0
- fix issue [#61](https://github.com/farhanfadila1717/slide_countdown/issues/61) count up min max digit. thanks to [clayzx](https://github.com/clayzx)

## 1.5.2

- update README

## 1.5.1

- fix(Accessbility): add semantic for talkback/voice over

## 1.5.0

- fix: first digit trigger animation

## 1.4.0

- fix: `RawDigitItem` trigger animation

## 1.3.5

- refactor: reset `AnimationController` with listen animation status instead async callback

## 1.3.4

- fix: animation when `StreamDuration` is stop

## 1.3.3

- fix: animation when `StreamDuration` autoPlay is false

## 1.3.2

- fix: AnimationController using after disposed.

## 1.3.1

- Add more docs
- remove `slideAnimationDuration` and `curve`

## 1.3.0

- refactor: `RawDigitAnimation`

## 1.2.2

- remove `textStyle` replace to `style`
- fix unexpected digit [#53](https://github.com/farhanfadila1717/slide_countdown/issues/53)

## 1.2.1

- remove print

## 1.2.0

- refactor `RawSlideCountdown` builder pass `countUp` params
- fix `RawDigitItem` currentValue and nextValue

## 1.1.1

- `RawSlideCountdown` cancelOnError true

## 1.1.0

- refactor: `RawSlideCountdown` with `ValueListenableBuilder` instead of `StreamBuilder`
- add topics pubspec.yaml

## 1.0.2

- fix: [#50](https://github.com/farhanfadila1717/slide_countdown/issues/50) Bad state: Stream has already been listened to

## 1.0.1

- fix: datetime extensions

## 1.0.0

- add `RawDigitItem`, `RawSlideCountdown`
- refactor `SlideCountdownSeparated` to use `RawSlideCountdown`
- bump min `StreamDuration` packages to `4.2.0`, min flutter sdk `3.0.0`
- pubspec add `issue_tracker`

## 0.5.0

- bump min dart sdk to `2.17.0`

## 0.4.1

- `pubspec.yaml` added screenshot

## 0.4.0

- Remove depercated API
- `duration` is'nt longer required when override duration with `stream_duration`
- bump `stream_duration` package to `0.3.0`

## 0.3.4

- Readme add example control duration
- Update example

## 0.3.3

- Fix separator

## 0.3.2

- [Adds greek locale](https://github.com/farhanfadila1717/slide_countdown/pull/24)

## 0.3.1

- Fix: [SlideCountdown does not work with onChanged.](https://github.com/farhanfadila1717/slide_countdown/issues/23)

## 0.3.0

- Add `shouldShowDays`, `shouldShowHours`, `shouldShowMinutes`, `shouldShowSeconds` to configure what items to show up
- Add `replacement` widget

## 0.2.12

- [Add arabic localization](https://github.com/farhanfadila1717/slide_countdown/pull/21)

## 0.2.11

- Fix override `hashCode` exception for support Flutter <= 2.5.0

## 0.2.10

- depercated `fade` property

## 0.2.9

- Fix: [Fixed RTL digit directions](https://github.com/farhanfadila1717/slide_countdown/pull/19)

## 0.2.8

- Fix: [minutes separator](https://github.com/farhanfadila1717/slide_countdown/pull/15) `SlideCountdown`

## 0.2.7

- Change: default value `withDays` to true.

## 0.2.6

- Add: `onChanged` property, `TextWithoutAnimation` widget
- Change: bump min version `StreamDuration` package
- Fix: `SlideDirection.none` animation, digit clipper, `withDays` property.

## 0.2.5

- Add: SlideDirection.none,

## 0.2.4

- Add: streamDuration property, test & coverage
- Fix: didUpdateWidget

## 0.2.3

- Allow override digits

## 0.2.2

- Fix linter

## 0.2.1

- [PR #7 Add more localization `DurationTitle`](https://github.com/farhanfadila1717/slide_countdown/pull/7)

## 0.2.0

- TextDirection rtl slot
- Change base to stateless
- Refactor codebase
- Separed widget
- Upgrade: stream_duration package

## 0.1.2

- Upgrade: Fix Linter

## 0.1.1

- Upgrade: stream_duration package

## 0.0.9

- Release: (Countdown) default text from 0 to actual duration

## 0.0.8

- add: slideAnimationDuration, onDurationChanged
- fix: value listener null value, [#3](https://github.com/farhanfadila1717/slide_countdown/issues/3#issue-1077536704)

## 0.0.7

- fix: unconstant value

## 0.0.6

- release: countUp, countup infinity
- change: default padding slidecountdown
- docs: update readme.md

## 0.0.5

- release: SlidecountdownSeparated

## 0.0.4

- Fix separator padding
- Add documentation
- Change package description
- New Example

## 0.0.3

- Fix animation issue

## 0.0.2

- Improve fade transition

## 0.0.1

- Add fade transition
