import 'package:agroquality/screens/dashboard.dart';
import 'package:agroquality/screens/fazenda.dart';
import 'package:agroquality/widgets/customDrawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
 
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: DashboardPage(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Fazendas"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: FazendaPage(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Sobre"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: FazendaPage(),
        ),
      ]
    );
  }
}