import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:i_detect/amplifyconfiguration.dart';
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
  registerServices();
  await _configureAmplify();
}

Future<void> _configureAmplify() async {
  if (!Amplify.isConfigured) {
    await Amplify.addPlugin(
      AmplifyAPI(),
    );
  }

  try {
    await Amplify.configure(amplifyconfig);
  } on AmplifyAlreadyConfiguredException catch (e) {
    safePrint(e.message);
  }
}
