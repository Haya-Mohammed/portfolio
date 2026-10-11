class PortfolioProject {
  final String? id;
  final String title;
  final String? description;
  final List<String> tags;

  final List<String> images;
  final String? url;
  final bool portfolioOnly;

  const PortfolioProject({
    this.id,
    required this.title,
    this.description,
    this.tags = const [],
    this.images = const [],
    this.url,
    this.portfolioOnly = false,
  });

  bool get hasImages => images.isNotEmpty;
  bool get hasUrl => url != null && url!.isNotEmpty;

  factory PortfolioProject.fromJson(Map<String, dynamic> json) {
    return PortfolioProject(
      id: json['id'] as String?,
      title: json['title'] as String? ?? '',
      description: json['description'] as String?,
      tags: (json['tags'] as List?)?.whereType<String>().toList() ?? const [],
      images: (json['images'] as List?)?.whereType<String>().toList() ?? const [],
      url: json['url'] as String?,
      portfolioOnly: json['portfolioOnly'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'tags': tags,
    'images': images,
    'url': url,
    'portfolioOnly': portfolioOnly,
  };

  PortfolioProject copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? tags,
    List<String>? images,
    String? url,
    bool? portfolioOnly,
  }) {
    return PortfolioProject(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      images: images ?? this.images,
      url: url ?? this.url,
      portfolioOnly: portfolioOnly ?? this.portfolioOnly,
    );
  }
}
