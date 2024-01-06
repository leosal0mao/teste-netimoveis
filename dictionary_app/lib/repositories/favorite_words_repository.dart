import 'package:sqflite/sqflite.dart';

import '../entities/word.dart';
import 'package:path/path.dart';

class FavoriteWordsRepository {
  Future<Database> get database async {
    return await openDatabase(
      join(await getDatabasesPath(), 'favoriteWords.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE favoriteWords(id TEXT PRIMARY KEY, value TEXT)', // SQL command to create a table
        );
      },
      version: 1,
    );
  }

  Future<bool> isWordOnFavorites(String word) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'favoriteWords',
      where: 'value = ?',
      whereArgs: [word],
    );
    return maps.isNotEmpty;
  }

  Future<Word> addWordToFavorites(Word word) async {
    final db = await database;
    if (await isWordOnFavorites(word.word!)) {
      throw ArgumentError('Word is already on favorites.');
    }
    await db.insert(
      'favoriteWords',
      word.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return word;
  }

  Future<List<Map<String, dynamic>>> getFavoriteWords() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favoriteWords');
    return List.generate(maps.length, (i) => maps[i]);
  }

  Future<void> deleteWordFromFavorites(Word word) async {
    final db = await database;
    await db.delete(
      'favoriteWords',
      where: 'value = ?',
      whereArgs: [word.word!],
    );
  }
}
