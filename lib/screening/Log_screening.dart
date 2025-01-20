import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
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

  // Función para mostrar el popup de registro con la vista embebida
  void _showRegisterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 68, 64, 104), // Fondo del popup
          title: Text(
            "Registro de Usuario",
            style: TextStyle(fontWeight: FontWeight.bold,
              color: Color(0xFFF1A99B), // Color del título
            ),
          ),
          content: Container(
            width: 300, // Ajusta el ancho según sea necesario
            height: 263, // Ajusta la altura según sea necesario
            child: RegistroPage(), // La vista de registro embebida
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el popup
              },
              child: Text(
                "Cerrar",
                style: TextStyle(fontSize: 20,
                  color: Color(0xFFF1A99B), // Color del texto del botón
                ),
              ),
            ),
          ],
        );
      },
    );
  }




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
                SizedBox(height: 20),
                Text(
                  "En caso de no tener cuenta, pulse 'Register'",
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildAuthButton('Log in', () {
                      // Acción de login
                    }),
                    SizedBox(width: 20),
                    _buildAuthButton('Register', () {
                      // Mostrar el popup de registro
                      _showRegisterDialog(context);
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
}

// Página de Registro que se muestra en el popup
class RegistroPage extends StatefulWidget {
  @override
  State<RegistroPage> createState() => _RegistroPage();
}

class _RegistroPage extends State<RegistroPage> {
  final _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTextField("Nombre de Usuario", false),
          SizedBox(height: 20),
          _buildTextField("Correo Electrónico", false),
          SizedBox(height: 20),
          _buildTextField("Contraseña", true),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(backgroundColor: Color.fromARGB(255, 42, 39, 73),
                        duration: Duration(milliseconds: 90),
                        content: Text('Registro Exitoso',
                          style: TextStyle(
                            color: Color(0xFFF1A99B),
                            fontWeight: FontWeight.bold,),)));
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFF1A99B),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
            ),
            child: Text("Mandar",
                style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 68, 64, 104), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
