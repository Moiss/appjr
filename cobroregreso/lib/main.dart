import 'package:cobroregreso/pages/page_home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Este widget es el principla de aqui arranca el sistema.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COBRO AL REGRESO',
      theme: ThemeData(
        //Color Primario de la aplicacion
        primarySwatch: Colors.blue,
        //Para que sea adaptativo
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PageHome(),
    );
  }
}
