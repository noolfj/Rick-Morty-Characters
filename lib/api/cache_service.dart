import 'package:hive/hive.dart';
import 'package:rick_and_morty_characters/model/character_data.dart';

const String cacheBoxName = 'characters_cache';

class CharacterCacheService {
  static Future<void> saveCharacters(List<CharacterData> characters) async {
    final box = await Hive.openBox<CharacterData>(cacheBoxName);
    await box.clear(); 
    for (var i = 0; i < characters.length && i < 20; i++) {
      await box.put(characters[i].id, characters[i]);
    }
  }

  static Future<List<CharacterData>> loadCachedCharacters() async {
    final box = await Hive.openBox<CharacterData>(cacheBoxName);
    return box.values.toList();
  }
}
