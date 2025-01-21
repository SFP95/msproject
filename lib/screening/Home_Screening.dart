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

  double _dayPoints = 0.0;  // Puntos del día
  double _weekPoints = 0.0; // Puntos de la semana
  double _monthPoints = 0.0; // Puntos del mes

  // Lista de páginas con sus respectivas clases, pasando los parámetros
  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    // Inicializamos las páginas con los datos necesarios
    _pages.addAll([
      RulesPage(),
      MisionsPage(),
      PuntuacionPage(
        dayPoints: _dayPoints,
        weekPoints: _weekPoints,
        monthPoints: _monthPoints,
        onDayEndCallback: _handleDayEnd,
        onWeekEndCallback: _handleWeekEnd,
        onMonthEndCallback: _handleMonthEnd,
        remainingTime: Duration(days: 1),
      ),
      LoginPage(),
    ]);
  }

  // Callback que reinicia los puntos del día
  void _handleDayEnd() {
    setState(() {
      _dayPoints = 0.0;
    });
  }

  // Callback que reinicia los puntos de la semana
  void _handleWeekEnd() {
    setState(() {
      _weekPoints = 0.0;
    });
  }

  // Callback que reinicia los puntos del mes
  void _handleMonthEnd() {
    setState(() {
      _monthPoints = 0.0;
    });
  }

  // Función que se llama cuando un item del BottomNavigationBar es seleccionado
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 42, 39, 73), // fondo del cuerpo
      body: Container(
        color: Color.fromARGB(255, 42, 39, 73),
        child: SafeArea(
          child: _pages[_selectedIndex], // Cargar la página seleccionada
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
