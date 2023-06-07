import 'package:flutter/material.dart';
import 'package:weatherpal/screens/loading_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      //doesn't use namedRoutes because navigation is simple
      home: const LoadingScreen(),
    );
  }
}
