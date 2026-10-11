class ContactLink {
  final String label;
  final String url;

  const ContactLink({required this.label, required this.url});

  factory ContactLink.fromJson(Map<String, dynamic> json) =>
      ContactLink(label: json['label'] as String? ?? '', url: json['url'] as String? ?? '');

  Map<String, dynamic> toJson() => {'label': label, 'url': url};
}
