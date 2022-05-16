import 'package:drift/drift.dart';

class Favorite extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text()();
  TextColumn get image => text()();
  TextColumn get shortDesc => text()();

  @override
  Set<Column>? get primaryKey => {id};
}