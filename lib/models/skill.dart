class Skill {
  final String icon;
  final String name;
  final String description;
  final List<String> tags;

  const Skill({
    required this.icon,
    required this.name,
    required this.description,
    required this.tags,
  });
}

const sampleSkills = [
  Skill(
    icon: '📱',
    name: 'Mobile App Development',
    description:
        'Building high-quality cross-platform mobile applications with modern Flutter development practices and responsive user interfaces.',
    tags: ['Flutter', 'Dart', 'Android', 'iOS'],
  ),

  Skill(
    icon: '🏗️',
    name: 'Flutter Architecture',
    description:
        'Designing scalable and maintainable applications using clean architecture principles and well-structured code.',
    tags: ['Clean Architecture', 'MVVM', 'Repository Pattern', 'SOLID Principles'],
  ),

  Skill(
    icon: '⚡',
    name: 'State Management',
    description:
        'Managing complex application states efficiently using modern Flutter state management solutions.',
    tags: ['Bloc', 'Cubit', 'Provider', 'GetX'],
  ),

  Skill(
    icon: '🎨',
    name: 'UI/UX Development',
    description:
        'Creating responsive, intuitive, and visually appealing interfaces from designs with attention to user experience.',
    tags: ['Flutter UI', 'Responsive Design', 'Animations', 'Figma'],
  ),

  Skill(
    icon: '💾',
    name: 'Local Data Storage',
    description:
        'Implementing offline-first applications with efficient local data persistence solutions.',
    tags: ['Hive', 'Shared Preferences', 'Local Database'],
  ),

  Skill(
    icon: '🌐',
    name: 'Backend Integration',
    description:
        'Connecting mobile applications with backend services and handling data communication efficiently.',
    tags: ['REST API', 'JSON', 'Firebase', 'Postman'],
  ),

  Skill(
    icon: '🔧',
    name: 'Development Tools',
    description:
        'Using professional tools and workflows to build, test, debug, and maintain Flutter applications.',
    tags: ['Git', 'GitHub', 'Android Studio', 'VS Code'],
  ),

  Skill(
    icon: '🚀',
    name: 'Software Engineering',
    description:
        'Applying software engineering principles to write clean, reusable, and maintainable code.',
    tags: ['OOP', 'Design Patterns', 'Agile', 'Problem Solving'],
  ),
];
