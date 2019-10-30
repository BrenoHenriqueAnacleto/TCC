import 'package:agroquality/constants.dart';
import 'package:agroquality/models/talhaoModel.dart';
import 'package:agroquality/models/valorModel.dart';
import 'package:agroquality/models/etapaModel.dart';
import 'package:agroquality/models/variavelModel.dart';
import 'package:agroquality/tableModels/authTableModel.dart';
import 'package:flutter/material.dart';
import 'package:agroquality/util/grafico.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dio/dio.dart';

class ResultadoPage extends StatefulWidget {
  final Etapa etapa;
  final Valor valor;
  final Talhao talhao;
  ResultadoPage(this.talhao, this.etapa, this.valor);
  @override
  _ResultadoPageState createState() =>
      _ResultadoPageState(talhao, etapa, valor);
}

class _ResultadoPageState extends State<ResultadoPage> {
  Etapa etapa;
  Valor valor;
  Talhao talhao;
  _ResultadoPageState(Talhao talhao, Etapa etapa, Valor valor) {
    this.etapa = etapa;
    this.valor = valor;
    this.talhao = talhao;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          primary: true,
          toolbarOpacity: 1.0,
          title: Text('Resultados'),
          centerTitle: true,
        ),
        body: new Column(children: <Widget>[
          resultadoPorEtapa(),
          FutureBuilder(
              future: validacoesResultados(),
              builder: (context, dados) {
                var connectionState = dados.connectionState;
                if (connectionState == ConnectionState.none) {
                  return Container();
                } else if (dados.connectionState == ConnectionState.waiting) {
                  return Container();
                } else if (dados.data == null) {
                  return Container();
                } else {
                  return Expanded(
                      child: ListView.builder(
                          itemCount: dados.data.length,
                          itemBuilder: (BuildContext context, int position) {
                            return Card(
                                child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          children: <Widget>[
                                            CircleAvatar(
                                              backgroundColor:
                                                  dados.data[position]
                                                              ["qualidade"] ==
                                                          "true"
                                                      ? Colors.green
                                                      : Colors.red,
                                              child: Icon(
                                                  dados.data[position]
                                                              ["qualidade"] ==
                                                          "true"
                                                      ? Icons.check
                                                      : Icons.error,
                                                  color: Colors.white),
                                            )
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(dados.data[position]
                                                        ["variavel"] !=
                                                    null
                                                ? dados.data[position]
                                                    ["variavel"]
                                                : "-")
                                          ],
                                        ))
                                  ],
                                ),
                                Row(children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        children: <Widget>[
                                          Text(dados.data[position]
                                                      ["mensagem"] !=
                                                  null
                                              ? dados.data[position]["mensagem"]
                                              : "-")
                                        ],
                                      ))
                                ]),
                              ],
                            ));
                          }));
                }
              })
        ]));
  }

  Widget resultadoPorEtapa() {
    int qualidade = 0;
    int semQualidade = 0;
    int totalVariaveis = 0;
    double totalQualidade;
    double totalSemQualidade;

    for (var item in valor.valores) {
      if (item['qualidade'] == 'true') {
        qualidade++;
      } else {
        semQualidade++;
      }
      totalVariaveis++;
    }

    if (totalVariaveis != 0) {
      totalQualidade = (qualidade * 100) / totalVariaveis;
      totalSemQualidade = (semQualidade * 100) / totalVariaveis;
    } else {
      totalQualidade = 0;
      totalSemQualidade = 0;
    }

    var data = [
      new VariaveisPorAtributoQualidade(
          'Variaveis fora do intervalo de qualidade',
          totalSemQualidade,
          Colors.yellow),
      new VariaveisPorAtributoQualidade(
          'Variaveis dentro do intervalo de qualidade',
          totalQualidade,
          Colors.green)
    ];

    var series = [
      new charts.Series(
          domainFn: (VariaveisPorAtributoQualidade clickData, _) =>
              clickData.qualidade,
          measureFn: (VariaveisPorAtributoQualidade clickData, _) =>
              clickData.porcentagem,
          colorFn: (VariaveisPorAtributoQualidade clickData, _) =>
              clickData.color,
          id: 'Procentagem',
          data: data),
    ];

    return Container(
        padding: EdgeInsets.only(top: 10.0),
        height: 300.0,
        child: DatumLegendWithMeasures(series));
  }

  validacoesResultados() async {
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

    Variavel variavel = new Variavel();

    response.data
        .forEach((element) => variaveis.add(variavel.fromMap(element)));

    List<dynamic> mensagens = new List<dynamic>();

    for (var variavel in variaveis) {
      for (var valor in this.valor.valores) {
        if (valor[variavel.id] != null) {
          valor['variavel'] = variavel.title;
          mensagens.add(valor);
        }
      }
    }
    return mensagens;
  }
}

class VariaveisPorAtributoQualidade {
  final String qualidade;
  final double porcentagem;
  final charts.Color color;

  VariaveisPorAtributoQualidade(this.qualidade, this.porcentagem, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
