import 'package:agroquality/forms/talhaoForm.dart';
import 'package:agroquality/models/fazendaModel.dart';
import 'package:flutter/material.dart';
import 'package:agroquality/models/talhaoModel.dart';
import 'package:agroquality/screens/variavel.dart';


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
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: talhaoListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navegarFormularioTalhao(Talhao('','',0,0),this.fazenda);
        },
        tooltip: "Adicionar novo talhão",
        child: new Icon(Icons.add),
        backgroundColor: Color(0xFFFFCC00),
      ),
    );
  }

  ListView talhaoListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Center(
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
                            Text(this.talhaos[position].identificadorDoTalhao),
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
                                    navegarFormularioTalhao(this.talhaos[position],this.fazenda);
                                  }
                                )
                              ], 
                            ),
                            Column(
                              children: <Widget>[
                                FlatButton.icon(
                                  color: Colors.white10,
                                  icon: Icon(Icons.delete),
                                  label: Text('Apagar'),
                                  onPressed: () {
                                    _confirmarExclusao(this.talhaos[position]);
                                  }
                                )
                              ], 
                            ),
                            Column(
                              children: <Widget>[
                                FlatButton.icon(
                                  color: Colors.white10,
                                  icon: Icon(Icons.layers),
                                  label: Text('Variaveis'),
                                  onPressed: () {
                                    navegarPaginaVariavel(this.talhaos[position]);
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
        ); 
      },
    );
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

  // void getData() {
  //   final dbFuture = helper.initializeDb();
  //   dbFuture.then((result) {
  //     final talhaosFuture = helper.getTalhaosDaFazenda(this.fazenda.id);
  //     talhaosFuture.then((result) {
  //       List<Talhao> talhaoList = List<Talhao>();
  //       count = result.length;
  //       for (int i = 0; i < count; i++) {
  //         talhaoList.add(Talhao.fromObject(result[i]));
  //       }
  //       setState(() {
  //         talhaos = talhaoList;
  //         count = count;
  //       });
  //     });
  //   });
  // }

  void deletarTalhao(Talhao talhao) async {

        Navigator.pop(context, true);
        debugPrint('idTalhao' + talhao.id.toString());
        if (talhao.id == null) {
          return;
        }
        // var result = await helper.deleteTalhao(talhao.id);
        //  debugPrint('Resultado' + result.toString());
       
        // if (result != 0) {
        //   AlertDialog alertDialog = AlertDialog(
        //     title: Text("Talhao deletado"),
        //     content: Text("O talhao foi deletado"),
        //   );
        //   showDialog(context: context, builder: (_) => alertDialog);
        // }
        // getData();
  }

  void navegarFormularioTalhao(Talhao talhao,Fazenda fazenda) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TalhaoForm(talhao,fazenda)),
    );
    if (result == true) {
      // getData();
    }
  }

  void navegarPaginaVariavel(Talhao talhao){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VariavelPage(talhao)),
    );
  }

}
