import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:device_frame/device_frame.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portofilo/home_page.dart';
import 'package:portofilo/widgets/full_Screen_video.dart';
import 'package:portofilo/widgets/interactive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

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
  late YoutubePlayerController _controller;
  double offset = 0.0;
  double animationValue = 1.0;
  double values = 0.0;
  late Timer _timer;
  late Timer _timerDown;

  final listRole = {
    'en': [
      "Full Stack Developer",
      "Implemented geofencing for check-in/out",
      "Integrated facial recognition (described generally)",
      "Developed backend APIs for leave, permission, and overtime request handling",
      "UI development for attendance logs and request tracking",
    ],
    'id': [
      "Pengembang Full Stack",
      "Mengimplementasikan geofencing untuk proses check-in/check-out",
      "Mengintegrasikan pengenalan wajah (dijelaskan secara umum)",
      "Mengembangkan API backend untuk pengajuan cuti, izin, dan lembur",
      "Membuat antarmuka pengguna untuk log absensi dan pelacakan permintaan",
    ],
  };

  final features = {
    'en': [
      "Location-based attendance with validation radius",
      "Face recognition (can be described as 'secure ID check')",
      "Online leave, permission, and overtime requests",
      "Real-time approval workflows",
      "User profile and history log",
      "Attendance log and request history",
      "Attachment uploads (for permissions)",
      "User profile management",
    ],
    'id': [
      "Absensi berbasis lokasi dengan radius validasi",
      "Pengenalan wajah (bisa disebut 'pemeriksaan identitas aman')",
      "Pengajuan cuti, izin, dan lembur secara online",
      "Alur persetujuan secara real-time",
      "Profil pengguna dan riwayat absensi",
      "Log kehadiran dan riwayat pengajuan",
      "Unggah lampiran (untuk izin)",
      "Manajemen profil pengguna",
    ],
  };

  final challenges = {
    'en': [
      "Problem: Spoofing locations",
      "Solution: Implemented accurate geofencing with fallback",
      "GPS checks + coordinate validation on server",
    ],
    'id': [
      "Masalah: Pemalsuan lokasi",
      "Solusi: Mengimplementasikan geofencing yang akurat dengan fallback",
      "Pemeriksaan GPS + validasi koordinat di server",
    ],
  };

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

    _controller = YoutubePlayerController.fromVideoId(
      videoId: '1gXNqWoar_k',
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );

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

  @override
  void dispose() {
    _timer.cancel();
    scrollControllerList.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final langCode = context.locale.languageCode;
    double size =
        MediaQuery.of(context).size.width * 0.9; // 80% dari lebar layar
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 300, horizontal: 40),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.lerp(
                    Colors.white, Colors.black, values)!, // dari putih ke hitam
                Colors.white, // setengah bawah tetap putih
              ],
              stops: [0.0, 0.3], // gradasi hanya sampai setengah
            ),
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${langCode == 'en' ? 'Latest Project' : 'Proyek Terbaru'}",
                style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black // sangat transparan
                    ),
              ),
              SizedBox(
                height: 50,
              ),
              isMobile
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${langCode == 'en' ? 'Human Resource Mobile Application - Employee Self Service' : 'Aplikasi Kepegawaian Mobile – Layanan Mandiri Karyawan'}",
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
                              "${langCode == 'en' ? 'A Human Resource application that enables employees to perform daily HR tasks such as check-in/out with location,submit leave/permission/overtime requests, view attendance history, and track approvals — all from a mobile device.' : 'Aplikasi Sumber Daya Manusia (SDM) yang dirancang untuk memudahkan karyawan dalam menyelesaikan kebutuhan operasional harian, seperti absensi dengan pelacakan lokasi, pengajuan cuti, izin, lembur, serta pemantauan riwayat kehadiran dan proses persetujuan melalui perangkat seluler.'}",
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
                              "🔧 ${langCode == 'en' ? 'Tech Stack :' : 'Teknologi yang di gunakan :'} ",
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
                              "👨‍💻 ${langCode == 'en' ? 'Role & Responsibility :' : 'Peran dan Tanggung Jawab :'}",
                              maxLines: 2,
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black, // sangat transparan
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ...listRole[langCode]!.map((e) => Text(
                                  "- $e",
                                  maxLines: 2,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "🔍 ${langCode == 'en' ? 'Key Features :' : 'Fitur :'}",
                              maxLines: 2,
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black, // sangat transparan
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ...features[langCode]!.map((e) => Text(
                                  "- $e",
                                  maxLines: 2,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "🧠 ${langCode == 'en' ? 'Challenges & Solutions' : 'Permasalahan & Penyelesaian'}",
                              maxLines: 2,
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black, // sangat transparan
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ...challenges[langCode]!.map((e) => Text(
                                  "- $e",
                                  maxLines: 2,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "📱 ${langCode == 'en' ? 'Published On' : 'Di Terbitkan di :'}",
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
                        Container(
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
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
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
                                  ],
                                ),
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
                        GestureDetector(
                          onTap: () => {},
                          child: Container(
                            height: 500,
                            child: DeviceFrame(
                              device: Devices.ios.iPhone15ProMax,
                              screen: YoutubePlayerScaffold(
                                controller: _controller,
                                builder: (context, player) {
                                  return Container(
                                    padding: const EdgeInsets.all(16),
                                    height: 500,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(24),
                                      child: player,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Padding(
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
                                  "${langCode == 'en' ? 'Human Resource Mobile Application - Employee Self Service' : 'Aplikasi Kepegawaian Mobile – Layanan Mandiri Karyawan'}",
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
                                  "${langCode == 'en' ? 'A Human Resource application that enables employees to perform daily HR tasks such as check-in/out with location,submit leave/permission/overtime requests, view attendance history, and track approvals — all from a mobile device.' : 'Aplikasi Sumber Daya Manusia (SDM) yang dirancang untuk memudahkan karyawan dalam menyelesaikan kebutuhan operasional harian, seperti absensi dengan pelacakan lokasi, pengajuan cuti, izin, lembur, serta pemantauan riwayat kehadiran dan proses persetujuan melalui perangkat seluler.'}",
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
                                  "🔧 ${langCode == 'en' ? 'Tech Stack :' : 'Teknologi yang di gunakan :'} ",
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
                                  "👨‍💻 ${langCode == 'en' ? 'Role & Responsibility :' : 'Peran dan Tanggung Jawab :'}",
                                  maxLines: 2,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.black, // sangat transparan
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ...listRole[langCode]!.map((e) => Text(
                                      "- $e",
                                      maxLines: 2,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "🔍 ${langCode == 'en' ? 'Key Features :' : 'Fitur :'}",
                                  maxLines: 2,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.black, // sangat transparan
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ...features[langCode]!.map((e) => Text(
                                      "- $e",
                                      maxLines: 2,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "🧠 ${langCode == 'en' ? 'Challenges & Solutions' : 'Permasalahan & Penyelesaian'}",
                                  maxLines: 2,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.black, // sangat transparan
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ...challenges[langCode]!.map((e) => Text(
                                      "- $e",
                                      maxLines: 2,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "📱 ${langCode == 'en' ? 'Published On' : 'Di Terbitkan di :'}",
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
                                        onTap: () {},
                                        child: Container(
                                          height: 500,
                                          child: DeviceFrame(
                                            device: Devices.ios.iPhone15ProMax,
                                            screen: YoutubePlayerScaffold(
                                              controller: _controller,
                                              builder: (context, player) {
                                                return Container(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  height: 500,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24),
                                                    child: player,
                                                  ),
                                                );
                                              },
                                            ),
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
        Positioned(
          left: -100,
          child: ClipRect(
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                '${langCode == 'en' ? 'LATEST PROJECT' : 'PROYEK TERBARU'}',
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
    );
  }
}
