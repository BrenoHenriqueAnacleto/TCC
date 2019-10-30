import 'package:agroquality/forms/variavelForm.dart';
import 'package:agroquality/models/etapaModel.dart';
import 'package:agroquality/models/talhaoModel.dart';
import 'package:agroquality/models/valorModel.dart';
import 'package:agroquality/screens/resultado.dart';
import 'package:agroquality/tableModels/authTableModel.dart';
import 'package:flutter/material.dart';

import 'package:agroquality/constants.dart';
import 'package:dio/dio.dart';

class VariavelList extends StatefulWidget {
  final Talhao talhao;
  final Etapa etapa;
  VariavelList(this.talhao,this.etapa);
  @override
  State<StatefulWidget> createState() => VariavelListState(talhao,etapa);
}

class VariavelListState extends State {

  Etapa  etapa; 
  Talhao talhao;
  String _etapaNome;
  VariavelListState(Talhao talhao, Etapa etapa){
    this.etapa  = etapa;
    this.talhao = talhao;
    _etapaNome  = etapa.nome.toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: variavelListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navegarFormularioVariavel(this.talhao,this.etapa, new Valor());
        },
        tooltip: "Adicionar variável de $_etapaNome",
        child: new Icon(Icons.add),
        backgroundColor: Color(0xFFFFCC00),
      ),
    );
  }

  FutureBuilder variavelListItems() {
    return FutureBuilder(
        future: variaveisEtapas(), 
        builder: (context, dados) {
          var connectionState = dados.connectionState;
          if (connectionState == ConnectionState.none) { 
            return Container(
            );
          } else if (dados.connectionState == ConnectionState.waiting) {
            return Container(
            );
          } else if (dados.data == null) {
            return Container(
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
                                      Text("Valores obtidos em: " + dados.data[position].periodo),
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
                                                navegarFormularioVariavel(this.talhao,this.etapa,dados.data[position]);
                                              })
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          FlatButton.icon(
                                              color: Colors.white10,
                                              icon: Icon(Icons.pie_chart),
                                              label: Text('Resultados'),
                                              onPressed: () {
                                                navegarResultado(this.talhao,this.etapa,dados.data[position]);
                                              })
                                        ],
                                      )
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

  variaveisEtapas() async {

    final AuthTableModel authTableModel = new AuthTableModel();
    final List<dynamic> auths = await authTableModel.getAuths();

    Map enviroment = environment();
    String token   = auths[0]['id'];
    String userId  = auths[0]['userId'];
    String etapaId = this.etapa.id;
    String url = enviroment['apiUrl'] +
        '/valoresVariaveisUsuarios/listagemValoresEtapaUsuario'
        + '?access_token=$token'
        + '&usuarioId=$userId' 
        + '&etapaId=$etapaId';

    var response = await Dio().get(url);
   
    List<dynamic> valores = new List<dynamic>();
    Valor valor = new Valor();
    if(response.data['valores'] != null){
      
      response.data['valores'].forEach((element) => valores.add(valor.fromMap(element)));
    }
    return valores;
  }

  void _confirmarExclusao(Valor valor) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Apagar valor"),
          content: new Text("Você realmente deseja apagar este valor?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Apagar"),
              textColor: Colors.red,
              onPressed: () {
                deletarVariavel(valor);
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

  void deletarVariavel(Valor valor) async {

    Navigator.pop(context, true);

    if (valor.id == null) {
      return;
    }

    final AuthTableModel authTableModel = new AuthTableModel();
    final List<dynamic> auths = await authTableModel.getAuths();

    Map enviroment = environment();

    String token   = auths[0]['id'];
    String idValor = valor.id;
    String url     = enviroment['apiUrl'] +
        '/valoresVariaveisUsuarios/exclusaoValor' +
        '?access_token=$token' +
        '&idValor=$idValor';

    var dio = Dio();
    var response = await dio.delete(url);

    if (response.statusCode == 204 || response.statusCode == 200) {
      AlertDialog alertDialog = AlertDialog(
        title: Text("Valor deletado"),
        content: Text("O valor foi deletado"),
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

  void navegarFormularioVariavel(Talhao talhao,Etapa etapa, Valor valor) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VariavelForm(talhao,etapa,valor)),
    );
    if (result == true) {}
  }

  void navegarResultado(Talhao talhao,Etapa etapa, Valor valor) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultadoPage(talhao,etapa,valor)),
    );
    if (result == true) {}
  }

}
