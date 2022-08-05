part of 'separated.dart';

class BoxSeparated extends StatelessWidget {
  const BoxSeparated({
    Key? key,
    required this.height,
    required this.width,
    required this.child,
    required this.decoration,
    required this.fade,
  }) : super(key: key);

  final double height;
  final double width;
  final Widget child;
  final Decoration decoration;
  final bool fade;

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
