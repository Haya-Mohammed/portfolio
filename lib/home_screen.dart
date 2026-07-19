import 'package:flutter/material.dart';

import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'sections/hero_section.dart';
import 'sections/projects_section.dart';
import 'sections/skills_section.dart';
import 'widgets/footer_widget.dart';
import 'widgets/nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();

  final _sectionKeys = {
    'about': GlobalKey(),
    'skills': GlobalKey(),
    'projects': GlobalKey(),
    'contact': GlobalKey(),
  };

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const HeroSection(),

                SizedBox(key: _sectionKeys['about'], child: const AboutSection()),

                SizedBox(key: _sectionKeys['skills'], child: const SkillsSection()),

                SizedBox(key: _sectionKeys['projects'], child: const ProjectsSection()),

                SizedBox(key: _sectionKeys['contact'], child: const ContactSection()),

                const FooterWidget(),
              ],
            ),
          ),

          /// Fixed nav bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PortfolioNavBar(scrollController: _scrollController, sectionKeys: _sectionKeys),
          ),
        ],
      ),
    );
  }
}
