import 'package:flutter/material.dart';

class RegistroPage extends StatefulWidget {
  @override
  State<RegistroPage> createState() => _RegistroPage();
}

class _RegistroPage extends State<RegistroPage> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';

  // Función para crear un campo de texto estilizado
  Widget _buildTextField(String label, bool isPassword) {
    return TextFormField(
      style: TextStyle(
        fontSize: 20,
        color: Colors.white70,
      ),
      obscureText: isPassword,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Color(0xFFF1A99B),
          ),
        ),
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 18,
          color: Color(0xFFF1A99B),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.white70,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Color.fromARGB(255, 42, 39, 73), // Fondo claro para dar contraste
      body: SingleChildScrollView( // Permite el scroll
        child: Center(
          child: Padding(

            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 90),
                // Formulario de registro
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 35, vertical: 70),
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Registra tu Cuenta",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF1A99B)),
                        ),
                        SizedBox(height: 20),
                        // Campo de nombre de usuario
                        _buildTextField("Nombre de Usuario", false),
                        SizedBox(height: 20),
                        // Campo de correo electrónico
                        _buildTextField("Correo Electrónico", false),
                        SizedBox(height: 20),
                        // Campo de contraseña
                        _buildTextField("Contraseña", true),
                        SizedBox(height: 20),
                        // Botón de registro
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Registro Exitoso')));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFF1A99B),
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                          ),
                          child: Text("Registrarse",
                              style: TextStyle(fontSize: 18,
                                  color: Color.fromARGB(255, 42, 39, 73),
                                  fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
