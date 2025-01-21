import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PuntuacionPage extends StatefulWidget {
  final double dayPoints; // Puntuación diaria desde la clase Misiones
  final Duration remainingTime; // Temporizador sincronizado con Misiones
  final Function onDayEndCallback; // Callback cuando el día termina
  final Function onWeekEndCallback; // Callback cuando la semana termina
  final Function onMonthEndCallback; // Callback cuando el mes termina

  PuntuacionPage({
    required this.dayPoints,
    required this.remainingTime,
    required this.onDayEndCallback,
    required this.onWeekEndCallback,
    required this.onMonthEndCallback,
    required double monthPoints,
    required double weekPoints,
  });

  @override
  State<PuntuacionPage> createState() => _PuntuacionPageState();
}

class _PuntuacionPageState extends State<PuntuacionPage> {
  late Timer timer;
  late Duration remainingTime;

  double dayPoints = 0.0;
  double weekPoints = 0.0;
  double monthPoints = 0.0;

  @override
  void initState() {
    super.initState();
    remainingTime = widget.remainingTime;
    dayPoints = widget.dayPoints;
    _startCountdown();
  }

  void _startCountdown() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.inSeconds > 0) {
        setState(() {
          remainingTime -= Duration(seconds: 1);
        });
      } else {
        timer.cancel();
        _onDayEnd();
      }
    });
  }

  void _onDayEnd() {
    setState(() {
      weekPoints += dayPoints;
      monthPoints += dayPoints;
      dayPoints = 0; // Reinicia los puntos diarios
    });
    widget.onDayEndCallback(); // Llama al callback de la clase Misiones

    // Verifica si termina la semana
    if (_isEndOfWeek()) {
      widget.onWeekEndCallback(); // Callback para el final de la semana
      setState(() {
        weekPoints = 0; // Reinicia los puntos semanales
      });
    }

    // Verifica si termina el mes
    if (_isEndOfMonth()) {
      widget.onMonthEndCallback(); // Callback para el final del mes
      setState(() {
        monthPoints = 0; // Reinicia los puntos mensuales
      });
    }
  }

  bool _isEndOfWeek() {
    return DateTime.now().weekday == DateTime.sunday;
  }

  bool _isEndOfMonth() {
    final now = DateTime.now();
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    return now.day == lastDayOfMonth.day;
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Puntuación",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
            color: Color(0xFFF1A99B),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 42, 39, 73),
      ),
      backgroundColor: Color.fromARGB(255, 42, 39, 73),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Tiempo restante del día",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              _formatDuration(remainingTime),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF1A99B),
              ),
            ),
            SizedBox(height: 20),
            // Barra de progreso mensual
            Text(
              "Progreso del Mes",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            LinearPercentIndicator(
              lineHeight: 20.0,
              percent: monthPoints / 1000, // Ajusta el divisor si necesitas otra escala
              center: Text(
                "${monthPoints.toStringAsFixed(1)} puntos",
                style: TextStyle(color: Colors.white),
              ),
              linearStrokeCap: LinearStrokeCap.roundAll,
              backgroundColor: Colors.grey[800],
              progressColor: Color(0xFFF1A99B),
            ),
            SizedBox(height: 20),
            // Barra de progreso semanal
            Text(
              "Progreso de la Semana",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            LinearPercentIndicator(
              lineHeight: 20.0,
              percent: weekPoints / 500, // Ajusta el divisor si necesitas otra escala
              center: Text(
                "${weekPoints.toStringAsFixed(1)} puntos",
                style: TextStyle(color: Colors.white),
              ),
              linearStrokeCap: LinearStrokeCap.roundAll,
              backgroundColor: Colors.grey[800],
              progressColor: Color(0xFFF1A99B),
            ),
            SizedBox(height: 40),
            // Ranking
            Text(
              "Ranking",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF1A99B),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 4, // Ajusta este número según el ranking dinámico
                itemBuilder: (context, index) {
                  final isCurrentUser = index == 3; // Ajusta esto según tu lógica
                  return Card(
                    color: isCurrentUser
                        ? Color(0xFFF1A99B)
                        : Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 68, 64, 104),
                        child: Text(
                          "#${index + 1}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        "Jugador ${index + 1}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 68, 64, 104),
                        ),
                      ),
                      trailing: Text(
                        "${(1200 - (index * 100))} puntos",
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
