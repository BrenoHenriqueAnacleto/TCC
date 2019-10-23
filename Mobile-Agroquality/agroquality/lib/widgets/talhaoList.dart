import 'package:agroquality/forms/talhaoForm.dart';
import 'package:agroquality/models/fazendaModel.dart';
import 'package:agroquality/tableModels/authTableModel.dart';
import 'package:flutter/material.dart';
import 'package:agroquality/models/talhaoModel.dart';
import 'package:agroquality/screens/variavel.dart';

import 'package:agroquality/constants.dart';
import 'package:dio/dio.dart';

class TalhaoList extends StatefulWidget {
  final Fazenda fazenda;
  TalhaoList(this.fazenda);
  @override
  State<StatefulWidget> createState() => TalhaoListState(fazenda);
}

class TalhaoListState extends State {
  Fazenda fazenda;

  TalhaoListState(Fazenda fazenda) {
    this.fazenda = fazenda;
  }

  List<Talhao> talhaos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: talhaoListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navegarFormularioTalhao(Talhao(), this.fazenda);
        },
        tooltip: "Adicionar novo talhão",
        child: new Icon(Icons.add),
        backgroundColor: Color(0xFFFFCC00),
      ),
    );
  }

  FutureBuilder talhaoListItems() {
    return FutureBuilder(
        future: talhoesFazenda(), 
        builder: (context, dados) {
          var connectionState = dados.connectionState;
          if (connectionState == ConnectionState.none) {
            return Container(
              height: 200.0,
              alignment: Alignment.center,
              child: Text('Erro : (',
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
              child: Text('Nenhum talhão encontrado',
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
                                      Text(dados.data[position].identificadorDoTalhao),
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
                                                navegarFormularioTalhao(
                                                    dados.data[position],
                                                    this.fazenda);
                                              })
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          FlatButton.icon(
                                              color: Colors.white10,
                                              icon: Icon(Icons.layers),
                                              label: Text('Variaveis'),
                                              onPressed: () {
                                                navegarPaginaVariavel(
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

  talhoesFazenda() async {
    final AuthTableModel authTableModel = new AuthTableModel();
    final List<dynamic> auths = await authTableModel.getAuths();

    Map enviroment = environment();

    String token = auths[0]['id'];
    String url = enviroment['apiUrl'] +
        '/fazendas/' +
        this.fazenda.id +
        '/talhoes?access_token=' +
        token;

    var response = await Dio().get(url);

    List<dynamic> talhoes = new List<dynamic>();
    Talhao talhao = new Talhao();
    response.data.forEach((element) => talhoes.add(talhao.fromMap(element)));
    return talhoes;
  }

  void _confirmarExclusao(Talhao talhao) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Apagar talhão"),
          content: new Text("Você realmente deseja apagar esta talhão?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Apagar"),
              textColor: Colors.red,
              onPressed: () {
                deletarTalhao(talhao);
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

  void deletarTalhao(Talhao talhao) async {
    Navigator.pop(context, true);

    if (talhao.id == null) {
      return;
    }

    final AuthTableModel authTableModel = new AuthTableModel();
    final List<dynamic> auths = await authTableModel.getAuths();

    Map enviroment = environment();

    String token     = auths[0]['id'];
    String idFazenda = this.fazenda.id;
    String idTalhao  = talhao.id;
    String url       = enviroment['apiUrl'] +
        '/fazendas/' +
        idFazenda +
        '/talhoes/' +
        idTalhao +
        '?access_token=' +
        token;

    var dio = Dio();
    var response = await dio.delete(url);

    if (response.statusCode == 204 || response.statusCode == 200) {
      AlertDialog alertDialog = AlertDialog(
        title: Text("Talhão deletado"),
        content: Text("O talhão foi deletado"),
      );
      showDialog(context: context, builder: (_) => alertDialog);
      setState(() {
        talhaoListItems();
      });
    } else {
      AlertDialog alertDialog = AlertDialog(
        title: Text("Ocorreu um erro :("),
        content: Text("Por favor tente novamente"),
      );
      showDialog(context: context, builder: (_) => alertDialog);
    }
  }

  void navegarFormularioTalhao(Talhao talhao, Fazenda fazenda) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TalhaoForm(talhao, fazenda)),
    );
    if (result == true) {}
  }

  void navegarPaginaVariavel(Talhao talhao) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VariavelPage(talhao)),
    );
  }
}
