import 'package:assignment_module_12/src/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Assignment Module 12',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle:
              TextStyle(color: Colors.white, letterSpacing: 1, fontSize: 24),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
