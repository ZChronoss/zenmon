import 'package:zenmon/data/model/pokemon.dart';
import 'package:zenmon/domain/pokemon/repository/pokemon_repository.dart';

class GetPokemonUseCase {
  final PokemonRepository repository;

  GetPokemonUseCase(this.repository);

  Future<Pokemon> execute(int id) {
    return repository.getPokemon(id);
  }
}