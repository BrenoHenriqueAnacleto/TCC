import 'package:agroquality/forms/fazendaForm.dart';
import 'package:agroquality/tableModels/authTableModel.dart';
import 'package:flutter/material.dart';
import 'package:agroquality/models/fazendaModel.dart';
import 'package:agroquality/screens/talhao.dart';

import 'package:agroquality/constants.dart';
import 'package:dio/dio.dart';

class FazendaList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FazendaListState();
}

class FazendaListState extends State {
  List<Fazenda> fazendas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: fazendaListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navegarFormularioFazenda(Fazenda());
        },
        tooltip: "Adicionar nova fazenda",
        child: new Icon(Icons.add),
        backgroundColor: Color(0xFFFFCC00),
      ),
    );
  }

  FutureBuilder fazendaListItems() {
    return FutureBuilder(
        future: fazendasUsuario(),
        builder: (context, dados) {
          var connectionState = dados.connectionState;
          if (connectionState == ConnectionState.none) {
            return Container(
              height: 200.0,
              alignment: Alignment.center,
              child: Text('Erro :(',
                  style: TextStyle(color: Colors.black, fontSize: 16.0)),
            );
          } else if (connectionState == ConnectionState.waiting) {
            return Container(
              height: 200.0,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            );
          } else if(dados.data == null){
            return Container(
              height: 200.0,
              alignment: Alignment.center,
              child: Text('Nenhuma fazenda encontrada',
                  style: TextStyle(color: Colors.black, fontSize: 16.0)),
            );
          } else {
            return ListView.builder(
              itemCount: dados.data.length,
              itemBuilder: (BuildContext context, int position) {
                return Dismissible(
                  key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
                  background: Container(
                    color: Colors.red,
                    child: Align(
                      alignment: Alignment(0.9, 0.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  child: Center(
                      child: Card(
                          elevation: 6,
                          child: Container(
                              height: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(dados.data[position].nome),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          FlatButton.icon(
                                              color: Colors.white10,
                                              icon: Icon(Icons.edit),
                                              label: Text('Editar'),
                                              onPressed: () {
                                                navegarFormularioFazenda(
                                                    dados.data[position]);
                                              })
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          FlatButton.icon(
                                              color: Colors.white10,
                                              icon: Icon(Icons.layers),
                                              label: Text('Talhões'),
                                              onPressed: () {
                                                navegarPaginaTalhao(
                                                    dados.data[position]);
                                              })
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              )))),
                  confirmDismiss: (direction) {
                    _confirmarExclusao(dados.data[position]);
                  },
                );
              },
            );
          }
        });
  }

  void _confirmarExclusao(Fazenda fazenda) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Apagar fazenda"),
          content: new Text("Você realmente deseja apagar esta fazenda?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Apagar"),
              textColor: Colors.red,
              onPressed: () {
                deletarFazenda(fazenda);
              },
            ),
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

  fazendasUsuario() async {
    final AuthTableModel authTableModel = new AuthTableModel();
    final List<dynamic> auths = await authTableModel.getAuths();

    Map enviroment = environment();
    String token = auths[0]['id'];
    String url = enviroment['apiUrl'] +
        '/usuarios/' +
        auths[0]['userId'] +
        '/fazendas?access_token=' +
        token;

    var response = await Dio().get(url);

    List<dynamic> fazendas = new List<dynamic>();
    Fazenda fazenda = new Fazenda();
    response.data.forEach((element) => fazendas.add(fazenda.fromMap(element)));

    return fazendas;
  }

  void deletarFazenda(Fazenda fazenda) async {
    Navigator.pop(context, true);

    if (fazenda.id == null) {
      return;
    }

    final AuthTableModel authTableModel = new AuthTableModel();
    final List<dynamic> auths = await authTableModel.getAuths();

    Map enviroment = environment();

    String userId = auths[0]['userId'];
    String token = auths[0]['id'];
    String idFazenda = fazenda.id;
    String url = enviroment['apiUrl'] +
        '/usuarios/' +
        userId +
        '/fazendas/' +
        idFazenda +
        '?access_token=' +
        token;

    var dio = Dio();
    var response = await dio.delete(url);

    if (response.statusCode == 204 || response.statusCode == 200) {
      AlertDialog alertDialog = AlertDialog(
        title: Text("Fazenda deletada"),
        content: Text("A fazenda foi deletada"),
      );
      showDialog(context: context, builder: (_) => alertDialog);
      setState(() {
        fazendaListItems();
      });
    } else {
      AlertDialog alertDialog = AlertDialog(
        title: Text("Ocorreu um erro :("),
        content: Text("Por favor tente novamente"),
      );
      showDialog(context: context, builder: (_) => alertDialog);
    }
  }

  void navegarFormularioFazenda(dynamic fazenda) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FazendaForm(fazenda)),
    );
  }

  void navegarPaginaTalhao(Fazenda fazenda) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TalhaoPage(fazenda)),
    );
  }
}
