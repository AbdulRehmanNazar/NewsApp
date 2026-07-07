
import 'package:news_app/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';

class ArticleMapper {
  const ArticleMapper();

  /// DTO -> Drift Companion (Insert)
  ArticleTableCompanion toCompanion(ArticleDTO dto) {
    return ArticleTableCompanion.insert(
      author: dto.author ?? '',
      title: dto.title ?? '',
      description: dto.description ?? '',
      url: dto.url ?? '',
      urlToImage: dto.urlToImage ?? '',
      publishedAt: dto.publishedAt ?? '',
      content: dto.content ?? '',
    );
  }

  /// Drift Data -> DTO
  ArticleDTO fromTable(ArticleTableData data) {
    return ArticleDTO(
      id: data.id,
      author: data.author,
      title: data.title,
      description: data.description,
      url: data.url,
      urlToImage: data.urlToImage,
      publishedAt: data.publishedAt,
      content: data.content,
    );
  }

  /// List<DTO> -> List<Companion>
  List<ArticleTableCompanion> toCompanionList(
      List<ArticleDTO> articles) {
    return articles.map(toCompanion).toList();
  }

  /// List<Table> -> List<DTO>
  List<ArticleDTO> fromTableList(
      List<ArticleTableData> articles) {
    return articles.map(fromTable).toList();
  }
}