import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portofilo/home_page.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Experience extends StatefulWidget {
  // ScrollController scrollController;

  // Section currentSections; // gunakan `final` lebih baik
  Experience({
    Key? key,
  });

  @override
  State<Experience> createState() => _ExperienceState();
}

class _ExperienceState extends State<Experience> {
  Map<int, double> visibleFractions = {};

  // Warna gradasi dari gelap → terang
  final Color darkStart = Colors.blueGrey.shade900;
  final Color darkEnd = Colors.black;
  final Color lightStart = Colors.lightBlueAccent;
  final Color lightEnd = Colors.cyanAccent;
  List<bool> _visibleList = [];

  List<dynamic> experiences = [
    {
      "company": "PT Sinergi Teknologi Solusindo",
      "position": "Software Engineer",
      "duration": "Jul 2023 – Present",
      "highlights": [
        "Developed Flutter apps to visualize port financial data.",
        "Built web-based CMMS for maintenance operations.",
        "Designed IoT solutions for port operational support.",
        "Published HR and sales apps to Play Store & App Store.",
        "Developed mobile ERP and DMS systems using Flutter.",
      ]
    },
    {
      "company": "PT HPY Solusiutama Indonesia",
      "position": "Mobile Engineer",
      "duration": "Feb 2023 – Apr 2023",
      "highlights": [
        "Built e-commerce app 'Electronic Beautiful Voice' using Flutter.",
        "Served as Project Manager and UI/UX Designer.",
        "Developed supporting APIs for mobile app.",
        "Collaborated with marketing for promotional campaigns."
      ]
    },
    {
      "company": "PT Laju Omega Digital",
      "position": "Junior Programmer",
      "duration": "Oct 2022 – Dec 2022",
      "highlights": [
        "Built web systems and mobile apps per client requirements.",
        "Performed QA to minimize bugs.",
        "Collaborated with project teams during development."
      ]
    },
    {
      "company": "PT Lentera Bangsa Benderang (Remote)",
      "position": "Mobile App Developer (Internship)",
      "duration": "Feb 2022 – Jul 2022",
      "highlights": ["Built mobile e-commerce app using React Native."]
    },
    {
      "company": "PT Indonesia Comnet Plus",
      "position": "Programmer (Internship)",
      "duration": "Feb 2022 – Jul 2022",
      "highlights": [
        "Created mobile app for barcode scanning.",
        "Integrated ML Kit to improve accuracy by 80%.",
        "Enabled real-time backend sync with REST API.",
        "Conducted usability testing & deployed to Android ops devices."
      ]
    },
    {
      "company": "Freelance",
      "position": "Web & Mobile Developer",
      "duration": "Feb 2022 – Apr 2022",
      "highlights": [
        "Built sales, tourism, rental, attendance, and donation systems (web & mobile)."
      ]
    },
  ];

  @override
  void initState() {
    super.initState();
    _visibleList = List.generate(experiences.length, (_) => false);
    _runStaggeredAnimation();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Positioned(
              left: -90,
              child: ClipRect(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'EXPERIENCE',
                    style: GoogleFonts.poppins(
                      letterSpacing: 5,
                      fontSize: 180,
                      fontWeight: FontWeight.bold,
                      color:
                          Colors.black.withOpacity(0.03), // sangat transparan
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'EXPERIENCE',
                style: GoogleFonts.poppins(
                  letterSpacing: 5,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // sangat transparan
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 600,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: experiences.length,
                      itemBuilder: (context, index) {
                        final e = experiences[index];
                        final visible = _visibleList[index];
                        List<dynamic> detailJob = e['highlights'];
                        return VisibilityDetector(
                          key: Key('experience-$index'),
                          onVisibilityChanged: (info) {
                            if (info.visibleFraction > 0.2) {
                              setVisible(index);
                            }
                          },
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 500),
                            opacity: visible ? 1 : 0,
                            child: AnimatedSlide(
                              duration: Duration(milliseconds: 500),
                              offset: visible ? Offset(0, 0) : Offset(0, 0.2),
                              curve: Curves.easeOut,
                              child: Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 70,
                                              ),
                                              Container(
                                                width: 10, // diameter
                                                height: 10,
                                                decoration: BoxDecoration(
                                                  color: Colors
                                                      .grey, // warna bulatannya
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                width: 2, // lebar garis
                                                height: 100, // tinggi garis
                                                color:
                                                    Colors.grey, // warna garis
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${e['position']}",
                                                style: GoogleFonts.lato(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "${e['company']}",
                                                style: GoogleFonts.lato(
                                                  fontSize: 13,
                                                ),
                                              ),
                                              Text(
                                                "${e['duration']}",
                                                style: GoogleFonts.lato(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: detailJob.map((e) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(2),
                                                    child: Text(
                                                      "- ${e}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        letterSpacing: 1,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      })),
            )
          ],
        ),
      ),
    );
  }
}
