import 'package:flutter/material.dart';
import 'ui/home_page.dart';
import 'theme/space_theme.dart';

void main() {
  runApp(const IrisSpringApp());
}

class IrisSpringApp extends StatelessWidget {
  const IrisSpringApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IrisSpring Wi-Fi Scanner',
      theme: spaceTheme,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

