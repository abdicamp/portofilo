import 'package:flutter/material.dart';
import 'component/about_section.dart';
import 'component/contact_session.dart';
import 'component/footer.dart';
import 'component/hero_section.dart';
import 'component/navbar.dart';
import 'component/project_section.dart';
import 'home_page.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portofolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black, // <- ini yang penting
        primaryColor: Colors.black, // opsional
        colorScheme: ColorScheme.light(
          background: Colors.white, // opsional
          primary: Colors.black, // ganti sesuai gaya kamu
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black), // pastikan teks hitam
        ),
      ),
      home: HomePage(),
    );
  }
}
