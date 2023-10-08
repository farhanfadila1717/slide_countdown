import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';

typedef RawSlideCountdownBuilder = Widget Function(
  BuildContext context,
  Duration duration,
);

class RawSlideCountdown extends StatefulWidget {
  const RawSlideCountdown({
    super.key,
    required this.streamDuration,
    required this.builder,
  });

  final StreamDuration streamDuration;
  final RawSlideCountdownBuilder builder;

  @override
  State<RawSlideCountdown> createState() => _RawSlideCountdownState();
}

class _RawSlideCountdownState extends State<RawSlideCountdown> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: widget.streamDuration.durationLeft,
      builder: (_, snapshoot) {
        if (snapshoot.hasData) {
          return widget.builder(context, snapshoot.data!);
        }

        return SizedBox.shrink();
      },
    );
  }
}
