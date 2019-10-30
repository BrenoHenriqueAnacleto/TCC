import 'package:flutter/material.dart';
import 'package:agroquality/models/usuarioModel.dart';
import 'package:agroquality/constants.dart';

import 'dart:convert' as convert;
import 'package:dio/dio.dart';

class UsuarioForm extends StatefulWidget {
  final Usuario usuario;
  UsuarioForm(this.usuario);

  @override
  State<StatefulWidget> createState() => UsuarioFormState(usuario);
}

class UsuarioFormState extends State {
  Usuario usuario;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nomeController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmarSenhaController = TextEditingController();

  UsuarioFormState(Usuario usuario) {
    this.usuario = usuario;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cadastro'),
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                top: 5, left: 10.0, right: 10.0, bottom: 10.0),
                            child: TextFormField(
                              controller: nomeController,
                              decoration: InputDecoration(
                                  labelText: "Nome", filled: false),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Campo obrigatório";
                                }
                              },
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                top: 5, left: 10.0, right: 10.0, bottom: 10.0),
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  labelText: "Email", filled: false),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Campo obrigatório";
                                }
                              },
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                top: 5, left: 10.0, right: 10.0, bottom: 10.0),
                            child: TextFormField(
                              controller: telefoneController,
                              decoration: InputDecoration(
                                  labelText: "Telefone", filled: false),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Campo obrigatório";
                                }
                              },
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                top: 5, left: 10.0, right: 10.0, bottom: 10.0),
                            child: TextFormField(
                              controller: senhaController,
                              decoration: InputDecoration(
                                  labelText: "Senha", filled: false),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Campo obrigatório";
                                }
                              },
                              obscureText: true,
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                top: 5, left: 10.0, right: 10.0, bottom: 10.0),
                            child: TextFormField(
                              controller: confirmarSenhaController,
                              decoration: InputDecoration(
                                  labelText: "Confirmar senha", filled: false),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Campo obrigatório";
                                } else if (compararSenhas() == false) {
                                  return "As senhas informadas não são iguais";
                                }
                              },
                              obscureText: true,
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                this.save();
                              }
                            },
                            child: Text('Cadastre-se'),
                          ),
                        ),
                      ],
                    ))
              ],
            )));
  }

  void save() async {
    String nome = nomeController.text.toString();
    String email = emailController.text.toString();
    String telefone = telefoneController.text.toString();
    String senha = senhaController.text.toString();
    Map enviroment = environment();
    String url = enviroment['apiUrl'] + '/usuarios/cadastroUsuario';

    var jsonString = '''{
        "nome": "$nome",
        "email": "$email",
        "telefone": "$telefone",
        "administrador": false,
        "password": "$senha",
        "superUsuario": false,
        "excluido": false,
        "realm": "string",
        "username": "$nome",
        "emailVerified": true,
        "role": "usuario",
        "aplicativoId": "$idAplicativo"
      }
    ''';

    var dados = convert.jsonDecode(jsonString);

    var response = await Dio().post(url,
        data: dados,
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }));
    if (response.statusCode == 200) {
      Navigator.pop(context);
    } else if (response.statusCode == 422) {
      String mensagem = "Dados inválidos";
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Erro :("),
            content: new Text("$mensagem"),
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

  bool compararSenhas() {
    String senha = senhaController.value.text;
    String confirmarSenha = confirmarSenhaController.value.text;

    if ((senha?.isEmpty ?? true) ||
        (confirmarSenha?.isEmpty ?? true) ||
        (senha != confirmarSenha)) {
      return false;
    }
    return true;
  }
}
