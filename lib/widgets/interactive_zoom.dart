import 'package:flutter/material.dart';

class ZoomOnHoverImage extends StatefulWidget {
  final String imagePath;

  const ZoomOnHoverImage({super.key, required this.imagePath});

  @override
  State<ZoomOnHoverImage> createState() => _ZoomOnHoverImageState();
}

class _ZoomOnHoverImageState extends State<ZoomOnHoverImage> {
  bool _isHovered = false;

  void _openFullScreenImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: InteractiveViewer(
            child: Image.asset(widget.imagePath),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => _openFullScreenImage(context),
        child: AnimatedScale(
          scale: _isHovered ? 1.1 : 1.0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Image.asset(widget.imagePath),
        ),
      ),
    );
  }
}
