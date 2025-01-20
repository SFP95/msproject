import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MisionsPage extends StatefulWidget {
  @override
  State<MisionsPage> createState() => _MisionsPage();
}

class _MisionsPage extends State<MisionsPage> {
  List<Map<String, dynamic>> missions = []; // Lista de misiones
  List<Map<String, dynamic>> userMissions = []; // Misiones aleatorias asignadas
  int totalPoints = 0; // Contador de puntos del usuario
  late Timer _timer; // Temporizador para la cuenta atrás
  Duration _timeLeft = Duration.zero; // Tiempo restante
  String _todayKey = ""; // Identificador único para el día actual

  @override
  void initState() {
    super.initState();
    _generateTodayKey(); // Generar clave para el día
    _loadMissions();
    _startCountdown();
  }

  // Generar un identificador único para el día actual
  void _generateTodayKey() {
    final now = DateTime.now();
    _todayKey = "${now.year}-${now.month}-${now.day}";
  }

  // Cargar misiones desde el archivo JSON
  Future<void> _loadMissions() async {
    try {
      final String jsonString = await DefaultAssetBundle.of(context).loadString('assets/misiones.json');
      final Map<String, dynamic> jsonResponse = json.decode(jsonString);

      setState(() {
        missions = List<Map<String, dynamic>>.from(
          jsonResponse['misiones'].map((mission) {
            return {
              "nombre": mission["nombre"],
              "detalles": mission["detalles"],
              "puntos": mission["puntos"],
              "completed": false,
              "evidence": null,
            };
          }).toList(),
        );
      });

      // Si no hay misiones asignadas para hoy, asignarlas
      if (userMissions.isEmpty) {
        _assignRandomMissions();
      }
    } catch (e) {
      print("Error al cargar las misiones: $e");
    }
  }

  // Asignar 5 misiones aleatorias
  void _assignRandomMissions() {
    final random = Random();
    final selectedMissions = <Map<String, dynamic>>[];
    while (selectedMissions.length < 5) {
      final mission = missions[random.nextInt(missions.length)];
      if (!selectedMissions.contains(mission)) {
        selectedMissions.add(mission);
      }
    }
    setState(() {
      userMissions = selectedMissions;
    });
  }

  // Iniciar el temporizador de cuenta atrás
  void _startCountdown() {
    final now = DateTime.now();
    final nextMidnight = DateTime(now.year, now.month, now.day + 1);
    final durationUntilMidnight = nextMidnight.difference(now);

    setState(() {
      _timeLeft = durationUntilMidnight;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeLeft.inSeconds > 0) {
        setState(() {
          _timeLeft -= Duration(seconds: 1);
        });
      } else {
        // Reiniciar misiones al finalizar el día
        _timer.cancel();
        _generateTodayKey();
        _assignRandomMissions();
        _startCountdown();
      }
    });
  }

  // Función para formatear el tiempo restante
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Misiones Diarias",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
            color: Color.fromARGB(255, 241, 170, 155),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 42, 39, 73),
      ),
      backgroundColor: Color.fromARGB(255, 42, 39, 73),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cuenta Atrás: ${_formatDuration(_timeLeft)}",
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
                Text(
                  "Puntos Totales: $totalPoints",
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ],
            ),
            Divider(
              color: Color.fromARGB(255, 241, 170, 155),
              thickness: 1.2,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: userMissions.length,
                itemBuilder: (context, index) {
                  return _buildMissionCard(userMissions[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissionCard(Map<String, dynamic> mission) {
    return Card(
      color: Color(0xFFF1A99B),
      margin: EdgeInsets.only(top: 8, bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Bordes redondeados
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              mission["nombre"],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color.fromARGB(255, 68, 64, 104),
              ),
            ),
            subtitle: Text(
              mission["detalles"],
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 68, 64, 104),
              ),
            ),
          ),
          SizedBox(height: 2),
          Divider(
            indent: 10,endIndent: 230,
            color: Color.fromARGB(255, 68, 64, 104),
            thickness: 1.2,
          ),// Espacio entre el texto y la puntuación
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Puntuación:   ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 68, 64, 104),
                  ),
                ),
                Text(
                  "${mission['puntos']}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 68, 64, 104),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}