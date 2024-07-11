import 'package:flutter/material.dart';
import 'package:pegawai/widget/button.login.dart';
import 'package:pegawai/widget/buttton.register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu Home',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              './lib/assets/icon.png',
              height: 200,
              width: 150,
            ),
            Text(
              'PKesehatan',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.all(20.0),
            ),
            ButtonLogin(),
            SizedBox(height: 10),
            ButtonRegister(),
          ],
        ),
      ),
    );
  }
}
