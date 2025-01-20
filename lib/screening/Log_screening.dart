import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 42, 39, 73), // Fondo oscuro
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 68, 64, 104), // Usar el mismo color de fondo
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: Offset(0, 4),
                blurRadius: 10,
              )
            ],
          ),
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_circle,
                  size: 100,
                  color: Color(0xFFF1A99B), // Color de icono
                ),
                SizedBox(height: 20),
                _buildTextField("Email", false),
                SizedBox(height: 20),
                _buildTextField("Password", true),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildAuthButton('Log in', () {
                      // Acción de login
                    }),
                    SizedBox(width: 20),
                    _buildAuthButton('Register', () {
                      // Acción de registro
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Función para crear un campo de texto estilizado
  Widget _buildTextField(String label, bool isPassword) {
    return TextFormField(
      style: TextStyle(
        fontSize: 18,
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

  // Función para crear botones estilizados
  Widget _buildAuthButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF1A99B)),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Color.fromARGB(255, 68, 64, 104),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
