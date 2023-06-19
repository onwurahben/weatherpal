import 'package:flutter/material.dart';
import 'package:weatherpal/screens/loading_screen.dart';
import 'package:weatherpal/my_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: myTheme,
      //doesn't use namedRoutes because navigation is simple
      home: const LoadingScreen(),
    );
  }
}
