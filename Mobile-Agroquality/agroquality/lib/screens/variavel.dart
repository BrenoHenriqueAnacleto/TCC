import 'package:agroquality/models/etapaModel.dart';
import 'package:agroquality/models/talhaoModel.dart';
import 'package:agroquality/tableModels/authTableModel.dart';
import 'package:flutter/material.dart';
import 'package:agroquality/constants.dart';
import 'package:dio/dio.dart';

class VariavelPage extends StatefulWidget {
  final Talhao talhao;
  VariavelPage(this.talhao);

  @override
  State<StatefulWidget> createState() => VariavelPageState(talhao);
}

class VariavelPageState extends State {
  Talhao talhao;

  VariavelPageState(Talhao talhao) {
    this.talhao = talhao;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: etapasAplicativo(),
      builder: (context, dados) {
        if (dados.connectionState == ConnectionState.none ||
              dados.data == null) {
          return Container(
              height: 200.0,
              color: Colors.white,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            );
        } else if (dados.connectionState == ConnectionState.waiting) {
          return Container(
              height: 200.0,
              color: Colors.white,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            );
        } else {
          return DefaultTabController(
            length: dados.data.length,
            child: Scaffold(
              appBar: AppBar(
                title:Text('Etapas'),
                centerTitle: true,
                bottom: 
                TabBar(
                indicatorColor: Color(0xFFFFFBFA),
                tabs: dados.data
                )
              ),
              body: Container()
          ));
        }
      }
    );
  }
 
  etapasAplicativo() async{

    final AuthTableModel authTableModel = new AuthTableModel();
    final List<dynamic> auths = await authTableModel.getAuths();

    Map enviroment = environment();

    String token = auths[0]['id'];
    String url = enviroment['apiUrl'] +
        '/aplicativos/' +
        idAplicativo +
        '/etapas' +
        '?access_token=' +
        token;

    var dio = Dio();
    var response = await dio.get(url);

    List<dynamic> etapas = new List<dynamic>();
    Etapa etapa = new Etapa();
    response.data.forEach((element) => etapas.add(etapa.fromMap(element)));

    List<Tab> tabs = new List<Tab>();
    List<TabBarView> tabsViews = new List<TabBarView>();
  
    etapas.forEach((valor) => tabs.add(new Tab(text: valor.nome)));
    
    // etapas.forEach((valor) => tabsViews.add());

    return tabs;
  }
}