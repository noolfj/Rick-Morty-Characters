import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_characters/bloc/character_bloc.dart';
import 'package:rick_and_morty_characters/custom_widget/character_card_stye.dart';
import 'package:rick_and_morty_characters/model/character_data.dart';
import 'package:rick_and_morty_characters/screens/main/character_error_button.dart';
import 'package:rick_and_morty_characters/utils/app_styles.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<CharacterBloc>().add(LoadMoreCharacters());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.08,
        ),
        child: AppBar(
          elevation: 0,
          forceMaterialTransparency: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple[900]!,
                  Colors.indigo[900]!,
                  Colors.purple[800]!,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          title: Text(
            'Список персонажей',
            style: AppStyles.getAppTextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w600,
              context: context,
              fontFamily: 'comic',
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state is CharacterInitial || state is CharacterLoading) {
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return CharacterCard(
                  character: CharacterData.empty(),
                  isLoading: true,
                );
              },
            );
          } else if (state is CharacterError) {
            return const ReloadCharacterError();
          } else if (state is CharacterLoaded ||
              state is CharacterLoadingMore) {
            final characters = state is CharacterLoaded
                ? state.characters
                : (state as CharacterLoadingMore).characters;
            final isLoadingMore = state is CharacterLoadingMore;
           return Padding(
              padding: const EdgeInsets.only(top: 8), 
              child: ListView.builder(
                controller: _scrollController,
                itemCount: characters.length + (isLoadingMore ? 3 : 0),
                itemBuilder: (context, index) {
                  if (index < characters.length) {
                    final character = characters[index];
                    return CharacterCard(character: character);
                  } else {
                    return CharacterCard(
                      character: CharacterData.empty(),
                      isLoading: true,
                    );
                  }
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
