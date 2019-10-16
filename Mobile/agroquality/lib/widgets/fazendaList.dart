import 'package:agroquality/forms/fazendaForm.dart';
import 'package:flutter/material.dart';
import 'package:agroquality/models/fazendaModel.dart';
import 'package:agroquality/screens/talhao.dart';

import 'package:agroquality/constants.dart';

import 'dart:convert' as convert;
import 'package:dio/dio.dart';


class FazendaList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FazendaListState();
}

class FazendaListState extends State {
  List<Fazenda> fazendas;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    // if (fazendas == null) {
    //   fazendas = List<Fazenda>();
    //   fazendasUsuario();
    //   getData();
    // }
    return Scaffold(
      body: fazendaListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navegarFormularioFazenda(Fazenda('', 0));
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
    builder: (context, projectSnap) {
      if (projectSnap.connectionState == ConnectionState.none &&
          projectSnap.hasData == null) {
        return SliverToBoxAdapter(
          child: Container(
            height: 200.0,
            alignment: Alignment.center,
            child: Text('Velocidade do vento',
                  style: TextStyle(color: Colors.black,fontSize: 16.0)
            ),
          ),
        );
      } else if(projectSnap.connectionState == ConnectionState.waiting){
        return SliverToBoxAdapter(
          child: Container(
            height: 200.0,
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        );
      }
      ListView.builder(
      itemCount: projectSnap.data.length,
      itemBuilder: (BuildContext context, int position) {
        return 
        Dismissible(
          key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
          background: Container(
            color: Colors.red,
            child: Align(
              alignment: Alignment(0.9, 0.0),
              child: Icon(Icons.delete, color: Colors.white,),
            ),
          ),
          direction: DismissDirection.endToStart,
          child: 
            Center(
              child:Card(
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
                                Text(this.fazendas[position].nome),
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
                                        navegarFormularioFazenda(this.fazendas[position]);
                                      }
                                    )
                                  ], 
                                ),
                                Column(
                                  children: <Widget>[
                                    FlatButton.icon(
                                      color: Colors.white10,
                                      icon: Icon(Icons.layers),
                                      label: Text('Talhões'),
                                      onPressed: () {
                                        navegarPaginaTalhao(this.fazendas[position]);
                                      }
                                    )
                                  ], 
                                ),
                              ],
                            )
                          ],
                        )
                  )
                )
            ),
            confirmDismiss: (direction) {
              _confirmarExclusao(this.fazendas[position]);
            },
        ); 
      },
    );
  }
);
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
       Map enviroment = environment();
       String url     = enviroment['apiUrl'] + '/usuarios/'+ '' +'/fazendas';
    }
  // void getData() {
  //   final dbFuture = helper.initializeDb();
  //   dbFuture.then((result) {
  //     final fazendasFuture = helper.getFazendas();
  //     fazendasFuture.then((result) {
  //       List<Fazenda> fazendaList = List<Fazenda>();
  //       count = result.length;
  //       for (int i = 0; i < count; i++) {
  //         fazendaList.add(Fazenda.fromObject(result[i]));
  //       }
  //       setState(() {
  //         fazendas = fazendaList;
  //         count = count;
  //       });
  //     });
  //   });
  // }

  void deletarFazenda(Fazenda fazenda) async {

        // Navigator.pop(context, true);
        // debugPrint('idFazenda' + fazenda.id.toString());
        // if (fazenda.id == null) {
        //   return;
        // }
        // var result = await helper.deleteFazenda(fazenda.id);
        //  debugPrint('Resultado' + result.toString());
       
        // if (result != 0) {
        //   AlertDialog alertDialog = AlertDialog(
        //     title: Text("Fazenda deletada"),
        //     content: Text("A fazenda foi deletada"),
        //   );
        //   showDialog(context: context, builder: (_) => alertDialog);
        // }
        // getData();
  }

  void navegarFormularioFazenda(Fazenda fazenda) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FazendaForm(fazenda)),
    );
    if (result == true) {
      // getData();
    }
  }

  void navegarPaginaTalhao(Fazenda fazenda){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TalhaoPage(fazenda)),
    );
  }

}
