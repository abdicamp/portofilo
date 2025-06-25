import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullscreenVideoDialog extends StatefulWidget {
  final VideoPlayerController controller;

  const FullscreenVideoDialog({super.key, required this.controller});

  @override
  State<FullscreenVideoDialog> createState() => FullscreenVideoDialogState();
}

class FullscreenVideoDialogState extends State<FullscreenVideoDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.black,
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (widget.controller.value.isPlaying) {
              widget.controller.pause();
            } else {
              widget.controller.play();
            }
          });
        },
        onDoubleTap: () => Navigator.of(context).pop(),
        child: Center(
          child: AspectRatio(
            aspectRatio: widget.controller.value.aspectRatio,
            child: VideoPlayer(widget.controller),
          ),
        ),
      ),
    );
  }
}
