import 'package:flutter/material.dart';
import 'package:agroquality/models/fazendaModel.dart';
import 'package:agroquality/screens/home.dart';


class FazendaForm extends StatefulWidget {
  final Fazenda fazenda;
  FazendaForm(this.fazenda);

  @override
  State<StatefulWidget> createState() => FazendaFormState(fazenda);
}

class FazendaFormState extends State {
  Fazenda fazenda;

  TextEditingController nomeController = TextEditingController();
  TextEditingController areaDaFazendaController = TextEditingController();

  FazendaFormState(Fazenda fazenda) {
    this.fazenda = fazenda;
  }

  @override
  Widget build(BuildContext context) {
      nomeController.text = fazenda.nome;
      areaDaFazendaController.text = fazenda.areaDaFazenda.toString();

      return Scaffold(
          appBar: AppBar(
            title: Text('Nova/Editar Fazenda'),
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
          body:  Padding(
            padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    TextField(
                      controller: nomeController,
                      onChanged: (value) => this.updateNome(),
                      decoration: InputDecoration(
                          labelText: "Nome da fazenda",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: TextField(
                          controller: areaDaFazendaController,
                          onChanged: (value) => this.updateAreaDaFazenda(),
                          decoration: InputDecoration(
                              labelText: "Area da fazenda",
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

  void updateNome() {
    fazenda.nome = nomeController.text;
  }

  void updateAreaDaFazenda() {
    fazenda.areaDaFazenda = double.parse(areaDaFazendaController.text);
  }
}