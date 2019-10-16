import 'package:agroquality/tiles/drawer_tile.dart';
import 'package:flutter/material.dart';
import 'package:agroquality/tableModels/authTableModel.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;
  final AuthTableModel authTableModel = new AuthTableModel();

  dadosUsuario() async{
    final List<dynamic> auths = await authTableModel.getAuths();
    return auths[0]['username'];
  }

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    dadosUsuario();
    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 215, 64),
                Colors.white
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          )
      ),
    );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text("Agroquality",
                        style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: Text('Username')
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              DrawerTile(Icons.home, "Início", pageController, 0),
              DrawerTile(Icons.local_florist, "Fazendas", pageController, 1),
              DrawerTile(Icons.info, "Sobre", pageController, 2)
            ],
          )
        ],
      ),
    );
  }
}
