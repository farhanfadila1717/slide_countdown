part of 'separated.dart';

class BoxSeparated extends StatelessWidget {
  const BoxSeparated({
    Key? key,
    required this.height,
    required this.width,
    required this.child,
    required this.decoration,
  }) : super(key: key);

  final double height;
  final double width;
  final Widget child;
  final Decoration decoration;

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
