import 'package:zenmon/data/model/pokemon.dart';
import 'package:zenmon/domain/pokemon/repository/pokemon_repository.dart';

class GetPokemonFromRemoteUseCase {
  final PokemonRepository repository;

  GetPokemonFromRemoteUseCase(this.repository);

  Future<Pokemon> execute(int id) {
    return repository.getPokemonFromRemote(id);
  }
}