import 'package:zenmon/data/data_source/pokemon_local_data_source.dart';
import 'package:zenmon/data/data_source/pokemon_remote_data_source.dart';
import 'package:zenmon/data/model/growth_rate_model.dart';
import 'package:zenmon/data/model/pokemon.dart';
import 'package:zenmon/domain/pokemon/repository/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;
  final PokemonLocalDataSource localDataSource;

  PokemonRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Pokemon> getPokemonFromRemote(int id) {
    return remoteDataSource.fetchPokemon(id);
  }

  @override
    Future<List<Pokemon>> getAllSavedPokemon() {
      return localDataSource.getAllSavedPokemon();
    }
  
    @override
    Future<Pokemon?> getSavedPokemonById(int id) {
      return localDataSource.getSavedPokemonById(id);
    }
  
    @override
    Future<void> savePokemon(Pokemon pokemon) {
      return localDataSource.savePokemon(pokemon);
    }

  @override
  Future<GrowthRateModel> getGrowthRate(String name) async {
    // if cache is available
    final cached = await localDataSource.getCachedGrowthRate(name);
    if (cached != null) {
      return cached;
    }

    // if not fetch from network
    final model = await remoteDataSource.fetchGrowthRate(name);

    // cache fetched growth rate
    await localDataSource.saveGrowthRate(model);
    return model;
  }
}