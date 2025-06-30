import 'dart:ui';
import 'dart:html' as html;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:portofilo/widgets/switch_langguage.dart';

class HeroSection extends StatefulWidget {
  ScrollController scrollController;
  HeroSection({super.key, required this.scrollController});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  double _scale = 1.0;
  double values = 0.0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      final offset = widget.scrollController.offset;
      final start = 0.0;
      final end = 900;

      // Hitung skala: makin ke bawah makin besar (maks 1.5x)
      final progress = ((offset - start) / (end - start)).clamp(0.0, 1.0);
      final newScale = 1.0 + (offset / 300.0).clamp(0.0, 0.5); // max 1.5x
      setState(() {
        _scale = newScale;
        values = progress;
      });
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true); // Loop animasi

    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.3, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size =
        MediaQuery.of(context).size.width * 0.9; // 80% dari lebar layar
    final isMobile = MediaQuery.of(context).size.width < 600;
    final langCode = context.locale.languageCode;

    return Container(
      height: 900,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Color.lerp(
                Colors.white, Colors.black, values)!, // dari putih ke hitam
          ],
          stops: [0.0, 2.0], // gradasi hanya sampai setengah
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Lingkaran gradasi ungu di tengah
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Opacity(
                opacity: _opacityAnimation.value,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: child,
                ),
              );
            },
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                gradient: RadialGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
          ),
          // Konten utama

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
            child: isMobile
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text Section
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Lottie.asset(
                            //   'assets/animation/terminal.json',
                            //   width: 30,
                            //   height: 30,
                            //   repeat: true,
                            //   reverse: false,
                            //   animate: true,
                            // ),
                            AnimatedTextKit(
                              key: ValueKey(context.locale.languageCode),
                              totalRepeatCount: 1,
                              pause: const Duration(milliseconds: 1000),
                              displayFullTextOnTap: true,
                              stopPauseOnTap: true,
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  'hello'.tr(),
                                  textStyle: GoogleFonts.poppins(
                                    fontSize: 48,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  speed: const Duration(milliseconds: 300),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'title_hero_section'.tr(),
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'sub_title_hero_section'.tr(),
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 10),
                            langCode == 'en'
                                ? OutlinedButton(
                                    onPressed: () {
                                      html.AnchorElement anchorElement =
                                          html.AnchorElement(
                                              href:
                                                  'assets/CV_Muhammad_Abdillah_Dzikri_en.pdf');
                                      anchorElement.download =
                                          "CV_Muhammad_Abdillah_Dzikri.pdf";
                                      anchorElement.click();
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          color: Colors.white), // warna bingkai
                                      backgroundColor:
                                          Colors.transparent, // transparan
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      "cv".tr(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                : OutlinedButton(
                                    onPressed: () {
                                      html.AnchorElement anchorElement =
                                          html.AnchorElement(
                                              href:
                                                  'assets/CV_Muhammad_Abdillah_Dzikri.pdf');
                                      anchorElement.download =
                                          "CV_Muhammad_Abdillah_Dzikri.pdf";
                                      anchorElement.click();
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          color: Colors.white), // warna bingkai
                                      backgroundColor:
                                          Colors.transparent, // transparan
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      "cv".tr(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                          ],
                        ),
                      ),
                      const SizedBox(width: 40),
                      // Image Section
                      Expanded(
                        flex: 2,
                        child: Transform.scale(
                          scale: _scale,
                          child: Lottie.asset(
                            'assets/animation/development.json',
                            height: 500,
                            width: 500,
                            repeat: true,
                            reverse: false,
                            animate: true,
                          ),
                        ),
                      ),
                    ],
                  ).animate().fade(duration: 800.ms).slideY(begin: 0.2)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text Section

                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedTextKit(
                              key: ValueKey(context.locale.languageCode),
                              totalRepeatCount: 1,
                              pause: const Duration(milliseconds: 1000),
                              displayFullTextOnTap: true,
                              stopPauseOnTap: true,
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  'hello'.tr(),
                                  textStyle: GoogleFonts.poppins(
                                    fontSize: 48,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  speed: const Duration(milliseconds: 300),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'title_hero_section'.tr(),
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'sub_title_hero_section'.tr(),
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 10),
                            langCode == 'en'
                                ? OutlinedButton(
                                    onPressed: () {
                                      html.AnchorElement anchorElement =
                                          html.AnchorElement(
                                              href:
                                                  'assets/CV_Muhammad_Abdillah_Dzikri_en.pdf');
                                      anchorElement.download =
                                          "CV_Muhammad_Abdillah_Dzikri.pdf";
                                      anchorElement.click();
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          color: Colors.white), // warna bingkai
                                      backgroundColor:
                                          Colors.transparent, // transparan
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      "cv".tr(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                : OutlinedButton(
                                    onPressed: () {
                                      html.AnchorElement anchorElement =
                                          html.AnchorElement(
                                              href:
                                                  'assets/CV_Muhammad_Abdillah_Dzikri.pdf');
                                      anchorElement.download =
                                          "CV_Muhammad_Abdillah_Dzikri.pdf";
                                      anchorElement.click();
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          color: Colors.white), // warna bingkai
                                      backgroundColor:
                                          Colors.transparent, // transparan
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      "cv".tr(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                          ],
                        ),
                      ),
                      const SizedBox(width: 40),
                      // Image Section
                      Expanded(
                        flex: 2,
                        child: Transform.scale(
                          scale: _scale,
                          child: Lottie.asset(
                            'assets/animation/development.json',
                            height: 500,
                            width: 500,
                            repeat: true,
                            reverse: false,
                            animate: true,
                          ),
                        ),
                      ),
                    ],
                  ).animate().fade(duration: 800.ms).slideY(begin: 0.2),
          ),
        ],
      ),
    );
  }
}
