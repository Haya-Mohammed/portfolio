import 'package:my_portfolio/models/project.dart';

const kProjects = <PortfolioProject>[
  PortfolioProject(
    id: 'lamha',
    title: 'Lamha — Smart Shopping, Local Delivery',
    summary:
        'An AI-powered multi-store shopping and delivery platform connecting customers with nearby local businesses through seamless shopping and delivery experiences.',
    contribution: 'Customer & Driver Mobile App Development, Flutter/Dart & API Integration',
    description:
        'Lamha is an AI-powered multi-store shopping and delivery platform designed to simplify everyday shopping by connecting customers with nearby local stores through a single application.\n\n'
        'The customer app enables users to discover nearby stores, browse products, manage shopping carts, and place orders. It features an intelligent shopping assistant powered by Google Gemini AI, helping users discover products and create shopping lists through natural language conversations.\n\n'
        'The dedicated driver app streamlines delivery operations with order management, delivery navigation, live order tracking, notifications, and earnings monitoring.\n\n'
        'The mobile applications are built using Flutter and Dart, integrated with a Node.js/Express backend and PostgreSQL database. Google Gemini API powers the AI shopping assistant, while OpenStreetMap and Leaflet support location-based services and delivery tracking.\n\n'
        'Our Role: Customer and Driver Mobile Application Development, including UI implementation, backend API integration, AI feature integration, and shopping and delivery workflows.',
    tags: [
      'Flutter',
      'Dart',
      'Node.js',
      'Express.js',
      'PostgreSQL',
      'Gemini AI',
      'OpenStreetMap',
      'Leaflet',
      'REST API Integration',
    ],
    images: [
      'assets/projects/lamha-1.png',
      'assets/projects/lamha-2.png',
      'assets/projects/lamha-3.png',
      'assets/projects/lamha-4.png',
    ],
  ),
  PortfolioProject(
    id: 'superfit',
    title: 'SuperFit',
    summary:
        'Fitness experiences for members and coaches, built to work reliably on poor connections.',
    contribution: 'Flutter architecture & API integration',
    description:
        'A team-based fitness app with separate user and coach experiences. I owned the Flutter architecture and backend integration, built a resilient caching layer so the app stays usable on poor connections, and fixed key signup and profile flows.',
    tags: ['Flutter', 'FastAPI', 'BLoC/Cubit', 'Clean Architecture'],
    images: ['assets/projects/superfit-1.jpeg', 'assets/projects/superfit-2.jpeg'],
  ),
  PortfolioProject(
    id: 'meethaq',
    title: 'Meethaq – Project & Contract Management',
    summary: 'Organize projects, contracts, progress, and client information in one place.',
    contribution: 'End-to-end Flutter development',
    description:
        'Meethaq is a comprehensive mobile app designed to simplify project and contract management. It enables users to organize projects, manage contracts, track progress, and maintain client information—all in one centralized platform. With an intuitive interface and streamlined workflows, Meethaq helps businesses stay organized, improve efficiency, and manage their operations with ease.',
    tags: ['Flutter', 'ASP.NET Core', 'BLoC/Cubit', 'Clean Architecture', 'Dio', 'GetIt'],
    images: [
      'assets/projects/meethaq-1.png',
      'assets/projects/meethaq-2.png',
      'assets/projects/meethaq-3.png',
    ],
  ),
  PortfolioProject(
    id: 'nova',
    title: 'NOVA – The Fashion Edit',
    summary: 'Explore fashion collections, save favorites, and shop with ease.',
    description:
        'NOVA is a modern fashion shopping app designed to deliver a seamless and elegant shopping experience. Users can explore fashion collections, discover products, save favorites, manage their shopping cart, place orders, and track purchases—all through a stylish, intuitive, and user-friendly interface.',
    tags: ['Flutter', 'E-commerce'],
    images: [
      'assets/projects/nova-1.png',
      'assets/projects/nova-2.png',
      'assets/projects/nova-3.png',
    ],
  ),
  PortfolioProject(
    id: 'mahalli',
    title: 'Mahalli - Smart Store Management App',
    summary: 'Manage store sales, stock, debts, and profits without internet access.',
    description:
        'Mahalli is an offline-first point-of-sale and store management app designed to simplify daily business operations. It helps shop owners manage sales, inventory, customer debts, expenses, and profits in one place. With real-time stock alerts, detailed financial reports, receipt printing, secure PIN protection, and local data backup, the app provides a simple and reliable solution for managing a store without an internet connection.',
    tags: ['Flutter', 'Offline-first', 'Point of sale'],
    images: [
      'assets/projects/mahalli-1.png',
      'assets/projects/mahalli-2.png',
      'assets/projects/mahalli-3.png',
      'assets/projects/mahalli-4.png',
    ],
    customUrl: 'https://github.com/Haya-Mohammed/mahalli/releases/tag/mahalli-v1.0.0',
    githubUrl: 'https://github.com/Haya-Mohammed/mahalli',
  ),
  PortfolioProject(
    id: 'mira',
    title: 'Mira – Beauty Salon Booking App',
    summary: 'Explore beauty services, book appointments, and track the queue in real time.',
    description:
        'Mira is a beauty salon booking app that allows users to explore beauty services, browse professional beauticians, and book appointments easily. It offers real-time queue tracking, booking management, service reviews, and personalized recommendations for a seamless salon experience.',
    tags: ['Flutter', 'Booking', 'Beauty'],
    images: [
      'assets/projects/mira-1.png',
      'assets/projects/mira-2.png',
      'assets/projects/mira-3.png',
    ],
  ),
  PortfolioProject(
    id: 'wareed',
    title: 'Wareed',
    summary: 'Helping blood donors in Gaza find banks and book available appointments.',
    contribution: 'Flutter app & booking flows',
    description:
        'A blood donation app that connects donors in Gaza with blood banks. Donors can search for blood banks, book and manage appointments, and verify their accounts. I built the Flutter app with Clean Architecture, Firebase Auth and Firestore, and transactional booking that prevents double-booked slots. It supports Arabic and English.',
    tags: ['Flutter', 'Firebase', 'Firestore', 'BLoC/Cubit', 'Clean Architecture'],
    images: [
      'assets/projects/Wareed-1.png',
      'assets/projects/Wareed-2.png',
      'assets/projects/Wareed-3.png',
    ],
  ),
  PortfolioProject(
    id: 'gym-app',
    title: 'Gym App',
    summary: 'An exercise and workout app with local persistence.',
    description:
        'Fitness app for exercises and workouts, with local persistence and feature-based Flutter architecture.',
    tags: ['Flutter', 'Hive', 'BLoC/Cubit', 'Clean Architecture'],
    images: ['assets/projects/8.jpg'],
  ),
  PortfolioProject(
    id: 'notes-app',
    title: 'Notes App',
    summary: 'A simple, offline place to create and organize notes.',
    description: 'Local notes app with create, read, update, and delete flows using Hive and MVVM.',
    tags: ['Flutter', 'Hive', 'MVVM'],
    githubUrl: 'https://github.com/Haya-Mohammed/my_notes',
    images: ['assets/projects/6.jpg'],
  ),
  PortfolioProject(
    id: 'books-app',
    title: 'Books App',
    summary: 'Browse books and explore details backed by a REST API.',
    description: 'E-book browsing and detail screens backed by a REST API and local storage.',
    tags: ['Flutter', 'REST API', 'Hive', 'Clean Architecture'],
    githubUrl: 'https://github.com/Haya-Mohammed/bookly_app',
    images: ['assets/projects/7.jpg'],
  ),
  PortfolioProject(
    id: 'news-app',
    title: 'Alhayaa News App',
    summary: 'Browse news by category, save articles, and share stories.',
    description:
        'Category-based news browsing powered by NewsAPI, with article sharing. Built with MVVM and BLoC/Cubit, cached images, Hive storage for articles, a dark theme that persists between sessions, and a native splash screen and app icon.',
    tags: ['Flutter', 'REST API', 'BLoC/Cubit', 'MVVM', 'Hive', 'Shared Preferences'],
    githubUrl: 'https://github.com/Haya-Mohammed/alhayaa_news_app',
    images: ['assets/projects/3.jpg'],
  ),
  PortfolioProject(
    id: 'cookbook-app',
    title: 'Cookbook App',
    summary: 'An offline recipe organizer for everyday cooking.',
    description: 'Recipe organizer with offline local storage.',
    tags: ['Flutter', 'Cubit', 'Hive'],
    portfolioOnly: true,
    githubUrl: 'https://github.com/Haya-Mohammed/my_cookbook',
    images: ['assets/projects/4.jpg'],
  ),
  PortfolioProject(
    id: 'ecommerce-ui-app',
    title: 'E-Commerce UI App',
    summary: 'A responsive shopping interface with reusable Flutter components.',
    description:
        'Flutter shopping interface focused on reusable components and responsive layouts.',
    tags: ['Flutter', 'Responsive UI', 'Firebase'],
    portfolioOnly: true,
    images: ['assets/projects/2.jpg'],
  ),
];
