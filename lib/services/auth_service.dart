import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../database/tables.dart';
import '../models/user.dart';

class AuthService {

  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  // ===========================
  // Register
  // ===========================

  Future<bool> register(UserModel user) async {

    final Database db = await _databaseHelper.database;

    // Vérifier si l'email existe déjà
    final result = await db.query(
      Tables.users,
      where: "email = ?",
      whereArgs: [user.email],
    );

    if (result.isNotEmpty) {
      return false;
    }

    await db.insert(
      Tables.users,
      user.toMap(),
    );

    return true;
  }

  // ===========================
  // Login
  // ===========================

  Future<UserModel?> login(
      String email,
      String password,
      ) async {

    final Database db = await _databaseHelper.database;

    final result = await db.query(
      Tables.users,
      where: "email=? AND password=?",
      whereArgs: [email, password],
    );

    if (result.isEmpty) {
      return null;
    }

    UserModel user = UserModel.fromMap(result.first);

    await saveSession(user);

    return user;
  }

  // ===========================
  // Save Session
  // ===========================

  Future<void> saveSession(UserModel user) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool("isLoggedIn", true);

    await prefs.setInt("userId", user.id!);

    await prefs.setString("role", user.role);
  }

  // ===========================
  // Logout
  // ===========================

  Future<void> logout() async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();

  }

  // ===========================
  // Is Logged
  // ===========================

  Future<bool> isLoggedIn() async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool("isLoggedIn") ?? false;

  }

  // ===========================
  // Get Role
  // ===========================

  Future<String?> getRole() async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("role");

  }


  Future<int?> getUserId() async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt("userId");

  }
}