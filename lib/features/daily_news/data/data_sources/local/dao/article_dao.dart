import 'package:drift/drift.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/tables/article_table.dart';
part 'article_dao.g.dart';

@DriftAccessor(tables: [ArticleTable])
class ArticleDao extends DatabaseAccessor<AppDatabase>
    with _$ArticleDaoMixin{

  ArticleDao(AppDatabase db) : super(db);

  Future<List<ArticleTableData>> getArticles() {
    return select(articleTable).get();
  }

  Stream<List<ArticleTableData>> watchArticles() {
    return select(articleTable).watch();
  }

  Future<int> insertArticle(ArticleTableCompanion article) {
    return into(articleTable).insert(article);
  }

  Future<bool> updateArticle(ArticleTableData article) {
    return update(articleTable).replace(article);
  }

  Future<int> deleteArticle(ArticleTableData article) {
    return delete(articleTable).delete(article);
  }
}
