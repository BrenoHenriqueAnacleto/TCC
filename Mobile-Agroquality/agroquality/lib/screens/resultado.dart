import 'package:flutter/material.dart';
import 'home.dart';

class ResultadoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: Text('Resultado'),
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
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 120.0),

              ]
            )
          )
      );
    }
}