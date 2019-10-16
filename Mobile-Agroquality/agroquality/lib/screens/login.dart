import 'package:flutter/material.dart';
import 'package:agroquality/screens/cadastro.dart';
import 'package:agroquality/models/usuarioModel.dart';
import 'package:agroquality/models/authModel.dart';
import 'package:agroquality/tableModels/authTableModel.dart';
import 'package:agroquality/constants.dart';

import 'dart:convert' as convert;
import 'package:dio/dio.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {  

  Auth auth             = new Auth();
  AuthTableModel helper = AuthTableModel();

  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  sessaoFlutter(Auth auth) async{
    helper.insertAuth(auth);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
    onWillPop: () async => false,
    child:Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 40.0),
            Column(
              children: <Widget>[
                Image.asset('assets/logo-agroquality-oficial.png'),
              ],
            ),
            SizedBox(height: 30.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                filled: false,
                labelText: 'E-mail',
              ),
            ),
            Divider(color: Colors.white),
            TextField(
              controller: senhaController,
              decoration: InputDecoration(
                filled: false,
                labelText: 'Senha',
              ),
              obscureText: true,
            ),
            Divider(color: Colors.white),
            RaisedButton(
              child: Text('Entrar'),
              onPressed: () {
                autenticar();
                // Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('Cadastre-se'),
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) => UsuarioForm(new Usuario())),
                );
              },
            ),
            FlatButton(
              child: Text('Redefinir senha'),
              onPressed: () {
              },
            ),
            FlatButton(
              child: Text('Entrar como visitante'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    )
    );
  }

  autenticar() async {

    String email   = emailController.text.toString();
    String senha   = senhaController.text.toString();
    Map enviroment = environment();
    String url     = enviroment['apiUrl'] + '/usuarios/login';

    var jsonString = '''{
        "email":"$email",
        "password":"$senha",
        "usuario":{
          "email":"$email",
          "password":"$senha"
        }
      }
    ''';
    var dados    = convert.jsonDecode(jsonString);
    var response = await Dio().post(url,data: dados);
    auth.fromMap(response.data);
    sessaoFlutter(auth);
    if (response.statusCode == 200) {
      Navigator.pop(context);
    } else {
      _autenticacaoInvalida(response);
    }
  }

  void _autenticacaoInvalida (response){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Falha na autenticação"),
          content: new Text("E-mail ou senha inválidos."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Fechar"),
              textColor: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}