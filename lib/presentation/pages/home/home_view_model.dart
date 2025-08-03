import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zenmon/data/model/pokemon.dart';
import 'package:zenmon/domain/pokemon/use_case/get_all_saved_pokemon_use_case.dart';
import 'package:zenmon/domain/pokemon/use_case/get_growth_rate_use_case.dart';
import 'package:zenmon/domain/pokemon/use_case/get_pokemon_from_remote_use_case.dart';
import 'package:zenmon/domain/pokemon/use_case/get_saved_pokemon_by_id_use_case.dart';
import 'package:zenmon/domain/pokemon/use_case/save_pokemon_use_case.dart';

class HomeViewModel extends ChangeNotifier {
  final GetPokemonFromRemoteUseCase getPokemonFromRemoteUseCase;
  final GetAllSavedPokemonUseCase getAllGatheredPokemonUseCase;
  final GetSavedPokemonByIDUseCase getSavedPokemonByIDUseCase;
  final SavePokemonUseCase savePokemonUseCase;
  final GetGrowthRateUseCase getGrowthRateUseCase;

  HomeViewModel(
    this.getPokemonFromRemoteUseCase,
    this.getAllGatheredPokemonUseCase,
    this.getSavedPokemonByIDUseCase,
    this.savePokemonUseCase,
    this.getGrowthRateUseCase
  );

  void initialize() async {
    setLoading(true);
    final pokemons = await getAllGatheredPokemonUseCase.execute();
    if (pokemons.isNotEmpty) {
      pokemon = pokemons.last;
    }
    setLoading(false);
    notifyListeners();
}

  bool isLoading = false;
  String? errorMessage;
  Pokemon? pokemon;

  Future<void> openNewPokemon() async {
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
  }

  void checkForLevelUp(int collectedExp) async {
    setLoading(true);

    if(pokemon == null) {
      return;
    }

    int pokemonExp = pokemon!.experience;
    int pokemonLevel = pokemon!.level;

    final growthRate = await getGrowthRateUseCase.execute(pokemon!.id);
    final expTable = growthRate.levelToExp;

    // exp cap obtained from the next level's experience
    int expCap = expTable[pokemonLevel]; // 10 (pokemon level 1)
    pokemonExp += collectedExp; // awal 7, dapet 30 = 37

    // example from 'slow' growth rate
    // 1. 37 > 10 (V)
    // 2. 37 > 33 (V)
    // 3. 37 > 80 (X)
    while(pokemonExp > expCap) {
      pokemonLevel++; // level 1 -> 2, 2 -> 3
      expCap = expTable[pokemonLevel]; // 33 (pokemon level 2), 80 (pokemon level 3)
    }
    pokemon!.experience = pokemonExp;
    pokemon!.level = pokemonLevel;
    savePokemonUseCase.execute(pokemon!);

    setLoading(false);
    notifyListeners();
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