// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:i_detect/cubits/efotainer_cubit/efotainer_cubit.dart';
import 'package:i_detect/cubits/theme_cubit/theme_cubit.dart';
import 'package:i_detect/injection_container.dart';
import 'package:i_detect/resources/numbers.dart';
import 'package:i_detect/resources/strings.dart';
import 'package:i_detect/views/screens/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: _providers,
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (_, themeState) => MaterialApp(
            onGenerateRoute: _routes,
            theme: themeState.themeData,
          ),
        ),
      );

  List<BlocProvider> get _providers => [
        BlocProvider<ThemeCubit>(
          create: (_) => sl(),
        ),
        BlocProvider<EfotainerCubit>(
          create: (_) => sl(),
        ),
      ];

  Route<String> _routes(RouteSettings settings) => MaterialPageRoute(
        builder: (_) => switch (settings.name) {
          defaultScreenRoute => FutureBuilder(
              future: Future<void>.delayed(
                const Duration(
                  seconds: splashDurationSeconds,
                ),
                FlutterNativeSplash.remove,
              ),
              builder: (_, __) => const HomeScreen(),
            ),
          homeScreenRoute || _ => const HomeScreen(),
        },
      );
}
