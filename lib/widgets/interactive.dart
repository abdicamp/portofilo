import 'package:flutter/material.dart';

class InteractiveTilt extends StatefulWidget {
  final Widget child;
  const InteractiveTilt({super.key, required this.child});

  @override
  State<InteractiveTilt> createState() => _InteractiveTiltState();
}

class _InteractiveTiltState extends State<InteractiveTilt> {
  double _x = 0, _y = 0;

  void _onHover(PointerEvent event, Size size) {
    final dx = (event.localPosition.dx - size.width / 2) / (size.width / 2);
    final dy = (event.localPosition.dy - size.height / 2) / (size.height / 2);
    setState(() {
      _x = dy;
      _y = -dx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) => _onHover(event, context.size ?? const Size(300, 600)),
      onExit: (_) => setState(() {
        _x = 0;
        _y = 0;
      }),
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(_x * 0.2)
          ..rotateY(_y * 0.2),
        child: widget.child,
      ),
    );
  }
}
