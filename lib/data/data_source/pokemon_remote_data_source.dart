import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zenmon/constant.dart';
import 'package:zenmon/data/model/growth_rate_model.dart';
import '../model/pokemon.dart';

abstract class PokemonRemoteDataSource {
  Future<Pokemon> fetchPokemon(int id);
  Future<GrowthRateModel> fetchGrowthRate(String name);
  Future<String> fetchGrowthRateNameFromPokemon(int id);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final http.Client client;

  PokemonRemoteDataSourceImpl(this.client);

  @override
  Future<Pokemon> fetchPokemon(int id) async {
    final response = await client.get(
        Uri.parse('$baseUrl/pokemon/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch Pokémon');
    }

    final jsonMap = json.decode(response.body);

    final pokemon = Pokemon.fromJson(jsonMap);
    return pokemon;
  }
  
  @override
  Future<GrowthRateModel> fetchGrowthRate(String name) async {
    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/growth-rate/$name')
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch Pokémon');
    }

    final jsonMap = json.decode(response.body);

    final growthRates = GrowthRateModel.fromJson(jsonMap);

    return growthRates;
  }

  @override
  Future<String> fetchGrowthRateNameFromPokemon(int id) async {
    final speciesRes = await client.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon-species/$id'),
    );

    if (speciesRes.statusCode != 200) {
      throw Exception('Failed to load species data');
    }

    final speciesJson = jsonDecode(speciesRes.body);
    final growthRateJson = speciesJson['growth_rate'];
    return growthRateJson['name'];

  }
}