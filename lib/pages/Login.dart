import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ukk_2025/pages/Beranda.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'LOGIN',
            style: TextStyle(
              fontSize: 20,
            ),
          ),

          SizedBox(
            height: 20,
          ),

          TextField(
            decoration: InputDecoration(
              hintText: 'Username',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))
              )
            ),
          ),

          SizedBox(
            height: 20,
          ),

          TextField(
            decoration: InputDecoration(
              hintText: 'Password',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                ),
                borderRadius: BorderRadius.all(Radius.circular(30),)
                
              )
            ),
          ),

          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}