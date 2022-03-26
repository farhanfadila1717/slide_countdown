part of 'separated.dart';

class BoxSeparated extends StatelessWidget {
  const BoxSeparated({
    Key? key,
    required this.height,
    required this.width,
    required this.child,
    required this.decoration,
    required this.gradientColors,
    required this.fade,
  }) : super(key: key);

  final double height;
  final double width;
  final Widget child;
  final Decoration decoration;
  final List<Color> gradientColors;
  final bool fade;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: decoration,
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      child: ShaderMask(
        shaderCallback: (Rect rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColors,
            stops: const [0.05, 0.3, 0.7, 0.95],
          ).createShader(rect);
        },
        child: Visibility(
          visible: fade,
          child: SizedBox.expand(child: child),
          replacement: ClipRect(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
