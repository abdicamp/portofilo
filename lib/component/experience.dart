import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portofilo/home_page.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Experience extends StatefulWidget {
  ScrollController scrollController;
  Section currentSections; // gunakan `final` lebih baik
  Experience({
    Key? key,
    required this.currentSections,
    required this.scrollController,
  });

  @override
  State<Experience> createState() => _ExperienceState();
}

class _ExperienceState extends State<Experience> with TickerProviderStateMixin {
  Map<int, double> visibleFractions = {};
  double values = 0.0;

  // Warna gradasi dari gelap → terang
  final Color darkStart = Colors.blueGrey.shade900;
  final Color darkEnd = Colors.black;
  final Color lightStart = Colors.lightBlueAccent;
  final Color lightEnd = Colors.cyanAccent;
  List<bool> _visibleList = [];

  List<Map<String, dynamic>> experiences = [
    {
      "company": "experience_1_company",
      "position": "experience_1_position",
      "duration": "experience_1_duration",
      "highlights": [
        "experience_1_highlight_1",
        "experience_1_highlight_2",
        "experience_1_highlight_3",
        "experience_1_highlight_4",
        "experience_1_highlight_5",
      ]
    },
    {
      "company": "experience_2_company",
      "position": "experience_2_position",
      "duration": "experience_2_duration",
      "highlights": [
        "experience_2_highlight_1",
        "experience_2_highlight_2",
        "experience_2_highlight_3",
        "experience_2_highlight_4"
      ]
    },
    {
      "company": "experience_3_company",
      "position": "experience_3_position",
      "duration": "experience_3_duration",
      "highlights": [
        "experience_3_highlight_1",
        "experience_3_highlight_2",
        "experience_3_highlight_3"
      ]
    },
    {
      "company": "experience_4_company",
      "position": "experience_4_position",
      "duration": "experience_4_duration",
      "highlights": ["experience_4_highlight_1"]
    },
    {
      "company": "experience_5_company",
      "position": "experience_5_position",
      "duration": "experience_5_duration",
      "highlights": [
        "experience_5_highlight_1",
        "experience_5_highlight_2",
        "experience_5_highlight_3",
        "experience_5_highlight_4"
      ]
    },
    {
      "company": "experience_6_company",
      "position": "experience_6_position",
      "duration": "experience_6_duration",
      "highlights": ["experience_6_highlight_1"]
    },
  ];

  @override
  void initState() {
    super.initState();
    _visibleList = List.generate(experiences.length, (_) => false);
    _controller.addListener(() {
      final newPage = _controller.page?.round() ?? 0;
      if (_currentPage != newPage) {
        setState(() => _currentPage = newPage);
      }
    });
    _runStaggeredAnimation();

    widget.scrollController.addListener(() {
      final offset = widget.scrollController.offset;
      final start = 1400.0;
      final end = 2000.0;

      final progress = ((offset - start) / (end - start)).clamp(0.0, 1.0);

      setState(() {
        values = progress; // pakai di Color.lerp(...)
      });
    });
  }

  void _runStaggeredAnimation() async {
    for (int i = 0; i < experiences.length; i++) {
      await Future.delayed(Duration(milliseconds: 150));
      if (mounted) {
        setState(() {
          _visibleList[i] = true;
        });
      }
    }
  }

  void setVisible(int index) {
    if (!_visibleList[index]) {
      setState(() {
        _visibleList[index] = true;
      });
    }
  }

  final PageController _controller = PageController(viewportFraction: 0.75);
  int _currentPage = 0;

  void scrollTo(int direction) {
    final newPage = _currentPage + direction;
    if (newPage >= 0 && newPage < experiences.length) {
      _controller.animateToPage(
        newPage,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            // atas: putih ke abu tergantung scroll
            Color.lerp(
                Colors.white, Color.fromARGB(255, 255, 255, 255), values)!,

            // bawah: abu ke hitam tergantung scroll
            Color.lerp(Color.fromARGB(255, 212, 212, 212), Colors.black,
                values.clamp(0.0, 1.0))!,
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: -50,
            child: ClipRect(
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'experience_capital'.tr(),
                  style: GoogleFonts.poppins(
                    letterSpacing: 5,
                    fontSize: 180,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.03), // sangat transparan
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
          PageView.builder(
            controller: _controller,
            itemCount: experiences.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              final item = experiences[index];
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  double value = 1.0;
                  if (_controller.position.haveDimensions) {
                    value = _controller.page! - index;
                    value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                  }
                  return Center(
                    child: Transform.scale(
                      scale: Curves.easeOut.transform(value),
                      child: child,
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 40),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Browser Mockup Header
                              Container(
                                height: 40,
                                margin: EdgeInsets.only(bottom: 20),
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                        radius: 6, backgroundColor: Colors.red),
                                    SizedBox(width: 6),
                                    CircleAvatar(
                                        radius: 6,
                                        backgroundColor: Colors.yellow),
                                    SizedBox(width: 6),
                                    CircleAvatar(
                                        radius: 6,
                                        backgroundColor: Colors.green),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        'www.${item["company"].toString().toLowerCase().replaceAll(" ", "")}.com',
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 12,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              Text(
                                item["position"].toString().tr(),
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                item["company"].toString().tr(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text(
                                item["duration"].toString().tr(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white54,
                                ),
                              ),
                              SizedBox(height: 16),
                              ...(item["highlights"] as List)
                                  .asMap()
                                  .entries
                                  .map(
                                (entry) {
                                  final index = entry.key;
                                  final point = entry.value;

                                  return TweenAnimationBuilder<double>(
                                    tween: Tween(begin: 0.0, end: 1.0),
                                    duration: Duration(
                                        milliseconds: 400 + (index * 200)),
                                    builder: (context, value, child) {
                                      return Opacity(
                                        opacity: value,
                                        child: Transform.translate(
                                          offset: Offset((1 - value) * 20,
                                              0), // slide dari kiri
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 6.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("• ",
                                                    style: TextStyle(
                                                        color: Colors.white70)),
                                                Expanded(
                                                  child: Text(
                                                    point
                                                        .toString()
                                                        .tr(), // 🟦 Terjemahkan juga
                                                    style: TextStyle(
                                                        color: Colors.white70),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Tombol Panah Kiri
          Positioned(
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white54),
              onPressed: () => scrollTo(-1),
            ),
          ),

          // Tombol Panah Kanan
          Positioned(
            right: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios, color: Colors.white54),
              onPressed: () => scrollTo(1),
            ),
          ),
        ],
      ),
    );
  }
}
