import 'package:flutter/material.dart';
import 'package:stream_duration/stream_duration.dart';

import 'duration_title.dart';
import 'enum.dart';
import 'utils.dart';

abstract class SlideCountdownBase extends StatefulWidget {
  const SlideCountdownBase({
    super.key,
    required this.duration,
    required this.textStyle,
    required this.separatorStyle,
    required this.icon,
    required this.suffixIcon,
    required this.separator,
    required this.replacement,
    required this.onDone,
    required this.durationTitle,
    required this.separatorType,
    required this.slideDirection,
    required this.padding,
    required this.separatorPadding,
    required this.showZeroValue,
    required this.decoration,
    required this.curve,
    required this.countUp,
    required this.infinityCountUp,
    required this.slideAnimationDuration,
    required this.digitsNumber,
    required this.streamDuration,
    required this.onChanged,
    required this.shouldShowDays,
    required this.shouldShowHours,
    required this.shouldShowMinutes,
    required this.shouldShowSeconds,
    required this.countUpAtDuration,
  }) : assert(
          duration != null || streamDuration != null,
          'Either duration or streamDuration has to be provided',
        );

  /// [Duration] is the duration of the countdown slide,
  /// if the duration has finished it will call [onDone]
  final Duration? duration;

  /// [TextStyle] is a parameter for all existing text,
  /// if this is null [SlideCountdown] has a default
  /// text style which will be of all text
  final TextStyle textStyle;

  /// [TextStyle] is a parameter for all existing text,
  /// if this is null [SlideCountdown] has a default
  /// text style which will be of all text
  final TextStyle separatorStyle;

  /// [icon] is a parameter that can be initialized by any widget e.g [Icon],
  /// this will be in the first order, default empty widget
  final Widget? icon;

  /// [icon] is a parameter that can be initialized by any widget e.g [Icon],
  /// this will be in the end order, default empty widget
  final Widget? suffixIcon;

  /// Separator is a parameter that will separate each [duration],
  /// e.g hours by minutes, and you can change the [SeparatorType] of the symbol or title
  final String? separator;

  /// A widget that will be displayed to replace
  /// the countdown when the remaining [duration] has finished
  /// if null  default widget is [SizedBox].
  final Widget? replacement;

  /// function [onDone] will be called when countdown is complete
  final VoidCallback? onDone;

  /// {$macro separator_type}
  final SeparatorType separatorType;

  /// change [Duration Title] if you want to change the default language,
  /// which is English, to another language, for example, into Indonesian
  /// pro tips: if you change to Indonesian, we have default values [DurationTitle.id()]
  final DurationTitle? durationTitle;

  /// The decoration to paint in front of the [child].
  final Decoration decoration;

  /// The amount of space by which to inset the child.
  final EdgeInsets padding;

  /// The amount of space by which to inset the [separator].
  final EdgeInsets separatorPadding;

  /// if you initialize it with false, the duration which is empty will not be displayed
  final bool showZeroValue;

  /// {@macro slide_direction}
  final SlideDirection slideDirection;

  /// to customize curve in [TextAnimation] you can change the default value
  /// default [Curves.easeOut]
  final Curve curve;

  ///this property allows you to do a count up, give it a value of true to do it
  final bool countUp;

  ///this property allows you to count up at the duration you set
  final bool? countUpAtDuration;

  /// if you set this property value to true, it will do the count up continuously or infinity
  /// and the [onDone] property will never be executed,
  /// before doing that you need to set true to the [countUp] property,
  final bool infinityCountUp;

  /// SlideAnimationDuration which will be the duration of the slide animation from above or below
  final Duration slideAnimationDuration;

  /// {@macro override_digits}
  final OverrideDigits? digitsNumber;

  /// If you ovveride [StreamDuration] package for stream a duration
  /// property [duration], [countUp], [infinityCountUp], and [onDone] in [SlideCountdown] not affected
  /// Example you need use function in [StreamDuration]
  /// e.g correct, add, and subtract function
  final StreamDuration? streamDuration;

  /// if you need to stream the remaining available duration,
  /// it will be called every time the duration changes.
  final ValueChanged<Duration>? onChanged;

  /// This will trigger the days item will show or hide from the return value
  /// You can also show or hide based on the remaining duration
  /// e.g shouldShowDays: (`Duration` remainingDuration) => remainingDuration.inDays >= 1
  /// if null and [showZeroValue] is false
  /// when duration in days is zero it will return false
  final ShouldShowItems? shouldShowDays;

  /// This will trigger the hours item will show or hide from the return value
  /// You can also show or hide based on the remaining duration
  /// e.g shouldShowHours: () => remainingDuration.inHours >= 1
  /// if null and [showZeroValue] is false
  /// when duration in hours is zero it will return false
  final ShouldShowItems? shouldShowHours;

  /// This will trigger the minutes item will show or hide from the return value
  /// You can also show or hide based on the remaining duration
  /// e.g shouldShowMinutes: () => remainingDuration.inMinutes >= 1
  /// if null and [showZeroValue] is false
  /// when duration in minutes is zero it will return false
  final ShouldShowItems? shouldShowMinutes;

  /// This will trigger the minutes item will show or hide from the return value
  /// You can also show or hide based on the remaining duration
  /// e.g shouldShowSeconds: () => remainingDuration.inSeconds >= 1
  /// if null and [showZeroValue] is false
  /// when duration in seconds is zero it will return false
  final ShouldShowItems? shouldShowSeconds;
}
