import 'package:my_portfolio/models/skill_group.dart';

const kSkills = <SkillGroup>[
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
