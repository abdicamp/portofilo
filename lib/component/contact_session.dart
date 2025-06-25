import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final messageController = TextEditingController();

    return Container(
      height: 900,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      color: Colors.grey[100],
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Contact Me",
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 30),

          // Form Input
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Your Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Your Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: messageController,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'Your Message',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Saat klik kirim (simulasi)
              print("Name: ${nameController.text}");
              print("Email: ${emailController.text}");
              print("Message: ${messageController.text}");
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
            ),
            child: const Text("Send Message"),
          ),
          const SizedBox(height: 40),

          // Social Links
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.email),
                onPressed: () => _launchURL("mailto:nadhir@email.com"),
              ),
              IconButton(
                icon: const Icon(Icons.link),
                onPressed: () => _launchURL("https://linkedin.com/in/yourprofile"),
              ),
              IconButton(
                icon: const Icon(Icons.code),
                onPressed: () => _launchURL("https://github.com/yourusername"),
              ),
            ],
          )
        ],
      ).animate().fade(duration: 800.ms).slideY(begin: 0.2),
    );
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    // if (!await launchUrl(uri)) {
    //   throw 'Could not launch $url';
    // }
  }
}
