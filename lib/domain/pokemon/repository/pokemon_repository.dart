import 'package:zenmon/data/model/growth_rate_model.dart';
import 'package:zenmon/data/model/pokemon.dart';

abstract class PokemonRepository {
  Future<Pokemon> getPokemonFromRemote(int id);
  Future<Pokemon?> getSavedPokemonById(int id);
  Future<List<Pokemon>> getAllSavedPokemon();
  Future<void> savePokemon(Pokemon pokemon);
  Future<GrowthRateModel> getGrowthRate(String name);
}