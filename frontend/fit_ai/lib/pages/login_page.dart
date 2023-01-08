import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../utils/bottom_navbar.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  void signup(String email, String password) async {
    Map data = {'email': email, 'password': password};

    String body = json.encode(data);

    Response response = await post(
      Uri.parse('https://hacked2023.herokuapp.com/users/register/'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 201) {
      print('User created successfully.');
    } else {
      print(response.statusCode);
    }
    ;
  }

  void login(String email, String password) async {
    Map data = {'email': email, 'password': password};

    String body = json.encode(data);

    Response response = await post(
      Uri.parse('https://hacked2023.herokuapp.com/users/token/obtain/'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: ListView(children: [
          Column(children: [
            const SizedBox(height: 50),
            const Text(
              'Login',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter valid email id as'),
                )),
            const SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter your password'),
                )),
            const SizedBox(height: 20),
            MaterialButton(
                onPressed: () =>
                    signup(usernameController.text, passwordController.text),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                            child: Text('Sign Up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)))))),
            const SizedBox(height: 20),
            MaterialButton(
                onPressed: () =>
                    login(usernameController.text, passwordController.text),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                            child: Text('Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)))))),
          ])
        ])));
  }
}
