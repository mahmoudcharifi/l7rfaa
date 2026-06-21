import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'tables.dart';

class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper._();

  DatabaseHelper._();

  static Database? _database;

  Future<Database> get database async {

    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();

    return _database!;
  }

  Future<Database> initDatabase() async {

    String path = join(
      await getDatabasesPath(),
      "l7rfa.db",
    );

    return await openDatabase(

      path,

      version: 2,

      onCreate: onCreate,

    );
  }

  Future<void> onCreate(
      Database db,
      int version,
      ) async {

    await db.execute("""

CREATE TABLE ${Tables.users}(

id INTEGER PRIMARY KEY AUTOINCREMENT,

firstName TEXT,

lastName TEXT,

phone TEXT,

email TEXT UNIQUE,

password TEXT,

role TEXT,

city TEXT,

job TEXT,

description TEXT,

experience TEXT,

image TEXT

)

""");

    await db.execute("""

CREATE TABLE ${Tables.portfolio}(

id INTEGER PRIMARY KEY AUTOINCREMENT,

userId INTEGER,

image TEXT,

title TEXT,

description TEXT

)

""");

    await db.execute("""

CREATE TABLE ${Tables.messages}(

id INTEGER PRIMARY KEY AUTOINCREMENT,

senderId INTEGER,

receiverId INTEGER,

message TEXT,

date TEXT,

isRead INTEGER DEFAULT 0


)

""");

    await db.execute("""

CREATE TABLE ${Tables.favorites}(

id INTEGER PRIMARY KEY AUTOINCREMENT,

clientId INTEGER,

artisanId INTEGER

)

""");

    await db.execute("""

CREATE TABLE ${Tables.reviews}(

id INTEGER PRIMARY KEY AUTOINCREMENT,

artisanId INTEGER,

clientId INTEGER,

rating REAL,

comment TEXT

)

""");

  }

}