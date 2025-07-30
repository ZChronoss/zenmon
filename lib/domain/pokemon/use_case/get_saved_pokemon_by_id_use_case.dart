import 'package:zenmon/data/model/pokemon.dart';
import 'package:zenmon/domain/pokemon/repository/pokemon_repository.dart';

class GetSavedPokemonByIDUseCase {
  final PokemonRepository repository;

  GetSavedPokemonByIDUseCase(this.repository);

  Future<Pokemon?> execute(int id) {
    return repository.getSavedPokemonById(id);
  }
}