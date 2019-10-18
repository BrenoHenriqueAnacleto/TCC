import 'package:agroquality/constants.dart';
import 'package:agroquality/tableModels/authTableModel.dart';
import 'package:flutter/material.dart';
import 'package:agroquality/models/talhaoModel.dart';
import 'package:agroquality/models/fazendaModel.dart';

import 'dart:convert' as convert;
import 'package:dio/dio.dart';

class TalhaoForm extends StatefulWidget {
  final Fazenda fazenda;
  final Talhao talhao;
  TalhaoForm(this.talhao, this.fazenda);

  @override
  State<StatefulWidget> createState() => TalhaoFormState(talhao, fazenda);
}

class TalhaoFormState extends State {
  Talhao talhao;
  Fazenda fazenda;
  String _titulo;
  String _botao;

  TextEditingController identificadorTalhaoController = TextEditingController();
  TextEditingController culturaController = TextEditingController();
  TextEditingController tamanhoDoTalhaoController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TalhaoFormState(Talhao talhao, Fazenda fazenda) {
    this.talhao = talhao;
    this.fazenda = fazenda;

    this.talhao.fazendaId = this.fazenda.id;

    if (this.talhao.id != null) {
      _titulo = "Editar Talhão";
      _botao = "Salvar alterações";
      identificadorTalhaoController.text = talhao.identificadorDoTalhao;
      culturaController.text = talhao.cultura.toString();
      tamanhoDoTalhaoController.text = talhao.tamanhoDoTalhao.toString();
    } else {
      _titulo = "Novo Talhão";
      _botao = "Adicionar talhão";
      identificadorTalhaoController.text = "";
      culturaController.text = "";
      tamanhoDoTalhaoController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('$_titulo'),
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
                            padding: EdgeInsets.only(top: 5, bottom: 15.0),
                            child: TextFormField(
                              controller: identificadorTalhaoController,
                              decoration: InputDecoration(
                                  labelText: "Identificador do talhão",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  )),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Campo obrigatório";
                                }
                              },
                            )),
                        Padding(
                            padding: EdgeInsets.only(top: 0, bottom: 15.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: tamanhoDoTalhaoController,
                              decoration: InputDecoration(
                                  labelText: "Área do talhão (ha)",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  )),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Campo obrigatório";
                                }
                              },
                            )),
                        Padding(
                            padding: EdgeInsets.only(top: 0, bottom: 15.0),
                            child: TextFormField(
                              controller: culturaController,
                              decoration: InputDecoration(
                                  labelText: "Cultura do talhão",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  )),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Campo obrigatório";
                                }
                              },
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                if (this.talhao.id != null) {
                                  editar();
                                } else {
                                  adicionar();
                                }
                              }
                            },
                            child: Text('$_botao'),
                          ),
                        ),
                      ],
                    ))
              ],
            )));
  }

  void adicionar() async {
    final AuthTableModel authTableModel = new AuthTableModel();
    final List<dynamic> auths = await authTableModel.getAuths();

    Map enviroment = environment();

    String token = auths[0]['id'];
    String fazendaId = this.fazenda.id;
    String url = enviroment['apiUrl'] +
        '/fazendas/' +
        fazendaId +
        '/talhoes?access_token=' +
        token;

    String identificadorTalhao = identificadorTalhaoController.text;
    String culturaTalhao = culturaController.text;
    double tamanhoDoTalhao = double.parse(tamanhoDoTalhaoController.text);

    var jsonString = '''{
        "identificacaoDoTalhao":"$identificadorTalhao",
        "tamanhoDoTalhao":"$tamanhoDoTalhao",
        "cultura":"$culturaTalhao",
        "fazendaId": "$fazendaId"
      }
    ''';

    var dio = Dio();
    var dados = convert.jsonDecode(jsonString);
    var response = await dio.post(url, data: dados);

    if (response.statusCode == 200) {
      Navigator.pop(context);
    } else {
      AlertDialog alertDialog = AlertDialog(
        title: Text("Ocorreu um erro :("),
        content: Text("Por favor tente novamente"),
      );
      showDialog(context: context, builder: (_) => alertDialog);
    }
  }

  void editar() async {
    final AuthTableModel authTableModel = new AuthTableModel();
    final List<dynamic> auths = await authTableModel.getAuths();

    Map enviroment = environment();

    String idTalhao = this.talhao.id;
    String token = auths[0]['id'];
    String idFazenda = this.fazenda.id;
    String url = enviroment['apiUrl'] +
        '/fazendas/' +
        idFazenda +
        '/talhoes/' +
        idTalhao +
        '?access_token=' +
        token;

    String fazendaId = this.fazenda.id;
    String identificadorTalhao = identificadorTalhaoController.text;
    String culturaTalhao = culturaController.text;
    double tamanhoDoTalhao = double.parse(tamanhoDoTalhaoController.text);

    var jsonString = '''{
        "identificacaoDoTalhao":"$identificadorTalhao",
        "tamanhoDoTalhao":"$tamanhoDoTalhao",
        "cultura":"$culturaTalhao",
        "fazendaId": "$fazendaId",
        "id":"$idTalhao"
      }
    ''';
    
    var dio = Dio();
    var dados = convert.jsonDecode(jsonString);
    var response = await dio.put(url, data: dados);

    if (response.statusCode == 200) {
      Navigator.pop(context);
    } else {
      AlertDialog alertDialog = AlertDialog(
        title: Text("Ocorreu um erro :("),
        content: Text("Por favor tente novamente"),
      );
      showDialog(context: context, builder: (_) => alertDialog);
    }
  }
}
