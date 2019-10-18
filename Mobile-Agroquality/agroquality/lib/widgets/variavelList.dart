import 'package:agroquality/models/etapaModel.dart';
import 'package:agroquality/models/variavelModel.dart';
import 'package:agroquality/tableModels/authTableModel.dart';
import 'package:flutter/material.dart';

import 'package:agroquality/constants.dart';
import 'package:dio/dio.dart';

class VariavelList extends StatefulWidget {
  final Etapa etapa;
  VariavelList(this.etapa);
  @override
  State<StatefulWidget> createState() => VariavelListState(etapa);
}

class VariavelListState extends State {

  Etapa  etapa; 
  
  VariavelListState(Etapa etapa){
    this.etapa = etapa;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: variavelListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        tooltip: "Adicionar",
        child: new Icon(Icons.add),
        backgroundColor: Color(0xFFFFCC00),
      ),
    );
  }

  FutureBuilder variavelListItems() {
    return FutureBuilder(
        future: variavelsAplicativo(), 
        builder: (context, dados) {
          var connectionState = dados.connectionState;
          if (connectionState == ConnectionState.none ||
              dados.data == null) {
            return Container(
              height: 200.0,
              alignment: Alignment.center,
              child: Text('Nenhum variavel encontrado',
                  style: TextStyle(color: Colors.black, fontSize: 16.0)),
            );
          } else if (dados.connectionState == ConnectionState.waiting) {
            return Container(
              height: 200.0,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
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
                                      Text(dados.data[position].identificadorDoVariavel),
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
                                          
                                              })
                                        ],
                                      ),
                                      // Column(
                                      //   children: <Widget>[
                                      //     FlatButton.icon(
                                      //         color: Colors.white10,
                                      //         icon: Icon(Icons.layers),
                                      //         label: Text('Variaveis'),
                                      //         onPressed: () {
                                      //           navegarPaginaVariavel(
                                      //               dados.data[position]);
                                      //         })
                                      //   ],
                                      // ),
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

  variavelsAplicativo() async {
    final AuthTableModel authTableModel = new AuthTableModel();
    final List<dynamic> auths = await authTableModel.getAuths();

    Map enviroment = environment();

    String token = auths[0]['id'];
    String url = enviroment['apiUrl'] +
        '/fazendas/' +
        '/talhoes?access_token=' +
        token;

    var response = await Dio().get(url);

    List<dynamic> talhoes = new List<dynamic>();
    Variavel variavel = new Variavel();
    response.data.forEach((element) => talhoes.add(variavel.fromMap(element)));
    return talhoes;
  }

  void _confirmarExclusao(Variavel variavel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Apagar variavel"),
          content: new Text("Você realmente deseja apagar esta variavel?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Apagar"),
              textColor: Colors.red,
              onPressed: () {
                deletarVariavel(variavel);
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

  void deletarVariavel(Variavel variavel) async {
    Navigator.pop(context, true);

    if (variavel.id == null) {
      return;
    }

    final AuthTableModel authTableModel = new AuthTableModel();
    final List<dynamic> auths = await authTableModel.getAuths();

    Map enviroment = environment();

    String token     = auths[0]['id'];
    String idVariavel  = variavel.id;
    String url       = enviroment['apiUrl'] +
        '/fazendas/' +
        '/talhoes/' +
        idVariavel +
        '?access_token=' +
        token;

    var dio = Dio();
    var response = await dio.delete(url);

    if (response.statusCode == 204 || response.statusCode == 200) {
      AlertDialog alertDialog = AlertDialog(
        title: Text("Variavel deletado"),
        content: Text("O variavel foi deletado"),
      );
      showDialog(context: context, builder: (_) => alertDialog);
      setState(() {
        variavelListItems();
      });
    } else {
      AlertDialog alertDialog = AlertDialog(
        title: Text("Ocorreu um erro :("),
        content: Text("Por favor tente novamente"),
      );
      showDialog(context: context, builder: (_) => alertDialog);
    }
  }

  void navegarFormularioVariavel(Variavel variavel) async {
    // bool result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => VariavelForm(variavel)),
    // );
    // if (result == true) {}
  }

  // void navegarPaginaVariavel(Variavel variavel) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => VariavelPage(variavel)),
  //   );
  // }
}
