import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:portofilo/component/experience.dart';

import 'component/about_section.dart';
import 'component/contact_session.dart';
import 'component/footer.dart';
import 'component/hero_section.dart';
import 'component/navbar.dart';
import 'component/project_section.dart';

enum Section { none, hero, about, experience, projects, contact }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();

  final aboutKey = GlobalKey();
  final experienceKey = GlobalKey();
  final heroSectionKey = GlobalKey();
  final contactKey = GlobalKey();
  final projectSectionKey = GlobalKey();
  final footerSectionKey = GlobalKey();

  Section currentSection = Section.hero;

  double? progress = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void onScroll() {
    final offset = scrollController.offset;

    setState(() {
      if (offset >= 0 && offset <= 99) {
        currentSection = Section.hero;
        // print("currentSection hero : ${currentSection}");
      } else if (offset >= 100 && offset <= 910) {
        currentSection = Section.about;
        // print("currentSection about : ${currentSection}");
      } else if (offset >= 1800 && offset <= 3084) {
        currentSection = Section.experience;
        print("offset project: ${offset}");
        print("currentSection project : ${currentSection}");
      } else if (offset >= 2240 && offset <= 2816) {
        currentSection = Section.contact;
        // print("currentSection contact: ${currentSection}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 60),
          children: [
            ListTile(
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                scrollTo(aboutKey);
              },
            ),
            ListTile(
              title: const Text('Projects'),
              onTap: () {
                Navigator.pop(context);
                scrollTo(experienceKey);
              },
            ),
            ListTile(
              title: const Text('Contact'),
              onTap: () {
                Navigator.pop(context);
                scrollTo(contactKey);
              },
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _NavbarDelegate(
              onHomeTap: () => scrollTo(heroSectionKey),
              onAboutTap: () => scrollTo(aboutKey),
              onProjectTap: () => scrollTo(experienceKey),
              onContactTap: () => scrollTo(contactKey),
              currentSection: currentSection,
            ),
          ),

          SliverToBoxAdapter(
              key: heroSectionKey,
              child: HeroSection(
                scrollController: scrollController,
              )),
          SliverToBoxAdapter(
              key: aboutKey,
              child: AboutSection(
                scrollController: scrollController,
                currentSections: currentSection,
              )),
          SliverToBoxAdapter(
              key: experienceKey,
              child: Experience(
                scrollController: scrollController,
                currentSections: currentSection,
              )),
          // SliverToBoxAdapter(
          //     key: projectSectionKey,
          //     child: Experience(
          //       scrollController: scrollController,
          //       currentSections: currentSection,
          //     )),
          // SliverToBoxAdapter(
          //     key: projectSectionKey,
          //     child: ProjectSection(
          //         // currentSections: currentSection,
          //         )),
          SliverToBoxAdapter(key: contactKey, child: ContactSection()),
          SliverToBoxAdapter(key: footerSectionKey, child: Footer()),
        ],
      ),
    );
  }
}

class _NavbarDelegate extends SliverPersistentHeaderDelegate {
  final VoidCallback onHomeTap;
  final VoidCallback onAboutTap;
  final VoidCallback onProjectTap;
  final VoidCallback onContactTap;
  final Section currentSection;

  const _NavbarDelegate({
    required this.onHomeTap,
    required this.onAboutTap,
    required this.onProjectTap,
    required this.onContactTap,
    required this.currentSection,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: Colors.black,
      elevation: 4,
      child: SafeArea(
        child: NavBar(
          onHomeTap: onHomeTap,
          onAboutTap: onAboutTap,
          onProjectTap: onProjectTap,
          onContactTap: onContactTap,
          currentSection: currentSection,
        ),
      ),
    );
  }

  @override
  double get minExtent => 74;
  @override
  double get maxExtent => 74;

  @override
  bool shouldRebuild(covariant _NavbarDelegate oldDelegate) => true;
}
