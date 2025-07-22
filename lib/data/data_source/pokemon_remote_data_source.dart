import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/pokemon.dart';

abstract class PokemonRemoteDataSource {
  Future<Pokemon> fetchPokemon(int id);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final http.Client client;

  PokemonRemoteDataSourceImpl(this.client);

  @override
  Future<Pokemon> fetchPokemon(int id) async {
    final response = await client.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'),
      // headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch Pokémon');
    }

    final jsonMap = json.decode(response.body);
    return _mapJsonToPokemon(jsonMap);
  }

  Pokemon _mapJsonToPokemon(Map<String, dynamic> json) {
    final sprites = json['sprites']?['versions']?['generation-v']?['black-white']?['animated'];
    final spriteUrl = sprites?['front_default'] as String?;

    return Pokemon(
      id: json['id'],
      name: json['name'],
      animatedSpriteUrl: spriteUrl,
    );
  }
}