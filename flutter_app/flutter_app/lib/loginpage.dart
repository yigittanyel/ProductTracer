import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/productListPage.dart';
import 'package:flutter_app/user_model.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _loginButtonPressed();
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  void _loginButtonPressed() async {
    const String apiUrl = 'https://localhost:44364/api/Login/auth/';

    final String username = _usernameController.text;
    final String password = _passwordController.text;
    Users user = Users(name: username, password: password);

    const Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await http.post(Uri.parse(apiUrl),
        body: user.toJson(), headers: header);

    if (response.statusCode == 200) {
      // Başarılı giriş durumunda 2 saniye boyunca loading göstermek için
      showDialog(
        context: context,
        barrierDismissible: false, // Kullanıcı dışarıya tıklayarak kapatamaz
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );

      // 2 saniye bekleyelim
      await Future.delayed(Duration(seconds: 2));

      // Loading göstergesini kapatalım ve diğer sayfaya yönlendirelim
      Navigator.pop(context); // Loading göstergesini kapat
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductListScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Username or password is incorrect.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
