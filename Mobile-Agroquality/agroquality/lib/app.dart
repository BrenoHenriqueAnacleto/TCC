import 'package:agroquality/screens/splash.dart';
import 'package:flutter/material.dart';

import 'package:agroquality/screens/home.dart';
import 'colors.dart';

class AgroqualityApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agroquality',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      onGenerateRoute: _getRoute,
      theme: _agroqualityTheme,
      routes: {
      },
    );
  }  

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/splash') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => SplashPage(),
      fullscreenDialog: true,
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