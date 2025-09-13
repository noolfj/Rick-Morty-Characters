import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty_characters/api/cubit/theme_cubit.dart';
import 'package:rick_and_morty_characters/model/character_data.dart';
import 'package:rick_and_morty_characters/screens/home_screen.dart';
import 'package:rick_and_morty_characters/api/api_service.dart';
import 'package:rick_and_morty_characters/bloc/character_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CharacterDataAdapter());
  Hive.registerAdapter(LocationInfoAdapter());
  await Hive.openBox<CharacterData>('favorites');

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CharacterBloc(apiService: ApiService())..add(LoadCharacters()),
        ),
        BlocProvider(
          create: (_) => ThemeCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
        return MaterialApp(
          color: Colors.white,
          debugShowCheckedModeBanner: false,
          title: 'Rick-Morty',
          theme: theme,
          home: const HomeScreen(),
          routes: {
            '/home_screen': (context) => const HomeScreen(),
          },
        );
      },
    );
  }
}
