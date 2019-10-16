import 'package:agroquality/tableModels/tableModelInterface.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:agroquality/models/usuarioModel.dart';

class UsuarioTableModel extends TableModelInterface {

  static final UsuarioTableModel _usuarioTableModel = UsuarioTableModel._internal();

  String tblUsuario  = "usuario";
  String colId       = "id";
  String colNome     = "nome";
  String colTelefone = "telefone";
  String colEmail    = "email";
  String colSenha    = "senha";

  UsuarioTableModel._internal();

  factory UsuarioTableModel() {
    return _usuarioTableModel;
  }

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<int> insertUsuario(Usuario usuario) async {
    Database db = await this.db;
    var result = await db.insert(tblUsuario, usuario.toMap());
    return result;
  }

  Future<List> getUsuarios() async {
    Database db = await this.db;
    var result =
        await db.rawQuery("SELECT * FROM $tblUsuario");
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT (*) FROM $tblUsuario"));
    return result;
  }

  Future<int> updateUsuario(Usuario usuario) async {
    var db = await this.db;
    var result = await db
        .update(tblUsuario, usuario.toMap(), where: "$colId=?", whereArgs: [usuario.id]);
    return result;
  }

  Future<int> deleteUsuario(int id) async {
    int result;
    var db = await this.db;
    result = await db.rawDelete("DELETE FROM $tblUsuario WHERE $colId=$id");
    return result;
  }
}
