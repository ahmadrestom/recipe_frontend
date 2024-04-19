import 'dart:ui';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _password = TextEditingController();
  String? _errorText;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 94, left: 30),
            child: Container(
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 30
                    ),
                  ),
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 20
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Email',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(18, 18, 18, 1),
                    fontSize: 14
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Enter email",
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(200, 200, 200, 1),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                      fontSize: 14,

                  ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color.fromRGBO(200, 200, 200, 1)),
                    )
                    ),

                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Password',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(18, 18, 18, 1),
                      fontSize: 14
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _password,
                  decoration: InputDecoration(
                      hintText: "Enter password",
                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(200, 200, 200, 1),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                        fontSize: 11,

                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Color.fromRGBO(200, 200, 200, 1)),
                      )
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35,30,0,0),
            child: Container(
              child: const Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Color.fromRGBO(255, 156, 0, 1),
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 38.0),
            child: Center(
              child: Container(
                width: 315,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    //////////////////////////////////
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(18, 149, 117, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sign In',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xFFFFFFFF)
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Image.asset(
                        'assets/icons/arrow-right.png',
                        width: 20,
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          const Row(
            children: [
              Divider()
            ],
          ),
        ],
      ),
    );
  }
}
