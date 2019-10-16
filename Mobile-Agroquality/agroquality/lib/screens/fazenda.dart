import 'package:flutter/material.dart';
import 'package:agroquality/widgets/fazendaList.dart';

class FazendaPage extends StatefulWidget {

  FazendaPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FazendaPageState createState() => _FazendaPageState();
}
class _FazendaPageState extends State<FazendaPage> {

  @override
  Widget build(BuildContext context) {
    return FazendaList(); 
  }
}
