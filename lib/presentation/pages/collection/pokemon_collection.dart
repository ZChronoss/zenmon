import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenmon/data/model/pokemon.dart';
import 'package:zenmon/presentation/pages/collection/pokemon_collection_view_model.dart';

class PokemonCollectionPage extends StatelessWidget {
  const PokemonCollectionPage({super.key});

  Widget _pokemonTile(Pokemon pokemon) {
    return ListTile(
      leading: Image.network(
        pokemon.animatedSpriteUrl ?? '',
        width: 50,
      ),
      title: Text(pokemon.name),
      subtitle: Text('Level: ${pokemon.level} | Exp: ${pokemon.experience}'),
    );
  }

  Widget _buildPokemonList(BuildContext context, PokemonCollectionViewModel viewModel) {
    if (viewModel.pokemons.isEmpty) {
      return const Center(child: Text('No Pokémon collected yet!'));
    }
    return ListView.builder(
      itemCount: viewModel.pokemons.length,
      itemBuilder: (context, index) {
        final pokemon = viewModel.pokemons[index];
        return _pokemonTile(pokemon);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PokemonCollectionViewModel>();
    viewModel.getAllPokemons(); 

    return Scaffold(
      appBar: AppBar(title: const Text('Your Pokémon Collection')),
      body: _buildPokemonList(context, viewModel)
    );
  }
}