import 'package:agroquality/screens/talhao.dart';
import 'package:flutter/material.dart';
import 'package:agroquality/models/talhaoModel.dart';
import 'package:agroquality/models/fazendaModel.dart';

class TalhaoForm extends StatefulWidget {
  final Fazenda fazenda;
  final Talhao talhao;
  TalhaoForm(this.talhao, this.fazenda);

  @override
  State<StatefulWidget> createState() => TalhaoFormState(talhao, fazenda);
}

class TalhaoFormState extends State {
  Talhao talhao;
  Fazenda fazenda;

  TextEditingController identificadorTalhaoController = TextEditingController();
  TextEditingController culturaController = TextEditingController();
  TextEditingController tamanhoDoTalhaoController = TextEditingController();
  TextEditingController fazendaIdController = TextEditingController();

  TalhaoFormState(Talhao talhao, Fazenda fazenda) {
    this.talhao = talhao;
    this.fazenda = fazenda;
    this.talhao.fazendaId = this.fazenda.id;
  }

  @override
  Widget build(BuildContext context) {
    identificadorTalhaoController.text = talhao.identificadorDoTalhao;
    culturaController.text = talhao.cultura.toString();
    tamanhoDoTalhaoController.text = talhao.tamanhoDoTalhao.toString();
    fazendaIdController.text = talhao.fazendaId.toString();

    return Scaffold(
        appBar: AppBar(
          title: Text('Editar Talhão'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              semanticLabel: 'voltar',
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        TalhaoPage(this.fazenda)),
              );
            },
          ),
        ),
        body: Padding(
            padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 15.0),
                        child: TextField(
                          controller: identificadorTalhaoController,
                          onChanged: (value) =>
                              this.updateIdentificadorDoTalhao(),
                          decoration: InputDecoration(
                              labelText: "Identificador do talhão",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 0, bottom: 15.0),
                        child: TextField(
                          controller: tamanhoDoTalhaoController,
                          onChanged: (value) => this.updateTamanhoDoTalhao(),
                          decoration: InputDecoration(
                              labelText: "Tamanho do talhão",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 0, bottom: 15.0),
                        child: TextField(
                          controller: culturaController,
                          onChanged: (value) => this.updateCultura(),
                          decoration: InputDecoration(
                              labelText: "Cultura",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        onPressed: () {
                          this.save();
                        },
                        child: Text('Salvar'),
                      ),
                    ),
                  ],
                )
              ],
            )));
  }

  void save() {
    Navigator.pop(context, true);
  }

  void updateIdentificadorDoTalhao() {
    talhao.identificadorDoTalhao = identificadorTalhaoController.text;
  }

  void updateTamanhoDoTalhao() {
    talhao.tamanhoDoTalhao = double.parse(tamanhoDoTalhaoController.text);
  }

  void updateCultura() {
    talhao.cultura = culturaController.text;
  }

  void updateFazendaId() {
    talhao.fazendaId = fazendaIdController.text;
  }
}
