class Certificate {
  final String? id;
  final String title;
  final String? issuer;
  final String? date;

  final String? details;

  const Certificate({this.id, required this.title, this.issuer, this.date, this.details});

  String get summary =>
      [title, issuer, date, details].where((part) => part != null && part.isNotEmpty).join(' · ');

  factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
    id: json['id'] as String?,
    title: json['title'] as String? ?? '',
    issuer: json['issuer'] as String?,
    date: json['date'] as String?,
    details: json['details'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'issuer': issuer,
    'date': date,
    'details': details,
  };
}
