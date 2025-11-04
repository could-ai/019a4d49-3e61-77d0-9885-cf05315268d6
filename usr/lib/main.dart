import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const RKPerfumesApp());
}

class RKPerfumesApp extends StatelessWidget {
  const RKPerfumesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RK Perfumes Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}