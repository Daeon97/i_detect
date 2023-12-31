// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_detect/cubits/details_cubit/details_cubit.dart';
import 'package:i_detect/cubits/location_details_cubit/location_details_cubit.dart';
import 'package:i_detect/injection_container.dart';
import 'package:i_detect/views/screens/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: _providers,
        child: MaterialApp(
          onGenerateRoute: _routes,
        ),
      );

  List<BlocProvider> get _providers => [
        BlocProvider<DetailsCubit>(
          create: (_) => sl<DetailsCubit>(),
        ),
        BlocProvider<LocationDetailsCubit>(
          create: (_) => sl<LocationDetailsCubit>(),
        ),
      ];

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
