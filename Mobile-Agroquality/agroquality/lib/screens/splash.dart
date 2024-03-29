import 'package:agroquality/screens/home.dart';
import 'package:agroquality/screens/login.dart';
import 'package:agroquality/tableModels/authTableModel.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  Widget build(BuildContext context) {
    return _introScreen();
  }
}

Widget _introScreen() {
  return Stack(
    children: <Widget>[
      SplashScreen(
        seconds: 5,
        gradientBackground: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white,
            Colors.white
          ],
        ),
        navigateAfterSeconds: LoginPage(),
        loaderColor: Colors.black,
      ),
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/logo-agroquality-oficial.png"),
            fit: BoxFit.none,
          ),
        ),
      ),
    ],
  );
}

 usuarioAutenticado() async {

    final AuthTableModel authTableModel = new AuthTableModel();
    final List<dynamic> auths = await authTableModel.getAuths();

    if(auths[0] != null){
      return HomePage();
    } else {
      return LoginPage();
    }
  }