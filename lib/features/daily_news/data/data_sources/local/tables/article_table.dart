import 'package:drift/drift.dart';


class ArticleTable extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get author => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get url => text()();
  TextColumn get urlToImage => text()();
  TextColumn get publishedAt => text()();
  TextColumn get content => text()();
}
