import 'package:flutter/material.dart';
import '../home_page.dart'; // Untuk akses enum Section (pastikan importnya benar)

class NavBar extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onAboutTap;
  final VoidCallback onProjectTap;
  final VoidCallback onContactTap;
  final Section currentSection;

  const NavBar({
    super.key,
    required this.onHomeTap,
    required this.onAboutTap,
    required this.onProjectTap,
    required this.onContactTap,
    required this.currentSection,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Abdi Dev',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (isMobile)
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            )
          else
            Row(
              children: [
                _navItem('Home', onHomeTap, currentSection == Section.hero),
                _navItem('About', onAboutTap, currentSection == Section.about),
                _navItem('Projects', onProjectTap,
                    currentSection == Section.projects),
                _navItem(
                    'Contact', onContactTap, currentSection == Section.contact),
              ],
            ),
        ],
      ),
    );
  }

  Widget _navItem(String label, VoidCallback onTap, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.tealAccent : Colors.white,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (isActive)
              Container(
                margin: const EdgeInsets.only(top: 4),
                height: 2,
                width: 20,
                color: Colors.tealAccent,
              ),
          ],
        ),
      ),
    );
  }
}
