import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PuntuacionPage extends StatefulWidget {
  @override
  State<PuntuacionPage> createState() => _PuntuacionPage();
}

class _PuntuacionPage extends State<PuntuacionPage> {
  // Puntuación mensual en formato de porcentaje (0.0 a 1.0)
  final List<double> monthlyScores = [0.7, 0.8, 0.5, 0.9, 0.6, 0.4, 0.8];
  double dailyScore = 0.0; // Puntuación del día (será sumada a la lista de puntuaciones mensuales)

  @override
  Widget build(BuildContext context) {
    // Calculamos el total de la puntuación mensual
    double totalScore = monthlyScores.fold(0.0, (sum, score) => sum + score) + dailyScore;
    double averageScore = totalScore / (monthlyScores.length + 1); // Promedio total

    // Calculamos la puntuación de la semana (usamos solo los primeros 7 días para simplificar)
    double weeklyScore = monthlyScores.sublist(0, 7).fold(0.0, (sum, score) => sum + score) / 7;

    return Scaffold(
      appBar: AppBar(
        title: Text("Puntuación del Mes",
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF1A99B))),
        backgroundColor: Color.fromARGB(255, 42, 39, 73), // Color oscuro para la app bar
      ),
      backgroundColor: Color.fromARGB(255, 42, 39, 73), // Fondo claro para dar contraste
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 90),
              // Círculo que muestra la puntuación promedio
              CircularPercentIndicator(
                radius: 130.0, // Tamaño más grande del círculo
                lineWidth: 15.0, // Grosor de la línea
                percent: averageScore, // Valor de la puntuación promedio
                center: Text(
                  "${(averageScore * 100).toStringAsFixed(0)}%",
                  style: TextStyle(fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                progressColor: Color(0xFFF1A99B), // Color suave y cálido para la barra de progreso
                backgroundColor: Colors.grey[200]!, // Fondo gris claro
                circularStrokeCap: CircularStrokeCap.round, // Bordes redondeados
              ),
              SizedBox(height: 40),

              // Sección con las puntuaciones
              Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 68, 64, 104),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Puntuación Total del Mes",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF1A99B)),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "${(totalScore * 100).toStringAsFixed(0)}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Puntuación Total de la Semana",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF1A99B)),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "${(weeklyScore * 100).toStringAsFixed(0)}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // Función para actualizar la puntuación diaria desde la segunda vista
  void updateDailyScore(double score) {
    setState(() {
      dailyScore = score;
      monthlyScores.add(score); // Se añade la puntuación diaria a la lista mensual
    });
  }
}
