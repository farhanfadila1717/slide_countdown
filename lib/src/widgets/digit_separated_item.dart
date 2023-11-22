import 'package:flutter/widgets.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:slide_countdown/src/models/base_digit.dart';
import 'package:slide_countdown/src/utils/extensions.dart';
import 'package:slide_countdown/src/widgets/box_separated.dart';
import 'package:slide_countdown/src/widgets/separator.dart';

/// {@template digit_separated_item}
/// A widget that displays a digit item with a separator inside a box.
///
/// Inherits all the properties of the [BaseDigits] class.
/// {@endtemplate}
class DigitSeparatedItem extends BaseDigits {
  /// {@macro digit_separated_item}
  const DigitSeparatedItem({
    required super.duration,
    required super.timeUnit,
    required super.padding,
    required super.decoration,
    required super.style,
    required super.separatorStyle,
    required super.slideDirection,
    required super.countUp,
    required super.separator,
    required super.textDirection,
    required super.showSeparator,
    super.key,
    super.separatorPadding,
    super.digitsNumber,
  });

  @override
  Widget build(BuildContext context) {
    final digits = <Widget>[];

    if (timeUnit == TimeUnit.days && duration.inDays > 999) {
      digits.add(
        RawDigitItem(
          duration: duration,
          timeUnit: timeUnit,
          digitType: DigitType.daysThousand,
          countUp: countUp,
          style: style,
          slideDirection: slideDirection,
          digitsNumber: digitsNumber,
        ),
      );
    }

    if (timeUnit == TimeUnit.days && duration.inDays > 99) {
      digits.add(
        RawDigitItem(
          duration: duration,
          timeUnit: timeUnit,
          digitType: DigitType.daysHundred,
          countUp: countUp,
          style: style,
          slideDirection: slideDirection,
          digitsNumber: digitsNumber,
        ),
      );
    }

    digits.addAll(
      [
        RawDigitItem(
          duration: duration,
          timeUnit: timeUnit,
          digitType: DigitType.first,
          countUp: countUp,
          style: style,
          slideDirection: slideDirection,
          digitsNumber: digitsNumber,
        ),
        RawDigitItem(
          duration: duration,
          timeUnit: timeUnit,
          digitType: DigitType.second,
          countUp: countUp,
          style: style,
          slideDirection: slideDirection,
          digitsNumber: digitsNumber,
        ),
      ],
    );

    final separatorWidget = showSeparator
        ? Separator(
            padding: separatorPadding,
            show: true,
            separator: separator,
            style: separatorStyle,
          )
        : const SizedBox.shrink();

    final box = BoxSeparated(
      padding: padding,
      decoration: decoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: digits,
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children:
          textDirection.isRtl ? [separatorWidget, box] : [box, separatorWidget],
    );
  }
}
