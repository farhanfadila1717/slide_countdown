part of 'separated.dart';

class Separator extends StatelessWidget {
  const Separator({
    Key? key,
    required this.show,
    required this.separator,
    required this.style,
    this.padding,
  }) : super(key: key);

  final bool show;
  final String separator;
  final TextStyle style;
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
