import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news_app/core/constants/costants.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/util/network_utility.dart';
import 'package:news_app/features/daily_news/data/articles_mapper.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/tables/article_table.dart';
import 'package:news_app/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';

class ArticleRepositoryImp implements ArticleRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;
  final NetworkInfo _networkInfo;

  ArticleRepositoryImp(
    this._newsApiService,
    this._appDatabase,
    this._networkInfo,
  );

  @override
  Future<DataState<List<ArticleDTO>>> getNewsArticle() async {
    try {
      if (!await _networkInfo.isConnected) {
        final articles = await _appDatabase.articleDao.watchArticles().first;

        if (articles.isNotEmpty) {
          return DataSuccess(ArticleMapper().fromTableList(articles));
        }

        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            error: 'No internet connection and no cached data available.',
          ),
        );
      } else {
        final httpResponse = await _newsApiService.getNewsArticles(
          apiKey: apiKey,
          country: country,
          category: catagory,
        );

        if (httpResponse.response.statusCode == HttpStatus.ok) {
          // Insert Data into Local DB
          for (int i = 0; i < httpResponse.data.articles.length; i++) {
            ArticleDTO itemArticle = httpResponse.data.articles[i];

            _appDatabase.articleDao.insertArticle(
              ArticleMapper().toCompanion(itemArticle),
            );
          }

          return DataSuccess(httpResponse.data.articles);
        } else {
          return DataFailed(
            DioException(
              requestOptions: httpResponse.response.requestOptions,
              error: httpResponse.response,
              type: DioExceptionType.unknown,
              message: httpResponse.response.statusMessage,
            ),
          );
        }
      }
    } on DioException catch (e) {
      return DataFailed(
        DioException(
          requestOptions: RequestOptions(),
          error: e.error,
          type: DioExceptionType.unknown,
          message: e.message,
        ),
      );
    }
  }
}
