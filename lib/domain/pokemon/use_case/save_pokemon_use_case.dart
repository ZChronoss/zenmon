import 'package:zenmon/data/model/pokemon.dart';
import 'package:zenmon/domain/pokemon/repository/pokemon_repository.dart';

class SavePokemonUseCase {
  final PokemonRepository repository;

  SavePokemonUseCase(this.repository);

  Future<void> execute(Pokemon pokemon) {
    return repository.savePokemon(pokemon);
  }
}