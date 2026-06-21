import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../database/tables.dart';
import '../models/message_model.dart';

class MessageService {

  final DatabaseHelper _databaseHelper =
      DatabaseHelper.instance;

  // Envoyer un message
  Future<void> sendMessage(
      MessageModel message) async {

    final Database db =
        await _databaseHelper.database;

    await db.insert(
      Tables.messages,
      message.toMap(),
    );

  }
    Future<List<Map<String, dynamic>>> getConversations(int userId) async {

    final db = await _databaseHelper.database;

    final result = await db.rawQuery('''

  SELECT
  u.id,
  u.firstName,
  u.lastName,
  u.image,
  u.role,

  m.message,

  MAX(m.id) as lastMessageId

  FROM messages m

  JOIN users u

  ON (

  (u.id = m.senderId AND m.receiverId = ?)

  OR

  (u.id = m.receiverId AND m.senderId = ?)

  )

  GROUP BY u.id

  ORDER BY lastMessageId DESC

  ''', [userId, userId]);

    return result;
  }
  // Conversation entre deux utilisateurs
  Future<List<MessageModel>> getConversation(

      int user1,

      int user2,

      ) async {

    final Database db =
        await _databaseHelper.database;

    final result = await db.query(

      Tables.messages,

      where: '''

      (senderId=? AND receiverId=?)

      OR

      (senderId=? AND receiverId=?)

      ''',

      whereArgs: [

        user1,

        user2,

        user2,

        user1,

      ],

      orderBy: "id ASC",

    );

    return result
        .map((e) => MessageModel.fromMap(e))
        .toList();

  }

}