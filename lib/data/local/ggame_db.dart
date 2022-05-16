import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../../models/favorite.dart';

part 'ggame_db.g.dart';

LazyDatabase _openConnection() => LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(path.join(dbFolder.path, 'favorite.sqlite'));
      return NativeDatabase(file);
    });

@DriftDatabase(tables: [Favorite])
class GgameDb extends _$GgameDb {
  GgameDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<FavoriteData>> getListFavorite() async =>
      await select(favorite).get();

  Future<FavoriteData?> getFavorite(int id) async =>
      await (select(favorite)..where((table) => table.id.equals(id)))
          .getSingleOrNull();

  Future<void> addFavorite(FavoriteData favorite) async =>
      await into(this.favorite).insert(favorite);

  Future<void> deleteFavorite(int id) async =>
      await (delete(favorite)..where((table) => table.id.equals(id))).go();

  Future<void> deleteAllFavorite() async => await delete(favorite).go();    
}
