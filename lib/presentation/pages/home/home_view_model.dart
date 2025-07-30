import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zenmon/data/model/pokemon.dart';
import 'package:zenmon/domain/pokemon/use_case/get_all_saved_pokemon_use_case.dart';
import 'package:zenmon/domain/pokemon/use_case/get_pokemon_from_remote_use_case.dart';
import 'package:zenmon/domain/pokemon/use_case/get_saved_pokemon_by_id_use_case.dart';
import 'package:zenmon/domain/pokemon/use_case/save_pokemon_use_case.dart';

class HomeViewModel extends ChangeNotifier {
  final GetPokemonFromRemoteUseCase getPokemonFromRemoteUseCase;
  final GetAllSavedPokemonUseCase getAllGatheredPokemonUseCase;
  final GetSavedPokemonByIDUseCase getSavedPokemonByIDUseCase;
  final SavePokemonUseCase savePokemonUseCase;

  HomeViewModel(
    this.getPokemonFromRemoteUseCase,
    this.getAllGatheredPokemonUseCase,
    this.getSavedPokemonByIDUseCase,
    this.savePokemonUseCase
  );

  void initialize() async {
    setLoading(true);
    final pokemons = await getAllGatheredPokemonUseCase.execute();
    if (pokemons.isNotEmpty) {
      pokemon = pokemons.first;
    }
    setLoading(false);
    notifyListeners();
}

  bool isLoading = false;
  String? errorMessage;
  Pokemon? pokemon;

  Future<bool> doesUserHasPokemon() async {
    final pokemons = await getAllGatheredPokemonUseCase.execute();

    return pokemons.isNotEmpty;
  }

  Future<Pokemon> openNewPokemon() async {
    int randomPokemonId = Random().nextInt(649) + 1;
    Pokemon? toBeSavedPokemon = await getSavedPokemonByIDUseCase.execute(randomPokemonId);

    while(toBeSavedPokemon != null) {
      randomPokemonId = Random().nextInt(649) + 1;
      toBeSavedPokemon = await getSavedPokemonByIDUseCase.execute(randomPokemonId);
    }

    setLoading(true);
    toBeSavedPokemon = await loadPokemon(randomPokemonId);
    savePokemonUseCase.execute(toBeSavedPokemon);
    setLoading(false);

    pokemon = toBeSavedPokemon;
    notifyListeners();
    return toBeSavedPokemon;
  }

  Future<Pokemon> loadPokemon(int id) async {
    setLoading(true);
    Pokemon pokemon;

    while(true) {
      try {
        final result = await getPokemonFromRemoteUseCase.execute(id);
        if(result.animatedSpriteUrl!.isNotEmpty) {
          pokemon = result;
          break;
        }
      } catch(e) {
        errorMessage = "Failed to fetch Pokemon: $e";
      }
    }

    setLoading(false);
    notifyListeners();
    return pokemon;
  }

  void setLoading(bool loading) {
    isLoading = loading;

    if(isLoading) {
      errorMessage = null;
    }
  }
}