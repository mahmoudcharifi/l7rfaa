import 'package:sqflite/sqflite.dart';

import '../database/fake_artisans.dart';
import '../database/database_helper.dart';
import '../database/tables.dart';

class FakeDataService {

  final DatabaseHelper _databaseHelper =
      DatabaseHelper.instance;

  Future<void> insertFakeArtisans() async {

    final Database db =
        await _databaseHelper.database;

    // Vérifier si des artisans existent déjà
    final result = await db.query(
      Tables.users,
      where: "role=?",
      whereArgs: ["artisan"],
    );

    if (result.isNotEmpty) {
      return;
    }

    // Insertion
    for (final artisan in fakeArtisans) {

      await db.insert(
        Tables.users,
        artisan.toMap(),
      );

    }

  }

  

}