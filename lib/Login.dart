import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ukk_2025/Beranda.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _usernamecontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> _login() async {
    final username = _usernamecontroller.text;
    final password = _passwordcontroller.text;

    try {
      final response = await supabase
      .from('user')
      .select('username, password')
      .eq('username', username)
      .maybeSingle();

      if (response == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Username Tidak Ditemukan')),
        );
        return;
      }

      if (response['password'] == password) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Berhasil')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Beranda()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password Salah')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi Kesalahan: ${e.toString()}')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Container(
        padding: EdgeInsets.only(top: 11),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(205, 2, 89, 129),
                Color.fromARGB(255, 12, 135, 192),
                Color.fromARGB(255, 3, 186, 247)
              ],
            ),
          ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Dolot\nGuitar Shop',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                ),
              )
            ),
            Expanded(
              child: Container(
              padding: EdgeInsets.only(top: 55, left: 20, right: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _usernamecontroller,
                    decoration: InputDecoration(
                        hintText: 'Username',
                        hintStyle: TextStyle(
                          color: Colors.black87
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _passwordcontroller,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ))),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.only(top: 15, bottom: 15)),
                    onPressed: () => _login(),
                    child: Center(
                      child: Text(
                        'Masuk',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
