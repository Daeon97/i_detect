// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:i_detect/views/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        onGenerateRoute: _routes,
      );

  Route<String> _routes(RouteSettings settings) => MaterialPageRoute(
        builder: (_) {
          switch (settings.name) {
            case '/':
            default:
              return const HomeScreen();
          }
        },
      );
}
