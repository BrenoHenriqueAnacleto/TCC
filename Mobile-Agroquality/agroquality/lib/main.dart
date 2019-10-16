import 'package:flutter/material.dart';
import 'package:agroquality/app.dart';
import 'package:flutter/services.dart';

void main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
      runApp(AgroqualityApp());
    });
}