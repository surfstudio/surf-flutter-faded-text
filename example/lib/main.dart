import 'package:faded_text/faded_text.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Faded Text Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Faded Text Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FadedText(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur siƒnt occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
            maxLines: 5,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
