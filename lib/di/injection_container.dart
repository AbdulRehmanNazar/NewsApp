import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/core/util/network_utility.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:news_app/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/daily_news/data/repository/article_repository_imp.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //Dio
  sl.registerSingleton(Dio());

  // Internet connection
  sl.registerSingleton<NetworkInfo>(NetworkInfoImpl());

//   DataBase
  sl.registerSingleton<AppDatabase>(AppDatabase());

  //   Dependencies
  sl.registerSingleton((NewsApiService(sl())));

  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImp(sl(), sl(),sl()));

  // Usecases
  sl.registerSingleton(GetArticleUseCase(sl()));

  //   Blocs
  sl.registerFactory<RemoteArticlesBloc>(() => RemoteArticlesBloc(sl()));
  }
