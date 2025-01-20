import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 42, 39, 73), // fonde detras del menu
    body: Center(
      child: Container(
        margin: EdgeInsets.fromLTRB(35, 5, 35, 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Icon(
                  Icons.account_circle,
                  size: 100,
                  color:Color(0xFFF1A99B)
              ),
              SizedBox(height: 20),
              TextFormField(
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                ),
                //controller: _emailController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.white70,
                        )
                    ),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Color(0xFFF1A99B),
                    )
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                ),
                //controller: _passwordController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.white70,
                        )
                    ),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Color(0xFFF1A99B),
                    )),
                obscureText: true,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: Checkbox.width,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF1A99B)),
                      ),
                      onPressed: (){
                      },
                      child: Text('Log in',
                          style: TextStyle(
                              color: Color.fromARGB(255, 68, 64, 104),
                              fontSize: 20)),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF1A99B)),
                    ),
                    onPressed: (){

                    },
                    child: Text('Register',
                        style: TextStyle(
                            color: Color.fromARGB(255, 68, 64, 104),
                            fontSize: 20)),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    )
    );
  }
}