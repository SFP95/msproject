import 'package:flutter/material.dart';
import 'package:msproject/screening/Home_Screening.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await UserPreferences.initPreferences(); // Inicializar las preferencias del usuario
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Misiones Secundarias',
      initialRoute: '/',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 68, 64, 104),
        hintColor: Color.fromARGB(255, 237, 193, 142),
      ),
      routes: {
        '/':(context)=> Home(),
      },
    );
  }
}
