import 'package:zenmon/data/model/pokemon.dart';
import 'package:zenmon/domain/pokemon/repository/pokemon_repository.dart';

class GetAllSavedPokemonUseCase {
  final PokemonRepository repository;

  GetAllSavedPokemonUseCase(this.repository);

  Future<List<Pokemon>> execute() {
    return repository.getAllSavedPokemon();
  }
}