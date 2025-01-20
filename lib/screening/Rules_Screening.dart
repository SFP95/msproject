import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RulesPage extends StatefulWidget {
  @override
  State<RulesPage> createState() => _RulesPage();
}

class _RulesPage extends State<RulesPage> {
  // Lista de reglas con título y contenido
  final List<Map<String, String>> rules = [
    {
      "title": "Asignación de Misiones:",
      "content": "* Cada jugador recibirá 5 misiones cotidianas seleccionadas al azar.\n* Las misiones serán enviadas al jugador al inicio del periodo de 24 horas."
    },
    {
      "title": "Periodo de Juego:",
      "content": "* Los jugadores tienen un máximo de 24 horas (0:00) para completar las 5 misiones asignadas.\n* El periodo de juego comienza en el momento en que se entregan las misiones (1:00)."
    },
    {
      "title": "Pruebas de Misión:",
      "content": "* Para validar cada misión completada, el jugador debe proporcionar una prueba en forma de foto o video.\n* Las pruebas deben ser claras y mostrar la misión completada de manera evidente."
    },
    {
      "title": "Validación de Misiones:",
      "content": "* Las pruebas de misión deben enviarse a un árbitro o grupo de validación designado.\n* El árbitro o grupo de validación revisará las pruebas y confirmará si la misión ha sido completada correctamente."
    },
    {
      "title": "Sistema de Puntuación:",
      "content": "* Cada misión tiene un valor de puntos asignado (de 1 a 5, dependiendo de su dificultad y tiempo requerido).\n* Los puntos se otorgan solo si la misión es validada correctamente."
    },
    {
      "title": "Ganador:",
      "content": "* El jugador que acumule más puntos después de completar las 5 misiones será declarado ganador al final del mes.\n* En caso de empate en puntos, se considerará el tiempo total tomado para completar las misiones; el jugador que haya completado las misiones más rápido ganará."
    },
    {
      "title": "Conducta:",
      "content": "* Los jugadores deben completar las misiones de manera honesta y no deben manipular o falsificar las pruebas.\n* El respeto y la deportividad deben mantenerse en todo momento."
    },
    {
      "title": "Penalizaciones:",
      "content": "* Las misiones no completadas o con pruebas insuficientes no recibirán puntos.\n* Cualquier intento de trampa o comportamiento antideportivo resultará en la descalificación del jugador.\n* No se permite SPAM de ningún tipo en los canales de Text, si esto ocurre se le sancionará y eliminará del grupo.\n* Las pruebas no pueden contener violencia de ningún tipo, tanto a personas como animales, y tampoco a uno mismo.\n* Las pruebas no deben tener contenido sexual, en caso de saltarte esta como la anterior pauta, se sancionará al usuario y se eliminará del juego, perdiendo también todos sus puntos."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reglas", style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32, //Color.fromARGB(255, 241, 170, 155)
            color: Color.fromARGB(255, 241, 170, 155))),
        backgroundColor: Color.fromARGB(255, 42, 39, 73),
      ),
      backgroundColor: Color.fromARGB(255, 42, 39, 73),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(color: Color.fromARGB(255, 241, 170, 155),
                  thickness: 1.2), // Línea de separación
              _buildNormasSection("Objetivo del Juego:", Text(
                "Completar 5 misiones cotidianas aleatorias en un plazo de 24 horas, aportando prueba de cada misión para su validación.",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70),
              )),
              SizedBox(height: 5),
              Divider(color: Color.fromARGB(255, 241, 170, 155),
                  thickness: 1.2), // Línea de separación
              SizedBox(height: 7),
              ...rules.map((rule) {
                return _buildNormasSection(
                  rule["title"]!, // Pasa el título correctamente
                  _buildRichText(rule["content"]!), // Solo pasa el contenido
                );
              }).toList(),

            ],
          ),
        ),
      ),
    );
  }

  // Función para construir el RichText con solo el contenido
  Widget _buildRichText(String content) {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        children: [
          // Solo el contenido con el estilo necesario
          TextSpan(
            text: "$content\n\n", style: TextStyle(
              fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  // Función para construir la sección de normas
  Widget _buildNormasSection(String title, Widget content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Si el título no está vacío, se lo mostramos con un estilo destacado
          Text(
            title,
            style: TextStyle(
              fontSize: 24, // Título más grande
              fontWeight: FontWeight.bold, // Hacer el texto más grueso
              color: Color(0xFFF1A99B), // Un color más visible
              letterSpacing: 1.2, // Un pequeño espacio entre letras
            ),
          ),
          content,
        ],
      ),
    );
  }
}
