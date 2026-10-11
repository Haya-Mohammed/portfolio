class Education {
  final String? id;
  final String degree;
  final String? institution;
  final String? period;

  /// e.g. GPA / honors line.
  final String? details;

  const Education({this.id, required this.degree, this.institution, this.period, this.details});

  /// 'Degree · Institution · Period', skipping null/empty parts.
  String get headline =>
      [degree, institution, period].where((part) => part != null && part.isNotEmpty).join(' · ');

  factory Education.fromJson(Map<String, dynamic> json) => Education(
    id: json['id'] as String?,
    degree: json['degree'] as String? ?? '',
    institution: json['institution'] as String?,
    period: json['period'] as String?,
    details: json['details'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'degree': degree,
    'institution': institution,
    'period': period,
    'details': details,
  };
}
