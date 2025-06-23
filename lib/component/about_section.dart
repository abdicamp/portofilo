import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home_page.dart';


class AboutSection extends StatefulWidget {
  Section currentSections; // gunakan `final` lebih baik
  AboutSection({Key? key, required this.currentSections});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  bool hasAnimated = false; // flag agar tidak animate ulang

  @override
  void initState() {
    super.initState();
    print(
        "widget.currentSection == Section.about : ${widget.currentSections == Section.about}");
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween<Offset>(
      begin: Offset(0, -1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(covariant AboutSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentSections == Section.about && !hasAnimated) {
      _controller.forward();
      hasAnimated = true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(
          begin: 0.0, end: widget.currentSections == Section.about ? 1.0 : 0.0),
      duration: Duration(seconds: 2),
      builder: (context, value, child) {
        return Container(
          height: 900,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black,
                Color.lerp(
                    Colors.black, Colors.white, value)!, // transisi ke putih
              ],
              stops: [0.0, 0.7],
            ),
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About Me",
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "I'm a passionate frontend developer with experience in building modern, responsive web applications using Flutter, React, and other cutting-edge technologies.",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Technologies I use:",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: const [
                  TechChip(label: "Flutter"),
                  TechChip(label: "Dart"),
                  TechChip(label: "React"),
                  TechChip(label: "JavaScript"),
                  TechChip(label: "Firebase"),
                  TechChip(label: "Git"),
                  TechChip(label: "Figma"),
                ],
              )
            ],
          ).animate().fade(duration: 800.ms).slideY(begin: 0.2),
        );
      },
    );
  }
}

class TechChip extends StatelessWidget {
  final String label;
  const TechChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.white,
      labelStyle: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.black87,
      ),
      side: const BorderSide(color: Colors.grey),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}
