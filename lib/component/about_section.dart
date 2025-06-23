import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../home_page.dart';

class AboutSection extends StatefulWidget {
  ScrollController scrollController;
  Section currentSections; // gunakan `final` lebih baik
  AboutSection({
    Key? key,
    required this.currentSections,
    required this.scrollController,
  });

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  bool hasAnimated = false; // flag agar tidak animate ulang
  double _scale = 1.0;
  double _scaleText = 0.9;
  double values = 0.0;
  double gradientFadeOpacity = 1.0;

  final aboutMeParagraph = [
    "I'm a Software Engineer with 4+ years of experience crafting full-stack applications and IoT solutions.",
    "As a Flutter developer, I’ve built scalable apps across domains — from Human Resource Systems to E-Commerce platforms.",
    "On the backend, I use Node.js and SQL queries to deliver reliable APIs.",
    "I also build IoT systems that bridge hardware and software for smart, connected experiences.",
    "I love turning real-world problems into elegant, scalable digital solutions.",
  ];

  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(() {
      final offset = widget.scrollController.offset;
      double scale;

      if (offset <= 1000) {
        // Membesar dari 1.0 ke 1.5
        double diff = offset - 500;
        double t = (diff / 500).clamp(0.0, 1.0);
        scale = (1.0 + (diff / 500)).clamp(1.0, 1.5);
        _scaleText = lerpDouble(0.8, 1.0, t)!;
      } else {
        // Mengecil kembali dari 1.5 ke 1.0
        double diff = offset - 1000;
        double t = (diff / 500).clamp(0.0, 1.0);
        scale = (1.5 - (diff / 500)).clamp(1.0, 1.5);
        _scaleText = lerpDouble(1.0, 0.8, t)!;
      }

      setState(() {
        _scale = scale;
        values = (offset / 150).clamp(0.0, 1.0);
        print("_scale : $_scale");
      });
    });

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
    widget.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size =
        MediaQuery.of(context).size.width * 0.9; // 80% dari lebar layar

    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      height: 1000,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.lerp(
                Colors.white, Colors.black, values)!, // dari putih ke hitam
            Colors.white, // setengah bawah tetap putih
          ],
          stops: [0.0, 0.5], // gradasi hanya sampai setengah
        ),
      ),
      width: double.infinity,
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.lerp(Colors.white, Colors.black,
                            values)!, // dari putih ke hitam
                        Colors.white, // setengah bawah tetap putih
                      ],
                      stops: [0.0, 0.5], // gradasi setengah atas
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcIn,
                  child: Text(
                    "About Me",
                    style: GoogleFonts.poppins(
                      fontSize: 56,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                      height: 1.2,
                      color:
                          Colors.white, // tetap putih agar ShaderMask bekerja
                    ),
                  ),
                ),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutBack, // efek mantul saat timbul
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.scale(
                        scale: value,
                        child: child,
                      ),
                    );
                  },
                  child: Lottie.asset(
                    'assets/animation/aboutme.json',
                    width: size,
                    height: size,
                    repeat: true,
                    reverse: false,
                    animate: true,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: aboutMeParagraph.asMap().entries.map((entry) {
                    int index = entry.key;
                    String line = entry.value;

                    return TweenAnimationBuilder<double>(
                      tween: Tween(
                          begin: 0.0,
                          end: widget.currentSections != Section.hero
                              ? 1.0
                              : 0.0),
                      duration: Duration(milliseconds: 600 + index * 200),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, (1 - value) * 20),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Text(
                                line,
                                style: GoogleFonts.poppins(
                                    fontSize: 13, height: 1.6),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ).animate().fade(duration: 800.ms).slideY(begin: 0.2)
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Transform.scale(
                    scale: _scaleText,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "About Me",
                          style: GoogleFonts.poppins(
                            fontSize: 56,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.5,
                            height: 1.2,
                            color: const Color.fromARGB(255, 58, 58,
                                58), // tetap putih agar ShaderMask bekerja
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              aboutMeParagraph.asMap().entries.map((entry) {
                            int index = entry.key;
                            String line = entry.value;

                            return TweenAnimationBuilder<double>(
                              tween: Tween(
                                  begin: 0.0,
                                  end: widget.currentSections != Section.hero
                                      ? 1.0
                                      : 0.0),
                              duration:
                                  Duration(milliseconds: 1000 + index * 500),
                              builder: (context, value, child) {
                                return Opacity(
                                  opacity: value,
                                  child: Transform.translate(
                                    offset: Offset(0, (1 - value) * 20),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: Text(
                                        line,
                                        textAlign: TextAlign.justify,
                                        style: GoogleFonts.poppins(
                                            fontSize: 18, height: 1.6),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Transform.scale(
                    scale: _scale,
                    child: Lottie.asset(
                      'assets/animation/aboutme.json',
                      width: 500,
                      height: 500,
                      reverse: false,
                      animate: true,
                      repeat: true,
                    ),
                  ),
                ),
              ],
            ).animate().fade(duration: 800.ms).slideY(begin: 0.2),
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
