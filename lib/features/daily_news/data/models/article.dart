import 'package:news_app/features/daily_news/domain/entities/article.dart';


class SourceModel {
  final String? id;
  final String? name;

  const SourceModel({
    this.id,
    this.name,
  });

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class ArticleDTO extends ArticleEntity {
  final SourceModel? source;

  const ArticleDTO({
    this.source,
    super.id,
    super.author,
    super.title,
    super.description,
    super.url,
    super.urlToImage,
    super.publishedAt,
    super.content,
  });

  factory ArticleDTO.fromJson(Map<String, dynamic> json) {
    return ArticleDTO(
      source: json['source'] != null
          ? SourceModel.fromJson(json['source'])
          : null,
      author: json['author'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
      urlToImage: json['urlToImage'] as String?,
      publishedAt: json['publishedAt'] as String?,
      content: json['content'] as String?,
    );
  }
}

class NewsResponseModel {
  final String? status;
  final int? totalResults;
  final List<ArticleDTO> articles;

  const NewsResponseModel({
    this.status,
    this.totalResults,
    required this.articles,
  });

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) {
    return NewsResponseModel(
      status: json['status'] as String?,
      totalResults: json['totalResults'] as int?,
      articles: (json['articles'] as List<dynamic>?)
          ?.map((e) => ArticleDTO.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }
}
