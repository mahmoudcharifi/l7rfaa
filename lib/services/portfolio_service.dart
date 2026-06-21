import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../database/tables.dart';
import '../models/portfolio_model.dart';

class PortfolioService {

  final DatabaseHelper _databaseHelper =
      DatabaseHelper.instance;

  // Ajouter une réalisation
  Future<int> addPortfolio(
      PortfolioModel portfolio) async {

    final Database db =
        await _databaseHelper.database;

    return await db.insert(
      Tables.portfolio,
      portfolio.toMap(),
    );
  }

  // Toutes les réalisations d'un artisan
  Future<List<PortfolioModel>> getPortfolio(
      int userId) async {

    final Database db =
        await _databaseHelper.database;

    final result = await db.query(
      Tables.portfolio,
      where: "userId = ?",
      whereArgs: [userId],
    );

    return result
        .map((e) => PortfolioModel.fromMap(e))
        .toList();
  }

  // Supprimer une réalisation
  Future<void> deletePortfolio(int id) async {

    final Database db =
        await _databaseHelper.database;

    await db.delete(
      Tables.portfolio,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> updatePortfolio(PortfolioModel portfolio) async {

  final db = await _databaseHelper.database;

  return await db.update(

    Tables.portfolio,

    portfolio.toMap(),

    where: "id=?",

    whereArgs: [portfolio.id],

  );

}


}