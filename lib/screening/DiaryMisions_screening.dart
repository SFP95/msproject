import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MisionsPage extends StatefulWidget {
  @override
  State<MisionsPage> createState() => _MisionsPage();
}

class _MisionsPage extends State<MisionsPage> {
  List<Map<String, dynamic>> missions = []; // Lista de todas las misiones
  List<Map<String, dynamic>> userMissions = []; // Misiones asignadas para hoy
  int dayPoints = 0; // Puntos acumulados en el día
  late Timer _timer; // Temporizador para la cuenta atrás
  Duration _timeLeft = Duration.zero; // Tiempo restante para la medianoche

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _loadMissions();
    _startCountdown();
    await _loadDailyState();
  }

  Future<void> _loadMissions() async {
    try {
      final String jsonString =
      await DefaultAssetBundle.of(context).loadString('assets/misiones.json');
      final Map<String, dynamic> jsonResponse = json.decode(jsonString);

      missions = List<Map<String, dynamic>>.from(
        jsonResponse['misiones'].map((mission) {
          return {
            "nombre": mission["nombre"],
            "detalles": mission["detalles"],
            "puntos": mission["puntos"],
            "completed": false,
          };
        }),
      );
    } catch (e) {
      print("Error al cargar las misiones: $e");
    }
  }

  Future<void> _loadDailyState() async {
    final prefs = await SharedPreferences.getInstance();
    final todayKey = _generateTodayKey();

    dayPoints = prefs.getInt('${todayKey}_points') ?? 0;
    final missionsString = prefs.getString('${todayKey}_missions');
    if (missionsString != null) {
      userMissions = List<Map<String, dynamic>>.from(json.decode(missionsString));
    } else {
      _assignRandomMissions();
      await _saveDailyState();
    }

    setState(() {});
  }

  Future<void> _saveDailyState() async {
    final prefs = await SharedPreferences.getInstance();
    final todayKey = _generateTodayKey();

    await prefs.setInt('${todayKey}_points', dayPoints);
    await prefs.setString('${todayKey}_missions', json.encode(userMissions));
  }

  String _generateTodayKey() {
    final now = DateTime.now();
    return "${now.year}-${now.month}-${now.day}";
  }

  void _assignRandomMissions() {
    final random = Random();
    final selectedMissions = <Map<String, dynamic>>[];
    while (selectedMissions.length < 5) {
      final mission = missions[random.nextInt(missions.length)];
      if (!selectedMissions.contains(mission)) {
        selectedMissions.add(mission);
      }
    }
    userMissions = selectedMissions;
  }

  void _startCountdown() {
    final now = DateTime.now();
    final nextMidnight = DateTime(now.year, now.month, now.day + 1);
    setState(() {
      _timeLeft = nextMidnight.difference(now);
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeLeft.inSeconds > 0) {
        setState(() {
          _timeLeft -= Duration(seconds: 1);
        });
      } else {
        _resetDailyMissions();
      }
    });
  }

  Future<void> _resetDailyMissions() async {
    _timer.cancel();
    _assignRandomMissions();
    dayPoints = 0;
    await _saveDailyState();
    _startCountdown();
    setState(() {});
  }

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
                  "Puntos diarios: $dayPoints",
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
        borderRadius: BorderRadius.circular(15),
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
          Divider(
            indent: 10,
            endIndent: 230,
            color: Color.fromARGB(255, 68, 64, 104),
            thickness: 1.2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Puntuación: ${mission['puntos']}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 68, 64, 104),
                  ),
                ),
                ElevatedButton(
                  onPressed: mission['completed']
                      ? null
                      : () async {
                    setState(() {
                      mission['completed'] = true;
                      dayPoints += (mission['puntos'] ?? 0) as int;
                    });
                    await _saveDailyState();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mission['completed']
                        ? Colors.grey
                        : Color.fromARGB(255, 68, 64, 104),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    mission['completed'] ? "Completada" : "Completar",
                    style: TextStyle(color: Colors.white),
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
