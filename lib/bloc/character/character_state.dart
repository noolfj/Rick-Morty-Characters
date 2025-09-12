part of 'character_bloc.dart';

abstract class CharacterState extends Equatable {
  const CharacterState();

  @override
  List<Object?> get props => [];
}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterLoadingMore extends CharacterState {
  final List<CharacterData> characters;
  const CharacterLoadingMore({required this.characters});

  @override
  List<Object?> get props => [characters];
}

class CharacterLoaded extends CharacterState {
  final List<CharacterData> characters;
  final bool hasReachedMax;

  const CharacterLoaded({required this.characters, required this.hasReachedMax});

  @override
  List<Object?> get props => [characters, hasReachedMax];
}

class CharacterError extends CharacterState {
  final String message;
  const CharacterError({required this.message});

  @override
  List<Object?> get props => [message];
}
