import 'package:flutter/widgets.dart';

/// {@template box_separated}
/// A custom widget that displays a container with a
/// specified height, width, decoration and child.
/// The `child` will be displayed in the center of
/// the container with a `Clip.hardEdge` behavior.
/// {@endtemplate}
class BoxSeparated extends StatelessWidget {
  /// {$macro box_separated}
  const BoxSeparated({
    required this.padding,
    required this.decoration,
    required this.child,
    super.key,
  });

  /// The padding of the container.
  final EdgeInsetsGeometry padding;

  /// The decoration of the container.
  final Decoration decoration;

  /// The widget to be displayed in the center of the container.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: decoration,
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      child: child,
    );
  }
}
