import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:news_app/features/daily_news/data/data_sources/local/tables/article_table.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/dao/article_dao.dart';
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [ArticleTable],
daos: [ArticleDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'app_db.sqlite'));

    return NativeDatabase(file);
  });
}
