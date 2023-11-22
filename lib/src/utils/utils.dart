import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';

/// {@template should_show_items}
/// ShouldShowItems is a type alias for a function that takes a
/// `Duration` as an argument
/// and returns a `bool`.
///
/// The purpose of this typedef is to define a standard signature for functions
/// that determine whether a set of items should be shown or not
/// based on a duration.
/// {@endtemplate}
typedef ShouldShowItems = bool Function(Duration);

/// {@template override_digits}
/// Default digits is 0-9 if you need change the digits e.g
/// with arabic number you can use this.
/// {@endtemplate}
typedef OverrideDigits = List<String>;

/// The default box decoration of [SlideCountdown]
const kDefaultBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(20)),
  color: Color(0xFFF23333),
);

/// The default box decoration of [SlideCountdownSeparated]
const kDefaultSeparatedBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(4)),
  color: Color(0xFFF23333),
);

/// The default padding
const kDefaultPadding = EdgeInsets.symmetric(
  horizontal: 10,
  vertical: 5,
);

/// The default separator padding
const kDefaultSeparatorPadding = EdgeInsets.symmetric(
  horizontal: 3,
);

/// The default text style
const kDefaultTextStyle = TextStyle(
  color: Color(0xFFFFFFFF),
  fontWeight: FontWeight.bold,
);

/// The default separator text style
const kDefaultSeparatorTextStyle =
    TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.bold);
