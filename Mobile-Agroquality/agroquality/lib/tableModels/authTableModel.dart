import 'package:agroquality/tableModels/tableModelInterface.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:agroquality/models/authModel.dart';

class AuthTableModel extends TableModelInterface {

  static final AuthTableModel _authTableModel = AuthTableModel._internal();

  String tblAuth     = "auth";
  String colId       = "id";
  String colUsername = "username";
  String colRole     = "role";
  String colUserId   = "userId";

  AuthTableModel._internal();

  factory AuthTableModel() {
    return _authTableModel;
  }

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<int> insertAuth(Auth auth) async {
    Database db = await this.db;
    var result = await db.insert(tblAuth, auth.toMap());
    return result;
  }

  Future<List> getAuths() async {
    Database db = await this.db;
    var result =
        await db.rawQuery("SELECT * FROM $tblAuth");
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT (*) FROM $tblAuth"));
    return result;
  }

  Future<int> updateAuth(Auth auth) async {
    var db = await this.db;
    var result = await db
        .update(tblAuth, auth.toMap(), where: "$colId=?", whereArgs: [auth.id]);
    return result;
  }

  Future<int> deleteAuth(int id) async {
    int result;
    var db = await this.db;
    result = await db.rawDelete("DELETE FROM $tblAuth WHERE $colId=$id");
    return result;
  }
}
