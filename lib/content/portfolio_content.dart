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
  static const headline = 'Ideas. Iterations. Better Apps.';
  static const tagline = 'Thoughtful code. Delightful experiences.';

  static const introduction =
      'I build cross-platform mobile apps with Flutter and Dart, combining maintainable engineering with responsive, usable interfaces.';

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
      tags: ['REST APIs', 'Firebase', 'Hive', 'SQLite', 'Shared Preferences', 'Postman'],
    ),
    SkillGroup(
      title: 'Engineering workflow',
      description: 'Problem solving, error handling, and maintainable code.',
      tags: ['Git', 'GitHub', 'OOP', 'SOLID', 'Android Studio', 'VS Code'],
    ),
  ];

  static const projects = <PortfolioProject>[
    // Keep the cover first; an empty list displays the existing text card.
    PortfolioProject(
      id: 'superfit',
      title: 'SuperFit',
      description:
          'A team-based fitness app with separate user and coach experiences. I owned the Flutter architecture and backend integration, built a resilient caching layer so the app stays usable on poor connections, and fixed key signup and profile flows.',
      tags: ['Flutter', 'FastAPI', 'BLoC/Cubit', 'Clean Architecture'],
    ),
    PortfolioProject(
      id: 'meethaq',
      title: 'Meethaq',
      description:
          'A freelance management platform connecting freelancers and clients through staged contracts, project-linked chat, and milestone-based execution. I built the Flutter app end to end with a feature-first Clean Architecture, role-scoped API integration with an ASP.NET Core backend, and full Arabic localization.',
      tags: ['Flutter', 'ASP.NET Core', 'BLoC/Cubit', 'Clean Architecture', 'Dio', 'GetIt'],
    ),
    PortfolioProject(
      id: 'wareed',
      title: 'Wareed',
      description:
          'A blood donation app that connects donors in Gaza with blood banks. Donors can search for blood banks, book and manage appointments, and verify their accounts. I built the Flutter app with Clean Architecture, Firebase Auth and Firestore, and transactional booking that prevents double-booked slots. It supports Arabic and English.',
      tags: ['Flutter', 'Firebase', 'Firestore', 'BLoC/Cubit', 'Clean Architecture'],
    ),
    PortfolioProject(
      id: 'gym-app',
      title: 'Gym App',
      description:
          'Fitness app for exercises and workouts, with local persistence and feature-based Flutter architecture.',
      tags: ['Flutter', 'Hive', 'BLoC/Cubit', 'Clean Architecture'],
      images: ['assets/projects/8.jpg'],
    ),
    PortfolioProject(
      id: 'notes-app',
      title: 'Notes App',
      description:
          'Local notes app with create, read, update, and delete flows using Hive and MVVM.',
      tags: ['Flutter', 'Hive', 'MVVM'],
      url: 'https://github.com/Haya-Mohammed/my_notes',
      images: ['assets/projects/6.jpg'],
    ),
    PortfolioProject(
      id: 'books-app',
      title: 'Books App',
      description: 'E-book browsing and detail screens backed by a REST API and local storage.',
      tags: ['Flutter', 'REST API', 'Hive', 'Clean Architecture'],
      url: 'https://github.com/Haya-Mohammed/bookly_app',
      images: ['assets/projects/7.jpg'],
    ),
    PortfolioProject(
      id: 'news-app',
      title: 'Alhayaa News App',
      description:
          'Category-based news browsing powered by NewsAPI, with article sharing. Built with MVVM and BLoC/Cubit, cached images, Hive storage for articles, a dark theme that persists between sessions, and a native splash screen and app icon.',
      tags: ['Flutter', 'REST API', 'BLoC/Cubit', 'MVVM', 'Hive', 'Shared Preferences'],
      url: 'https://github.com/Haya-Mohammed/alhayaa_news_app',
      images: ['assets/projects/3.jpg'],
    ),
    PortfolioProject(
      id: 'cookbook-app',
      title: 'Cookbook App',
      description: 'Recipe organizer with offline local storage.',
      tags: ['Flutter', 'Cubit', 'Hive'],
      portfolioOnly: true,
      url: 'https://github.com/Haya-Mohammed/my_cookbook',
      images: ['assets/projects/4.jpg'],
    ),
    PortfolioProject(
      id: 'ecommerce-ui-app',
      title: 'E-Commerce UI App',
      description:
          'Flutter shopping interface focused on reusable components and responsive layouts.',
      tags: ['Flutter', 'Responsive UI', 'Firebase'],
      portfolioOnly: true,
      images: ['assets/projects/2.jpg'],
    ),
    PortfolioProject(
      id: 'pizza-delivery-app',
      title: 'Pizza Delivery App',
      description: 'Shopping interface for browsing pizzas and viewing product details.',
      tags: ['Flutter', 'GetX', 'REST API'],
      portfolioOnly: true,
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
    Certificate(title: 'Clean Architecture in Flutter', issuer: 'Udemy', date: 'Feb 2026'),
    Certificate(
      title: 'Relationships Engineering for Engineers',
      issuer: 'Association of Engineers, Gaza',
      date: 'Jun–Jul 2025',
    ),
    Certificate(title: 'Freelance Skills Training', issuer: 'Digiwork', details: '30 hours'),
    Certificate(title: 'Clean Architecture in Flutter', issuer: 'Udemy', date: 'Oct 2024'),
    Certificate(title: 'Flutter Advanced: BLoC and MVVM', issuer: 'Udemy', date: 'Jul 2024'),
    Certificate(title: 'Flutter and Dart Development', issuer: 'Udemy', date: 'Aug 2023'),
    Certificate(title: 'Flutter Development Guide', issuer: 'Udemy', date: 'Sep 2023'),
    Certificate(title: 'The Complete Dart Learning Guide', issuer: 'Udemy', date: 'Mar 2023'),
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
