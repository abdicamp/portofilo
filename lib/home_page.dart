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
      print("offset : ${offset}");
      if (offset >= 0 && offset <= 99) {
        currentSection = Section.hero;
      } else if (offset >= 100 && offset <= 910) {
        currentSection = Section.about;
      } else if (offset >= 1800 && offset <= 2895) {
        currentSection = Section.experience;
      } else if (offset >= 2895 && offset <= 3084) {
        currentSection = Section.projects;
      }
      // else if (offset >= 1800 && offset <= 3084) {
      //   currentSection = Section.projects;
      // } else if (offset >= 2240 && offset <= 2816) {
      //   currentSection = Section.contact;
      // }
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
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                scrollTo(heroSectionKey);
              },
            ),
            ListTile(
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                scrollTo(aboutKey);
              },
            ),
            ListTile(
              title: const Text('Experience'),
              onTap: () {
                Navigator.pop(context);
                scrollTo(experienceKey);
              },
            ),
            ListTile(
              title: const Text('Projects'),
              onTap: () {
                Navigator.pop(context);
                scrollTo(projectSectionKey);
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
              onExperienceTap: () => scrollTo(experienceKey),
              onProjectTap: () => scrollTo(projectSectionKey),
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
          SliverToBoxAdapter(
              key: projectSectionKey,
              child: ProjectSection(
                scrollController: scrollController,
                currentSections: currentSection,
              )),
          // SliverToBoxAdapter(
          //     key: experienceKey,
          //     child: Experience(
          //       scrollController: scrollController,
          //       currentSections: currentSection,
          //     )),
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
          // SliverToBoxAdapter(key: contactKey, child: ContactSection()),
          // SliverToBoxAdapter(key: footerSectionKey, child: Footer()),
        ],
      ),
    );
  }
}

class _NavbarDelegate extends SliverPersistentHeaderDelegate {
  final VoidCallback onHomeTap;
  final VoidCallback onAboutTap;
  final VoidCallback onExperienceTap;
  final VoidCallback onProjectTap;
  final VoidCallback onContactTap;
  final Section currentSection;

  const _NavbarDelegate({
    required this.onHomeTap,
    required this.onAboutTap,
    required this.onExperienceTap,
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
          onExperienceTap: onExperienceTap,
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
