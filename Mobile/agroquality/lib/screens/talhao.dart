import 'package:flutter/material.dart';
import 'home.dart';
import 'package:agroquality/widgets/talhaoList.dart';
import 'package:agroquality/models/fazendaModel.dart';

class TalhaoPage extends StatefulWidget {
  final Fazenda fazenda;
  TalhaoPage(this.fazenda);

  @override
  State<StatefulWidget> createState() => TalhaoPageState(fazenda);
}

class TalhaoPageState extends State {
  Fazenda fazenda;

  TextEditingController nomeController = TextEditingController();
  TextEditingController areaDaFazendaController = TextEditingController();

  TalhaoPageState(Fazenda fazenda) {
    this.fazenda = fazenda;
  }

  @override
  Widget build(BuildContext context) {
  fazenda = this.fazenda;
  return Scaffold(
      appBar: AppBar(
        title: Text('Talhões'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            semanticLabel: 'voltar',
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            );
          },
        ),
      ),
      body:TalhaoList(fazenda),
    );
  }
}