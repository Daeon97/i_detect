import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:i_detect/app.dart';
import 'package:i_detect/injection_container.dart';

void main() {
  _initializeImportantResources().then(
    (_) => runApp(
      const App(),
    ),
  );
}

Future<void> _initializeImportantResources() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  initDependencyInjection();
}
