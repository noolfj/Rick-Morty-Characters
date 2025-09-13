import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty_characters/model/character_data.dart';
import 'package:rick_and_morty_characters/custom_widget/character_card_stye.dart';
import 'package:rick_and_morty_characters/utils/app_styles.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['Все', 'По имени', 'Статус', 'Вид', 'Тип'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<CharacterData> _sortCharacters(
    List<CharacterData> characters,
    int index,
  ) {
    final sorted = List<CharacterData>.from(characters);
    final sortFunctions = [
      null,
      (CharacterData a, CharacterData b) => a.name.compareTo(b.name),
      (CharacterData a, CharacterData b) => a.status.compareTo(b.status),
      (CharacterData a, CharacterData b) => a.species.compareTo(b.species),
      (CharacterData a, CharacterData b) => a.gender.compareTo(b.gender),
    ];

    if (sortFunctions[index] != null) {
      sorted.sort(sortFunctions[index]!);
    }
    return sorted;
  }

  Widget _buildTabButton(int index) {
    final isActive = _tabController.index == index;
    return GestureDetector(
      onTap: () => _tabController.animateTo(index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isActive ? Colors.deepPurple[800] : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          _tabs[index],
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<CharacterData>('favorites');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.08,
        ),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
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
            'Избранное',
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
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<CharacterData> box, _) {
          if (box.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/bg_rick.png', width: 200, height: 200),
                  const SizedBox(height: 20),
                  Text(
                    "Нет избранных персонажей",
                    style: AppStyles.getAppTextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      context: context,
                      fontFamily: 'comic',
                    ),
                  ),
                ],
              ),
            );
          }

          final favorites = box.values.toList();

          return Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: Row(
                  children: List.generate(_tabs.length, _buildTabButton),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: List.generate(_tabs.length, (index) {
                    final sortedFavorites = _sortCharacters(favorites, index);
                    return ListView.builder(
                      itemCount: sortedFavorites.length,
                      itemBuilder: (_, i) =>
                          CharacterCard(character: sortedFavorites[i]),
                    );
                  }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
