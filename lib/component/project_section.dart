import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portofilo/home_page.dart';
import 'package:portofilo/widgets/full_Screen_video.dart';
import 'package:portofilo/widgets/interactive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../widgets/interactive_zoom.dart';

class ProjectSection extends StatefulWidget {
  ScrollController scrollController;

  Section currentSections; // gunakan `final` lebih baik
  ProjectSection(
      {Key? key,
      required this.currentSections,
      required this.scrollController});

  @override
  State<ProjectSection> createState() => _ProjectSectionState();
}

class _ProjectSectionState extends State<ProjectSection> {
  ScrollController scrollControllerList = ScrollController();
  ScrollController scrollControllerList2 = ScrollController();
  late VideoPlayerController _controller;
  double offset = 0.0;
  double animationValue = 1.0;
  double values = 0.0;
  late Timer _timer;
  late Timer _timerDown;

  List<String> listRole = [
    "Full Stack Developer",
    "Implemented geofencing for check-in/out ",
    "Integrated facial recognition (described generally)",
    "Developed backend APIs for leave, permission, and overtime request handling",
    "UI development for attendance logs and request tracking",
  ];

  List<String> features = [
    "Location-based attendance with validation radius",
    "Face recognition (can be described as 'secure ID check')",
    "Online leave, permission, and overtime requests ",
    "Real-time approval workflows",
    "User profile and history log",
    "Attendance log and request history",
    "Attachment uploads (for permissions)",
    "User profile management",
  ];

  List<String> challenges = [
    "Problem: Spoofing locations    ",
    "Solution: Implemented accurate geofencing with fallback",
    "GPS checks + coordinate validation on server ",
  ];

  final List<String> imgList = [
    'assets/images/splashscreen.png',
    'assets/images/login.png',
    'assets/images/home.png',
    'assets/images/request.png',
    'assets/images/history.png',
    'assets/images/profile.png',
    'assets/images/permission.png',
    'assets/images/attendance.png',
    'assets/images/slipgaji.png',
  ];

  void _launchURLToPLaystore() async {
    final url = Uri.parse(
        'https://play.google.com/store/apps/details?id=com.sinergiteknologi.venushrmm&pcampaignid=web_share');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchURLToAppstore() async {
    final url =
        Uri.parse('https://apps.apple.com/us/app/venushrmmapps/id6745596208');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(milliseconds: 50), (_) {
      if (scrollControllerList.hasClients) {
        if (scrollControllerList.offset >=
            scrollControllerList.position.maxScrollExtent) {
          scrollControllerList.jumpTo(0); // Kembali ke atas
        } else {
          scrollControllerList.animateTo(
            scrollControllerList.offset + 1,
            duration: Duration(milliseconds: 50),
            curve: Curves.linear,
          );
        }
      }
    });
  }

  void _startAutoScrollDown() {
    _timerDown = Timer.periodic(Duration(milliseconds: 50), (_) {
      if (scrollControllerList2.hasClients) {
        double maxScroll = scrollControllerList2.position.maxScrollExtent;
        double currentScroll = scrollControllerList2.offset;

        if (currentScroll < maxScroll) {
          scrollControllerList2.jumpTo(currentScroll + 1);
        } else {
          // _timer.cancel(); // stop jika sudah sampai bawah
          // Jika mau kembali ke atas: _scrollController.jumpTo(0);
          scrollControllerList2.jumpTo(0);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
    _startAutoScrollDown();

    _controller =
        VideoPlayerController.asset("assets/videos/record_leader.webm")
          ..initialize().then((_) {
            setState(() {});
            _controller.play();
            _controller.setLooping(true);
          });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      double itemHeight = 300 + 16; // tinggi item + padding
      double middleScroll = (imgList.length / 2) * itemHeight;

      // Scroll ke tengah
      scrollControllerList.jumpTo(middleScroll);
    });

    widget.scrollController.addListener(() {
      final currentOffset = widget.scrollController.offset;

      // Hitung nilai animasi hanya jika scroll lewat 1000
      double newAnimationValue = 0.0;
      print("currentOffset : ${currentOffset}");
      if (currentOffset >= 1400) {
        newAnimationValue = ((currentOffset - 1400) / 500).clamp(0.0, 1.0);
      }

      setState(() {
        animationValue = newAnimationValue;
        values = (currentOffset / 150).clamp(0.0, 1.0);
      });
    });
  }

  void _showFullscreenVideo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return FullscreenVideoDialog(controller: _controller);
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    scrollControllerList.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size =
        MediaQuery.of(context).size.width * 0.9; // 80% dari lebar layar
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // blur halus
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 200, horizontal: 40),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1), // transparan
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
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
                                "A Human Resource application that enables employees to perform daily HR tasks such as check-in/out with location,submit leave/permission/overtime requests, view attendance history, and track approvals — all from a mobile device.",
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
                                height: 20,
                              ),
                              Text(
                                "📱 Published On",
                                maxLines: 2,
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.black, // sangat transparan
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () => _launchURLToPLaystore(),
                                child: Text(
                                  "Play Store",
                                  maxLines: 2,
                                  style: GoogleFonts.poppins(
                                      decoration: TextDecoration.underline,
                                      fontSize: 12,
                                      color: Colors.blue // sangat transparan
                                      ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () => _launchURLToAppstore(),
                                child: Text(
                                  "App Store",
                                  maxLines: 2,
                                  style: GoogleFonts.poppins(
                                      decoration: TextDecoration.underline,
                                      fontSize: 12,
                                      color: Colors.blue // sangat transparan
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 600,
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
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 700,
                                      child: ScrollConfiguration(
                                        behavior:
                                            ScrollConfiguration.of(context)
                                                .copyWith(scrollbars: false),
                                        child: SingleChildScrollView(
                                          controller: scrollControllerList,
                                          child: Column(
                                            children: imgList.map((e) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  height: 300,
                                                  child: ZoomOnHoverImage(
                                                    imagePath: e,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 700,
                                      child: ScrollConfiguration(
                                        behavior:
                                            ScrollConfiguration.of(context)
                                                .copyWith(scrollbars: false),
                                        child: SingleChildScrollView(
                                          controller: scrollControllerList2,
                                          child: Column(
                                            children: imgList.map((e) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  height: 300,
                                                  child: ZoomOnHoverImage(
                                                    imagePath: e,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                    ),
                                    GestureDetector(
                                      onTap: () =>
                                          _showFullscreenVideo(context),
                                      child: Container(
                                        height: 500,
                                        child: DeviceFrame(
                                          device: Devices.ios.iPhone15ProMax,
                                          screen: _controller
                                                  .value.isInitialized
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                  child: AspectRatio(
                                                    aspectRatio: _controller
                                                        .value.aspectRatio,
                                                    child: VideoPlayer(
                                                        _controller),
                                                  ),
                                                )
                                              : const CircularProgressIndicator(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Colors.white,
                                          Colors.white.withOpacity(0.0),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.white,
                                          Colors.white.withOpacity(0.0),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                  color: Colors.black.withOpacity(0.1), // sangat transparan
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
      ],
    )
        .animate(
            target: widget.currentSections == Section.projects ||
                    widget.scrollController.offset >= 1400
                ? 1.0
                : 0.0)
        .fade(duration: 1500.ms)
        .slideY(begin: 0.2);
  }
}
