import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_architecture/core/views/reminder/model/reminder_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  static SqliteService? _sqliteService;
  static Database? _database;

  factory SqliteService() {
    if (_sqliteService == null) {
      _sqliteService = SqliteService._internal();
      return _sqliteService!;
    } else {
      return _sqliteService!;
    }
  }

  SqliteService._internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initializeDatabase();
      return _database!;
    } else {
      return _database!;
    }
  }

  Future<Database> _initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "workout.db");

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      debugPrint("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "workout.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      debugPrint("Opening existing database");
    }
    // open the database
    return await openDatabase(path, readOnly: false);
  }

  Future<List<Reminder>> getReminders() async {
    var reminderList = <Reminder>[];
    var db = await _getDatabase();
    var result = await db.query('ReminderTable');
    for (var item in result) {
      reminderList.add(Reminder.fromMap(item));
    }
    return reminderList;
  }

  Future<int> addReminder(Reminder reminder) async {
    var db = await _getDatabase();
    var result = await db.insert('ReminderTable', reminder.toMap());
    return result;
  }

  Future<int> updateReminder(Reminder reminder) async {
    var db = await _getDatabase();
    var result = await db.update('ReminderTable', reminder.toMap(), where: 'reminderID = ?', whereArgs: [reminder.reminderID]);
    return result;
  }

  Future<int?> deleteReminder(int? reminderID) async {
    if (reminderID != null) {
      var db = await _getDatabase();
      var result = await db.delete('ReminderTable', where: 'reminderID = ?', whereArgs: [reminderID]);
      return result;
    }
  }
}
