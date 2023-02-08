part of 'separated.dart';

/// {@template box_separated}
/// A custom widget that displays a container with a
/// specified height, width, decoration and child.
/// The `child` will be displayed in the center of
/// the container with a `Clip.hardEdge` behavior.
/// {@endtemplate}
class BoxSeparated extends StatelessWidget {
  /// {$macro box_separated}
  const BoxSeparated({
    super.key,
    required this.height,
    required this.width,
    required this.decoration,
    required this.child,
  });

  /// The height of the container.
  final double height;

  /// The width of the container.
  final double width;

  /// The decoration of the container.
  final Decoration decoration;

  /// The widget to be displayed in the center of the container.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: decoration,
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      child: child,
    );
  }
}
