import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class TableModelInterface {

  // Tabelas
  String tblAuth = "auth";

  // Tabelas em geral
  String colId       = "id";
  String colTalhaoId = "talhaoId";

  // Tabela de autenticação
  String colUsername = "username";
  String colRole     = "role";
  String colUserId   = "userId";

Future<Database> initializeDb() async {

    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "Agroquality.db";
    var dbTodos = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbTodos;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE $tblAuth (
      $colId	TEXT NOT NULL,
      $colUsername	TEXT NOT NULL,
      $colUserId	TEXT NOT NULL,
      $colRole	TEXT NOT NULL
      )''');
  }
}
