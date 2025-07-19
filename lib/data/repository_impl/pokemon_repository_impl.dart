import 'package:zenmon/data/data_source/pokemon_remote_data_source.dart';
import 'package:zenmon/data/model/pokemon.dart';
import 'package:zenmon/domain/pokemon/repository/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;

  PokemonRepositoryImpl(this.remoteDataSource);

  @override
  Future<Pokemon> getPokemon(int id) {
    return remoteDataSource.fetchPokemon(id);
  }
}