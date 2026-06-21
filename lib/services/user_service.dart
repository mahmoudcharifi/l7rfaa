import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../database/tables.dart';
import '../models/user.dart';

class UserService {

  final DatabaseHelper _databaseHelper =
      DatabaseHelper.instance;

  // Tous les artisans
  Future<List<UserModel>> getArtisans() async {

    final Database db =
        await _databaseHelper.database;

    final result = await db.query(
      Tables.users,
      where: "role = ?",
      whereArgs: ["artisan"],
    );

    return result
        .map((e) => UserModel.fromMap(e))
        .toList();
  }

  // Recherche
  Future<List<UserModel>> searchArtisans(
      String keyword) async {

    final Database db =
        await _databaseHelper.database;

    final result = await db.query(

      Tables.users,

      where: '''
      role = ? AND (
      firstName LIKE ? OR
      lastName LIKE ? OR
      job LIKE ? OR
      city LIKE ?
      )
      ''',

      whereArgs: [

        "artisan",

        "%$keyword%",

        "%$keyword%",

        "%$keyword%",

        "%$keyword%",

      ],

    );

    return result
        .map((e) => UserModel.fromMap(e))
        .toList();

  }
  Future<UserModel?> getUserById(int id) async {

  final db = await _databaseHelper.database;

  final result = await db.query(

    Tables.users,

    where: "id = ?",

    whereArgs: [id],

  );

  if (result.isEmpty) {

    return null;

  }

  return UserModel.fromMap(result.first);

}

Future<List<UserModel>> getArtisansByJob(String job) async {

  final db = await _databaseHelper.database;

  final result = await db.query(

    Tables.users,

    where: "role = ? AND job = ?",

    whereArgs: [

      "artisan",

      job,

    ],

  );

  return result.map((e) => UserModel.fromMap(e)).toList();

}
}