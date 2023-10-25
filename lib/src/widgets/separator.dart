import 'package:flutter/widgets.dart';

/// {@template separator}
/// This class is used to create a separator widget.
///
/// `Separator` is a [StatelessWidget] that displays a separator based on
/// the provided `separator` string and `style`. The visibility of
/// the separator can be controlled by the `show` flag.
/// {@endtemplate}
class Separator extends StatelessWidget {
  const Separator({
    super.key,
    required this.show,
    required this.separator,
    required this.style,
    this.padding,
  });

  /// A flag that determines whether the separator should be displayed or not.
  final bool show;

  /// The string that represents the separator to be displayed.
  final String separator;

  /// The [TextStyle] that defines the appearance of the separator text.
  final TextStyle style;

  /// An [EdgeInsets] value that defines the padding around the separator.
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    if (!show) return const SizedBox.shrink();
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        separator,
        style: style,
      ),
    );
  }
}
