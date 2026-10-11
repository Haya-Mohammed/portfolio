class Experience {
  final String? id;
  final String role;
  final String? organization;
  final String? dates;
  final String? description;

  const Experience({this.id, required this.role, this.organization, this.dates, this.description});

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
    id: json['id'] as String?,
    role: json['role'] as String? ?? '',
    organization: json['organization'] as String?,
    dates: json['dates'] as String?,
    description: json['description'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'role': role,
    'organization': organization,
    'dates': dates,
    'description': description,
  };
}
