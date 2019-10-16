import 'package:agroquality/models/talhaoModel.dart';
import 'package:flutter/material.dart';
import 'package:agroquality/colors.dart';

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
  return MaterialApp(
      theme: _agroqualityTheme,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
             indicatorColor: Color(0xFFFFFBFA), 
              tabs: [
                Tab(
                  text:'Plantio',
                ),
                Tab(
                  text:'Pulverização',
                ),
                Tab(
                  text:'Colheita',
                ),
              ],
         ),
          leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            semanticLabel: 'voltar',
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
            title: Text('Variáveis'),
          ),
          body: TabBarView(
            children: [
            ],
          ),
        ),
      ),
    );
    }
}
final ThemeData _agroqualityTheme = _buildAgroqualityTheme();

ThemeData _buildAgroqualityTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: amareloJohnDeere,
    primaryColor: verdeJohnDeere,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: amareloJohnDeere,
      textTheme: ButtonTextTheme.normal,
    ),
    floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
      backgroundColor: verdeJohnDeere
    ),
    scaffoldBackgroundColor: agroqualityBackgroundWhite,
    cardColor: agroqualitySurfaceWhite,
    textSelectionColor: verdeJohnDeere,
    errorColor: vermelhoJohnDeere,
  );
}