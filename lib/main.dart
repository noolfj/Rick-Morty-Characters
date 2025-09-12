import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_characters/screens/home_screen.dart';
import 'package:rick_and_morty_characters/api/api_service.dart';
import 'package:rick_and_morty_characters/bloc/character/character_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CharacterBloc(apiService: ApiService())..add(LoadCharacters()),
      child: MaterialApp(
        color: Colors.white,
        debugShowCheckedModeBanner: false,
        title: 'Rick&Morty',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const HomeScreen(),
        routes: {
          '/home_screen': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
