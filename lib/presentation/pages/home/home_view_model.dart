import 'package:flutter/material.dart';
import 'package:zenmon/data/model/pokemon.dart';
import 'package:zenmon/domain/pokemon/use_case/get_pokemon_use_case.dart';

class HomeViewModel extends ChangeNotifier {
  final GetPokemonUseCase getPokemonUseCase;

  HomeViewModel(this.getPokemonUseCase);

  bool isLoading = false;
  String? errorMessage;
  Pokemon? pokemon;

  Future<void> loadPokemon(int id) async {
    setLoading(true);
    pokemon = null;
    // notifyListeners();

    while(true) {
      try {
        final result = await getPokemonUseCase.execute(id);
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
  }

  void setLoading(bool loading) {
    isLoading = loading;

    if(isLoading) {
      errorMessage = null;
    }
  }
}