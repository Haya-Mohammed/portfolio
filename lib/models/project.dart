class PortfolioProject {
  final String? id;
  final String title;
  final String? summary;
  final String? contribution;
  final String? description;
  final List<String> tags;

  final List<String> images;
  final String? githubUrl;
  final String? customUrl;
  final bool portfolioOnly;

  const PortfolioProject({
    this.id,
    required this.title,
    this.summary,
    this.contribution,
    this.description,
    this.tags = const [],
    this.images = const [],
    this.githubUrl,
    this.customUrl,
    this.portfolioOnly = false,
  });

  bool get hasImages => images.isNotEmpty;
  bool get hasGithubUrl => githubUrl != null && githubUrl!.isNotEmpty;
  bool get hasCustomUrl => customUrl != null && customUrl!.isNotEmpty;

  factory PortfolioProject.fromJson(Map<String, dynamic> json) {
    return PortfolioProject(
      id: json['id'] as String?,
      title: json['title'] as String? ?? '',
      summary: json['summary'] as String?,
      contribution: json['contribution'] as String?,
      description: json['description'] as String?,
      tags: (json['tags'] as List?)?.whereType<String>().toList() ?? const [],
      images:
          (json['images'] as List?)?.whereType<String>().toList() ?? const [],
      githubUrl: json['githubUrl'] as String? ?? json['url'] as String?,
      customUrl: json['customUrl'] as String?,
      portfolioOnly: json['portfolioOnly'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'summary': summary,
    'contribution': contribution,
    'description': description,
    'tags': tags,
    'images': images,
    'githubUrl': githubUrl,
    'customUrl': customUrl,
    'portfolioOnly': portfolioOnly,
  };

  PortfolioProject copyWith({
    String? id,
    String? title,
    String? summary,
    String? contribution,
    String? description,
    List<String>? tags,
    List<String>? images,
    String? githubUrl,
    String? customUrl,
    bool? portfolioOnly,
  }) {
    return PortfolioProject(
      id: id ?? this.id,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      contribution: contribution ?? this.contribution,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      images: images ?? this.images,
      githubUrl: githubUrl ?? this.githubUrl,
      customUrl: customUrl ?? this.customUrl,
      portfolioOnly: portfolioOnly ?? this.portfolioOnly,
    );
  }
}
