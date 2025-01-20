import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para cargar el archivo JSON

class RulesPage extends StatefulWidget {
  @override
  State<RulesPage> createState() => _RulesPage();
}

class _RulesPage extends State<RulesPage> {
  // Lista de reglas que se cargará dinámicamente desde el archivo JSON
  List<Map<String, String>> rules = [];
  bool isLoading = true;  // Indicador de carga

  // Función para cargar las reglas desde el archivo JSON
  Future<void> _loadRules() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/rules.json');
      print("Contenido del JSON: $jsonString");

      final Map<String, dynamic> jsonResponse = json.decode(jsonString);

      // Asegúrate de que los valores de 'title' y 'content' sean de tipo String
      setState(() {
        rules = List<Map<String, String>>.from(
          jsonResponse['rules'].map((rule) {
            return {
              "title": rule["title"] as String, // Asegúrate de que sea String
              "content": rule["content"] as String, // Asegúrate de que sea String
            };
          }).toList(),
        );
        isLoading = false; // Ya se cargaron las reglas
      });
    } catch (e) {
      setState(() {
        isLoading = false;  // Dejar de mostrar el indicador de carga
      });
      print("Error al cargar las reglas: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _loadRules(); // Cargar las reglas cuando se inicie la pantalla
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reglas",
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                color: Color.fromARGB(255, 241, 170, 155),
                thickness: 1.2,
              ),
              _buildNormasSection("Objetivo del Juego:", Text(
                "Completar 5 misiones cotidianas aleatorias en un plazo de 24 horas, aportando prueba de cada misión para su validación.",
                style: TextStyle(fontSize: 16, color: Colors.white70),
              )),
              SizedBox(height: 5),
              Divider(
                color: Color.fromARGB(255, 241, 170, 155),
                thickness: 1.2,
              ),
              SizedBox(height: 30),

              // Mostrar un indicador de carga mientras las reglas se cargan
              // Mostrar un indicador de carga mientras las reglas se cargan
              isLoading
                  ? Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 241, 170, 155),))
                  : (rules.isEmpty
                  ? Center(child: Text('No se encontraron reglas.',
                  style: TextStyle(
                      color: Color.fromARGB(255, 241, 170, 155)),))
                  : Column(
                children: rules.map((rule) {
                  return _buildNormasSection(
                    rule["title"]!,
                    _buildRichText(rule["content"]!),
                  );
                }).toList(),
              )),
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
          TextSpan(
            text: "$content\n\n",
            style: TextStyle(fontSize: 16, color: Colors.white70),
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
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFF1A99B),
              letterSpacing: 1.2,
            ),
          ),
          content,
        ],
      ),
    );
  }
}
