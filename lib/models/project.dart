class Project {
  final String number;
  final String title;
  final String description;
  final List<String> tags;
  final String? url;

  const Project({
    required this.number,
    required this.title,
    required this.description,
    required this.tags,
    this.url,
  });
}

const sampleProjects = [
  Project(
    number: '01',
    title: 'My Gym App',
    description:
        'A fitness tracking application that helps users manage their workouts, create training plans, explore exercises, and track their progress. It uses Hive for local storage and follows clean architecture principles to provide an organized and efficient user experience.',
    tags: ['Flutter', 'Dart', 'Clean Architecture', 'Cubit', 'Hive', 'Responsive UI'],
  ),

  Project(
    number: '02',
    title: 'My Notes App',
    description:
        'A note-taking app that allows users to create, edit, delete, and manage notes easily. It uses Hive for local data storage, providing fast and offline access with a simple and responsive UI.',
    tags: ['Flutter', 'Dart', 'Hive', 'MVVM Pattern', 'Local Storage'],
  ),

  Project(
    number: '03',
    title: 'My Cookbook App',
    description:
        'A recipe management application that allows users to save, organize, and explore their favorite recipes. It provides offline access using local storage with a simple and user-friendly interface.',
    tags: ['Flutter', 'Dart', 'Cubit', 'Hive', 'Local Storage', 'Responsive UI'],
  ),

  Project(
    number: '04',
    title: 'Pizza Delivery App',
    description:
        'A pizza delivery application featuring a modern shopping experience where users can explore products, view details, and interact with the ordering interface.',
    tags: ['Flutter', 'Dart', 'UI Design', 'Animations', 'Responsive UI', 'RESTfull API', 'GetX'],
  ),

  Project(
    number: '05',
    title: 'E-Commerce UI App',
    description:
        'A modern e-commerce user interface built with Flutter, focusing on reusable components, clean layouts, and responsive designs for a smooth shopping experience.',
    tags: ['Flutter', 'Dart', 'UI/UX', 'Reusable Widgets', 'Responsive UI'],
  ),
];
