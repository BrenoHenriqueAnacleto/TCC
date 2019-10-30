import 'package:agroquality/models/authModel.dart';
import 'package:agroquality/models/etapaModel.dart';
import 'package:agroquality/models/talhaoModel.dart';
import 'package:agroquality/models/valorModel.dart';
import 'package:agroquality/models/variavelModel.dart';
import 'package:agroquality/tableModels/authTableModel.dart';
import 'package:flutter/material.dart';
import 'package:agroquality/constants.dart';

import 'dart:convert' as convert;
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class VariavelForm extends StatefulWidget {
  final Talhao talhao;
  final Etapa etapa;
  final Valor valor;
  VariavelForm(this.talhao,this.etapa,this.valor);

  @override
  State<StatefulWidget> createState() => VariavelFormState(talhao,etapa,valor);
}

class VariavelFormState extends State {
  Etapa etapa;
  Talhao talhao;
  String _titulo;
  String _botao;
  Valor valorEditar;

  List<String> valores = new List<String>();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  VariavelFormState(Talhao talhao,Etapa etapa, Valor valor) {

    this.etapa        = etapa;
    this.valorEditar  = valor;
    this.talhao       = talhao;
    
    if (this.valorEditar.id != null){
        _titulo = "Editar variável de" + etapa.nome.toLowerCase();
        _botao  = "Salvar alterações";
    } else {
        _titulo = "Nova variável de " + etapa.nome.toLowerCase();
        _botao  = "Adicionar variável";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('$_titulo'),
          centerTitle: true,
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
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              Form(
                  key: _formKey,
                  child: FutureBuilder(
                      future: formularioDinamico(),
                      builder: (context, dados) {
                        if (dados.connectionState == ConnectionState.none) {
                          return Container(
                            height: 200.0,
                            alignment: Alignment.center,
                            child: Text('Um erro ocorreu',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.0)),
                          );
                        } else if (dados.data == null) {
                          return Container(
                          ); 
                        } else {
                          return Column(
                          children: dados.data
                          );
                        }
                      }))
            ],
          ),
        ));
  }

  formularioDinamico() async {

    final AuthTableModel authTableModel = new AuthTableModel();
    final List<dynamic> auths = await authTableModel.getAuths();

    Map enviroment = environment();

    String token = auths[0]['id'];
    String url = enviroment['apiUrl'] +
        '/etapas/' +
        this.etapa.id +
        '/variaveis?access_token=' +
        token;

    var dio = Dio();
    var response = await dio.get(url);
    List<dynamic> variaveis = new List<dynamic>();
    List<Widget> campos = new List<Widget>();

    Variavel variavel = new Variavel();

    response.data.forEach((element) => variaveis.add(variavel.fromMap(element)));

    for (var x in variaveis) {
        String title       = x.title.toString() ;
        String placeholder = x.placeholder.toString();
        String labelText   = "$title ($placeholder)";

        String valorDoCampo = "";

        if(valorEditar.valores != null){
        
          for(var y in valorEditar.valores){
            if(y[x.id] != null){
              valorDoCampo = y[x.id];
            }
          }
        }

        List<dynamic> validacoes = new List<dynamic>();

        if(x.validacoes?.isEmpty != true) {
          
          String cultura = "${this.talhao.cultura[0].toUpperCase()}${this.talhao.cultura.substring(1)}";
          for(var validacao in x.validacoes){
            if(validacao['cultura']?.contains(cultura) == true){
              for (var intervalo in validacao['validacao']) {
                validacoes.add(intervalo);
              }
            }else{
              validacoes.add(validacao['validacao']);
            }
          }
        }

        Widget campo = Padding(
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: TextFormField(
            onSaved: (value){
              bool qualidade = true;
              String mensagem = "";
              if(validacoes?.isEmpty != true){

                for(var valido in validacoes){

                  if(valido != null){

                    if(valido['valorPadrao'] != null){

                      if(double.parse(valido['valorPadrao']) != double.parse(value)){
                        mensagem  = valido['mensagemInvalida'];
                        qualidade = false;
                      } else{
                        mensagem  = valido['mensagemValida'];
                        qualidade = true;
                      }
                    } else if(valido['valorMinimo'] != null && valido['valorMaximo'] != null) {

                      if(double.parse(value) >= double.parse(valido['valorMinimo'])  &&  double.parse(value) <= double.parse(valido['valorMaximo'])){
                        mensagem  = valido['mensagem'];
                        qualidade = valido['qualidade'];
                      }
                    }
                  }
                }
              }

              String id = x.id;
              String val = value.toString();
              var valor = '''{
                  "$id": "$val",
                  "qualidade":"$qualidade",
                  "mensagem" : "$mensagem"
                }
              ''';
              valores.add(valor);
            },
            initialValue: valorDoCampo,
            decoration: InputDecoration(
                labelText: "$labelText",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                )),
            validator: (value) {
             
              if (value.isEmpty) {
                return "Campo obrigatório";
              }
            },
          ));

        campos.add(campo);
    }
    if(campos.length > 0){
      campos.add( 
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                if (this.valorEditar.id != null) {
                  editar();
                } else {
                  adicionar();
                }
              }
            },
            child: Text('$_botao'),
          )));
      }
    return campos;
  } 

  void adicionar() async {

    final AuthTableModel authTableModel = new AuthTableModel();
    final List<dynamic> auths = await authTableModel.getAuths();

    Auth auth = new Auth();
    Auth usuario = auth.novo(auths[0]);
    Map enviroment = environment();

    String userId = usuario.userId;
    String token  = auths[0]['id'];
    String url    = enviroment['apiUrl'] +
        '/valoresVariaveisUsuarios?access_token=' +
        token;
    String etapaId = etapa.id;
    DateTime agora = DateTime.now();
    String periodo = DateFormat('dd/MM/yyyy').format(agora).toString();

    var jsonString = '''{
          "periodo": "$periodo",
          "valores":  $valores,
          "etapaId": "$etapaId",
          "usuarioId": "$userId",
          "excluido": "false"
        }
      ''';

    var dio = Dio();
    var dados = convert.jsonDecode(jsonString);
    var response = await dio.post(url, data: dados);

    if (response.statusCode == 200) {

      valores = new List<String>();
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

    Auth auth = new Auth();
    auth.novo(auths[0]);

    Map enviroment = environment();

    String userId = auth.userId;
    String token  = auths[0]['id'];
    String id     = this.valorEditar.id;
    String etapaId = this.valorEditar.etapaId;
    String periodo = this.valorEditar.periodo;

    String url    = enviroment['apiUrl'] +
        '/valoresVariaveisUsuarios?access_token=' +
        token;

    var jsonString = '''{
          "valores": $valores,
          "periodo": "$periodo",
          "valores": $valores,
          "etapaId": "$etapaId",
          "usuarioId":"$userId",
          "excluido": "false",
          "id": "$id"
        }
      ''';

    var dio = Dio();
    var dados = convert.jsonDecode(jsonString);
    var response = await dio.put(url, data: dados);

    if (response.statusCode == 200) {

      valores = new List<String>();
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
