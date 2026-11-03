import 'package:my_portfolio/core/constants.dart';
import 'package:my_portfolio/models/certificate.dart';
import 'package:my_portfolio/models/contact_link.dart';
import 'package:my_portfolio/models/education.dart';
import 'package:my_portfolio/models/experience.dart';
import 'package:my_portfolio/models/project.dart';
import 'package:my_portfolio/models/skill_group.dart';

class PortfolioContent {
  static const name = 'Haya Obaid';
  static const title = 'Mobile Application Developer';
  static const headline = 'Flutter apps built for real life.';
  static const tagline = 'Thoughtful interfaces. Reliable engineering.';

  static const introduction =
      'I design and build cross-platform mobile apps, from clear interfaces to dependable API integrations.';

  static const about =
      'My work spans team, trainee, personal, and freelance mobile projects. I enjoy turning requirements into reliable app flows, connecting interfaces to APIs, and solving the details that make an experience feel clear and dependable.';

  static const experience = <Experience>[
    Experience(
      role: 'Mobile Application Developer',
      organization: 'Startup Company',
      dates: 'Aug 2026 – Oct 2026',
      description:
          'Develop Flutter apps, reusable responsive interfaces, REST API integrations, and application state with a development team.',
    ),
    Experience(
      role: 'Software Engineer & Mobile Developer Trainee',
      organization: 'CodeMap at Taqat Company',
      dates: 'Jul 2026 – Oct 2026',
      description:
          'Architected a Flutter fitness app with a Laravel API, Clean Architecture, and BLoC/Cubit. Fixed signup timeout failures with a retry interceptor, improved profile caching and PATCH updates, and resolved a frontend/backend data contract mismatch.',
    ),
    Experience(
      role: 'Mobile Developer Trainee',
      organization: 'Developers Plus Company',
      dates: 'Jun 2022 – Sep 2022',
      description:
          'Built reusable Flutter interfaces, integrated REST APIs, and implemented local storage while learning professional development workflows.',
    ),
  ];

  static const skills = <SkillGroup>[
    SkillGroup(
      title: 'Flutter development',
      description: 'Cross-platform app features and responsive interfaces.',
      tags: ['Flutter', 'Dart', 'Responsive UI', 'Figma'],
    ),
    SkillGroup(
      title: 'Architecture & state',
      description: 'Organized application layers and predictable state.',
      tags: [
        'Clean Architecture',
        'MVVM',
        'Repository Pattern',
        'BLoC',
        'Cubit',
        'Provider',
        'GetX',
      ],
    ),
    SkillGroup(
      title: 'Data & integration',
      description: 'Connected apps to services and local persistence.',
      tags: [
        'REST APIs',
        'Firebase',
        'Hive',
        'SQLite',
        'Shared Preferences',
        'Postman',
      ],
    ),
    SkillGroup(
      title: 'Engineering workflow',
      description: 'Problem solving, error handling, and maintainable code.',
      tags: ['Git', 'GitHub', 'OOP', 'SOLID', 'Android Studio', 'VS Code'],
    ),
  ];

  static const education = <Education>[
    Education(
      degree: 'BSc Computer Science',
      institution: 'Al-Azhar University, Gaza',
      period: '2020–2024',
      details: '87.3% GPA · 3.49/4.00 · Second Class Honors',
    ),
    Education(
      degree: 'High School Diploma, Scientific Stream',
      institution: 'Al-Azhar Gaza Institute',
      period: '2017–2020',
    ),
  ];

  static const certificates = <Certificate>[
    Certificate(
      title: 'Clean Architecture in Flutter',
      issuer: 'Udemy',
      date: 'Feb 2026',
      featured: true,
    ),
    Certificate(
      title: 'Relationships Engineering for Engineers',
      issuer: 'Association of Engineers, Gaza',
      date: 'Jun–Jul 2025',
    ),
    Certificate(
      title: 'Freelance Skills Training',
      issuer: 'Digiwork',
      details: '30 hours',
    ),
    Certificate(
      title: 'Clean Architecture in Flutter',
      issuer: 'Udemy',
      date: 'Oct 2024',
    ),
    Certificate(
      title: 'Flutter Advanced: BLoC and MVVM',
      issuer: 'Udemy',
      date: 'Jul 2024',
      featured: true,
    ),
    Certificate(
      title: 'Flutter and Dart Development',
      issuer: 'Udemy',
      date: 'Aug 2023',
      featured: true,
    ),
    Certificate(
      title: 'Flutter Development Guide',
      issuer: 'Udemy',
      date: 'Sep 2023',
    ),
    Certificate(
      title: 'The Complete Dart Learning Guide',
      issuer: 'Udemy',
      date: 'Mar 2023',
    ),
  ];

  static const socialLinks = <ContactLink>[
    ContactLink(label: 'GitHub', url: AppConstants.github),
    ContactLink(label: 'LinkedIn', url: AppConstants.linkedIn),
    ContactLink(label: 'Linktree', url: AppConstants.linktree),
    ContactLink(label: 'WhatsApp', url: AppConstants.whatsapp),
  ];

  static const freelanceProfiles = <ContactLink>[
    ContactLink(label: 'Upwork', url: AppConstants.upwork),
    ContactLink(label: 'Freelancer', url: AppConstants.freelancer),
    ContactLink(label: 'Mostaqel', url: AppConstants.mostaql),
    ContactLink(label: 'Khamsat', url: AppConstants.khamsat),
    ContactLink(label: 'BrightGaza', url: AppConstants.brightgaza),
    ContactLink(label: 'Jobmatch', url: AppConstants.jobmatch),
  ];
}
