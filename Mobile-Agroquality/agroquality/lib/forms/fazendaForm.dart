import 'package:agroquality/models/fazendaModel.dart';
import 'package:agroquality/tableModels/authTableModel.dart';
import 'package:flutter/material.dart';
import 'package:agroquality/constants.dart';

import 'dart:convert' as convert;
import 'package:dio/dio.dart';

class FazendaForm extends StatefulWidget {
  final Fazenda fazenda;
  FazendaForm(this.fazenda);

  @override
  State<StatefulWidget> createState() => FazendaFormState(fazenda);
}

class FazendaFormState extends State {
  Fazenda fazenda;
  String _titulo;
  String _botao; 

  TextEditingController nomeController = TextEditingController();
  TextEditingController areaDaFazendaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FazendaFormState(Fazenda fazenda) {
    
    this.fazenda = fazenda; 

    if (this.fazenda.id != null){
        _titulo = "Editar Fazenda";
        _botao  = "Salvar alterações";
        nomeController.text = this.fazenda.nome;
        areaDaFazendaController.text = this.fazenda.areaDaFazenda.toString();
    } else {
        _titulo = "Nova Fazenda";
        _botao  = "Adicionar fazenda";
        nomeController.text = "";
        areaDaFazendaController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {

      return Scaffold(
          appBar: AppBar(
            title: Text('$_titulo'),
            leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              semanticLabel: 'voltar',
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ),
          body:  Padding(
            padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: nomeController,
                      decoration: InputDecoration(
                        labelText: "Nome da fazenda",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )
                      ),
                      validator: (value) {
                        if(value.isEmpty){
                          return "Campo obrigatório";
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: areaDaFazendaController,
                        decoration: InputDecoration(
                            labelText: "Area da fazenda (ha)",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            )
                          ),
                        validator: (value) {
                          if(value.isEmpty){
                            return "Campo obrigatório";
                          }
                        },
                      )
                      ),
                      Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        onPressed: () {
                          if(_formKey.currentState.validate()){
                            if(this.fazenda.id != null){
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
                )
              )
            ],
          )
        )
      );
  }

  void adicionar() async{
      final AuthTableModel authTableModel = new AuthTableModel();
      final List<dynamic> auths = await authTableModel.getAuths();

      Map enviroment = environment();

      String userId  = auths[0]['userId'];
      String token   = auths[0]['id'];
      String url     = enviroment['apiUrl'] + '/usuarios/'+ userId +'/fazendas?access_token=' + token;

      String nome          = nomeController.text;
      double areaDaFazenda = double.parse(areaDaFazendaController.text);

      var jsonString = '''{
          "nome":"$nome",
          "areaDaFazenda":"$areaDaFazenda",
          "usuarioId":"$userId"
        }
      ''';

      var dio      = Dio();
      var dados    = convert.jsonDecode(jsonString);
      var response = await dio.post(url,data: dados);

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

      String userId    = auths[0]['userId'];
      String token     = auths[0]['id'];
      String idFazenda = this.fazenda.id;
      String url       = enviroment['apiUrl'] + '/usuarios/'+ userId +'/fazendas/'+ idFazenda +'?access_token=' + token;

      String nome          = nomeController.text;
      double areaDaFazenda = double.parse(areaDaFazendaController.text);

      var jsonString = '''{
          "nome":"$nome",
          "areaDaFazenda":"$areaDaFazenda",
          "usuarioId":"$userId",
          "id":"$idFazenda"
        }
      ''';

      var dio      = Dio();
      var dados    = convert.jsonDecode(jsonString);
      var response = await dio.put(url,data: dados);

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
