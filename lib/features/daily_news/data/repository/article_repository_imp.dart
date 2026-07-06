import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news_app/core/constants/costants.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';

class ArticleRepositoryImp implements ArticleRepository {
  final NewsApiService _newsApiService;

  ArticleRepositoryImp(this._newsApiService);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticle() async {
    try {
      final httpResponse = await _newsApiService.getNewsArticles(
        apiKey: apiKey,
        country: country,
        category: catagory,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
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
