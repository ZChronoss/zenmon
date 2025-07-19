import 'package:zenmon/data/model/pokemon.dart';

abstract class PokemonRepository {
  Future<Pokemon> getPokemon(int id);
}