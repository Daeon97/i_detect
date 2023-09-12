import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
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
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(
    widgetsBinding: widgetsBinding,
  );
  await dotenv.load();
  initDependencyInjection();
}
