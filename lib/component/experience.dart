import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portofilo/home_page.dart';
import 'package:portofilo/widgets/interactive.dart';
import 'package:video_player/video_player.dart';

class Experience extends StatefulWidget {
  ScrollController scrollController;
  Section currentSections; // gunakan `final` lebih baik
  Experience(
      {Key? key,
      required this.currentSections,
      required this.scrollController});

  @override
  State<Experience> createState() => _ExperienceState();
}

class _ExperienceState extends State<Experience> {
  late VideoPlayerController _controller;
  double offset = 0.0;
  double animationValue = 1.0;
  double values = 0.0;

  List<String> listRole = [
    "Full Stack Developer",
    "Implemented geofencing for check-in/out ",
    "Integrated facial recognition (described generally)",
    "Built backend APIs for leave and permission requests ",
    "UI development for attendance logs and request tracking",
  ];

  List<String> features = [
    "Location-based attendance with validation radius",
    "Face recognition (can be described as 'secure ID check')",
    "Online leave, permission, and overtime requests ",
    "Real-time approval workflows",
    "User profile and history log",
  ];

  List<String> challenges = [
    "Problem: Spoofing locations    ",
    "Solution: Implemented accurate geofencing with fallback",
    "GPS checks + coordinate validation on server ",
  ];

  final List<String> imgList = [
    'assets/images/ss.jpeg',
    'assets/images/profile.png',
  ];

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/videos/record.webm")
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });

    widget.scrollController.addListener(() {
      final currentOffset = widget.scrollController.offset;

      // Hitung nilai animasi hanya jika scroll lewat 1000
      double newAnimationValue = 0.0;
      if (currentOffset <= 1000) {
        newAnimationValue = ((currentOffset - 1000) / 500).clamp(0.0, 1.0);
      }

      setState(() {
        animationValue = newAnimationValue;
        values = (currentOffset / 150).clamp(0.0, 1.0);
      });
    });
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
    return Expanded(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 200, horizontal: 40),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Latest Project",
                  style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black // sangat transparan
                      ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Human Resource Mobile Application - Employee Self Service",
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black // sangat transparan
                                  ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "A Human Resource application that enables employees to check-in/out with location, request leaves, track attendance, and more.",
                              maxLines: 2,
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black // sangat transparan
                                  ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "🔧 Tech Stack: ",
                              maxLines: 2,
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black, // sangat transparan
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Flutter | Node.js | SQL Server | Provider | REST API ",
                              maxLines: 2,
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black // sangat transparan
                                  ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "👨‍💻 Role & Responsibility ",
                              maxLines: 2,
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black, // sangat transparan
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: listRole.map((e) {
                                return Text(
                                  "- ${e}",
                                  maxLines: 2,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.black // sangat transparan
                                      ),
                                );
                              }).toList(),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "🔍 Key Features",
                              maxLines: 2,
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black, // sangat transparan
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: features.map((e) {
                                return Text(
                                  "- ${e}",
                                  maxLines: 2,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.black // sangat transparan
                                      ),
                                );
                              }).toList(),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "🧠 Challenges & Solutions",
                              maxLines: 2,
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black, // sangat transparan
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: challenges.map((e) {
                                return Text(
                                  "- ${e}",
                                  maxLines: 2,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.black // sangat transparan
                                      ),
                                );
                              }).toList(),
                            ),
                            SizedBox(
                              width: 500,
                          
                              child: ExpansionTile(
                                leading: const Icon(Icons.folder),
                                title: const Text('Images'),
                                trailing: const Icon(Icons.expand_more),
                                children: [
                                  SizedBox(
                                    height: size,
                                    width: 500,
                                    
                                    child: GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 4.0,
                                          mainAxisSpacing: 4.0,
                                        ),
                                        itemCount: imgList.length,
                                        itemBuilder: (context, index) {
                                          return SizedBox(
                                            child: InteractiveTilt(
                                              child: Image.asset(imgList[index],
                                                  fit: BoxFit.cover),
                                            )
                                                .animate()
                                                .fade(duration: 1000.ms)
                                                .slideY(
                                                    begin: 0.2,
                                                    duration: 1000.ms),
                                          );
                                        }),
                                  )
                                ], // default sudah ada panah
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 1000,
                          child: Stack(
                            children: [
                              CarouselSlider.builder(
                                itemCount: imgList.length,
                                options: CarouselOptions(
                                  // autoPlay: true,

                                  enlargeCenterPage:
                                      false, // matikan perbesaran slide tengah
                                  viewportFraction:
                                      1.0, // item full width (rapat)

                                  autoPlayInterval: Duration(seconds: 3),
                                ),
                                itemBuilder: (context, index, realIndex) {
                                  return SizedBox(
                                    child: InteractiveTilt(
                                      child: Image.asset(imgList[index],
                                          fit: BoxFit.cover),
                                    )
                                        .animate()
                                        .fade(duration: 1000.ms)
                                        .slideY(begin: 0.2, duration: 1000.ms),
                                  );
                                },
                              ),

                              // 🔽 Gradasi Putih di Bawah
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.white.withOpacity(0.9),
                                        Colors.white.withOpacity(0.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // 🔼 Gradasi Putih di Atas
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.white.withOpacity(0.9),
                                        Colors.white.withOpacity(0.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // ◀️ Gradasi Putih di Kiri
                              Positioned(
                                top: 0,
                                bottom: 0,
                                left: 0,
                                child: Container(
                                  width: 50,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Colors.white.withOpacity(0.9),
                                        Colors.white.withOpacity(0.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // ▶️ Gradasi Putih di Kanan
                              Positioned(
                                top: 0,
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 50,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft,
                                      colors: [
                                        Colors.white.withOpacity(0.9),
                                        Colors.white.withOpacity(0.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )

                        // SizedBox(
                        //   width: 350,
                        //   height: 700,
                        //   child: DeviceFrame(
                        //     device: Devices.ios.iPhone15ProMax,
                        //     screen: _controller.value.isInitialized
                        //         ? ClipRRect(
                        //             borderRadius: BorderRadius.circular(24),
                        //             child: AspectRatio(
                        //               aspectRatio: _controller.value.aspectRatio,
                        //               child: VideoPlayer(_controller),
                        //             ),
                        //           )
                        //         : const CircularProgressIndicator(),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: -100,
            child: ClipRect(
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'LATEST PROJECT',
                  style: GoogleFonts.poppins(
                    fontSize: 150,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(70, 146, 146, 146)
                        .withOpacity(0.1), // sangat transparan
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
        ],
      )
          .animate(
              target: widget.currentSections == Section.hero ||
                      widget.scrollController.offset <= 900
                  ? 1.0
                  : 0.0)
          .fade(duration: 1500.ms)
          .slideY(begin: 0.2),
    );
  }
}
