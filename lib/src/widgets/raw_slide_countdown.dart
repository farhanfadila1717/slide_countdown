import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';

class RawSlideCountdown extends StatefulWidget {
  const RawSlideCountdown({
    super.key,
    required this.streamDuration,
  });

  final StreamDuration streamDuration;

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
          return Wrap(
            children: [],
          );
        }

        return SizedBox.shrink();
      },
    );
  }
}
