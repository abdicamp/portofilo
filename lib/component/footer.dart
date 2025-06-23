import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 40),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50))),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            spacing: 16,
            children: [
              _footerLink("GitHub", "https://github.com/yourusername"),
              _footerLink("LinkedIn", "https://linkedin.com/in/yourprofile"),
              _footerLink("Email", "mailto:your@email.com"),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '© 2025 Nadhir.dev — Built with Flutter',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ],
      ).animate().fade(duration: 800.ms).slideY(begin: 0.2),
    );
  }

  Widget _footerLink(String title, String url) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          color: Colors.tealAccent,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    // if (!await launchUrl(uri)) {
    //   throw 'Could not launch $url';
    // }
  }
}
