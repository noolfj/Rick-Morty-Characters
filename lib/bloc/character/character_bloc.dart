import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_characters/api/api_service.dart';
import 'package:rick_and_morty_characters/model/character_data.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final ApiService apiService;

  CharacterBloc({required this.apiService}) : super(CharacterInitial()) {
    on<LoadCharacters>(_getLoadCharacters);
    on<LoadMoreCharacters>(_getLoadMoreCharacters);
  }

  int currentPage = 1;
  int totalPages = 1;

  Future<void> _getLoadCharacters(
      LoadCharacters event, Emitter<CharacterState> emit) async {
    emit(CharacterLoading());
    try {
      currentPage = 1;
      final data = await apiService.getCharacters(page: currentPage);
      totalPages = data['info']['pages'];
      final results = data['results'] as List;
      final characters =
          results.map((e) => CharacterData.fromJson(e)).toList();
      emit(CharacterLoaded(characters: characters, hasReachedMax: currentPage >= totalPages));
    } catch (e) {
      emit(CharacterError(message: e.toString()));
    }
  }

  Future<void> _getLoadMoreCharacters(
      LoadMoreCharacters event, Emitter<CharacterState> emit) async {
    if (state is CharacterLoaded) {
      final currentState = state as CharacterLoaded;
      if (currentState.hasReachedMax) return;

      emit(CharacterLoadingMore(characters: currentState.characters));

      try {
        currentPage++;
        final data = await apiService.getCharacters(page: currentPage);
        final results = data['results'] as List;
        final newCharacters =
            results.map((e) => CharacterData.fromJson(e)).toList();

        emit(CharacterLoaded(
          characters: currentState.characters + newCharacters,
          hasReachedMax: currentPage >= totalPages,
        ));
      } catch (e) {
        emit(CharacterError(message: e.toString()));
      }
    }
  }
}
