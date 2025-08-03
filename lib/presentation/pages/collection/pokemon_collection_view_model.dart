import 'package:flutter/material.dart';
import 'package:zenmon/data/model/pokemon.dart';
import 'package:zenmon/domain/pokemon/use_case/get_all_saved_pokemon_use_case.dart';

class PokemonCollectionViewModel extends ChangeNotifier {
  final GetAllSavedPokemonUseCase getAllGatheredPokemonUseCase;

  PokemonCollectionViewModel(
    this.getAllGatheredPokemonUseCase
  );

  List<Pokemon> pokemons = [];

  void getAllPokemons() async {
    List<Pokemon> allPokemons = await getAllGatheredPokemonUseCase.execute();
    pokemons = allPokemons;
    notifyListeners();
  }
}