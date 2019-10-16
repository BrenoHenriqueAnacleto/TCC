import 'package:flutter/material.dart';
import 'package:agroquality/widgets/fazendaList.dart';

class FazendaPage extends StatefulWidget {

  FazendaPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FazendaPageState createState() => _FazendaPageState();
}
class _FazendaPageState extends State<FazendaPage> {

  retornarFazendas() async {
    
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 69, 124, 31),
            Color.fromARGB(255, 92, 165, 41)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        )
      ),
    );

    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Fazendas"),
                centerTitle: true,
              ),
            ),
             FutureBuilder<dynamic>(
              future: retornarFazendas(),
              builder: (context, snapshot){
                if(!snapshot.hasData)
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                else
                  return FazendaList();
              },
            )
          ]
        ),
      ],
    );
  }
}