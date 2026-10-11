class SkillGroup {
  final String? id;
  final String title;
  final String? description;
  final List<String> tags;

  const SkillGroup({this.id, required this.title, this.description, this.tags = const []});

  factory SkillGroup.fromJson(Map<String, dynamic> json) => SkillGroup(
    id: json['id'] as String?,
    title: json['title'] as String? ?? '',
    description: json['description'] as String?,
    tags: (json['tags'] as List?)?.whereType<String>().toList() ?? const [],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'tags': tags,
  };
}
