import 'package:flutter/material.dart';
import 'package:msproject/screening/Log_screening.dart';
import 'package:msproject/screening/Register_screening.dart';
import 'Rules_Screening.dart';
import 'Ranking_screening.dart';
import 'DiaryMisions_screening.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  int _selectedIndex = 0;

  // Lista de páginas con sus respectivas clases
  final List<Widget> _pages = [
    RulesPage(),
    MisionsPage(),
    PuntuacionPage(),
    //ConfiguracionPage(),
    LoginPage(),
    //RegistroPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 42, 39, 73), // fonde detras del menu
      body: Container(
        color: Color.fromARGB(255, 42, 39, 73),
        //255, 68, 64, 104
        child: SafeArea(
          child: _pages[_selectedIndex],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(

            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books_sharp),
                label: 'Misiones',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: 'Puntuación',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Configuración',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Color(0xFFF1A99B), // Color destacado
            unselectedItemColor: Colors.white70,
            backgroundColor: Color.fromARGB(255, 68, 64, 104), // Fondo del BottomNavigationBar
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}

