import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenmon/data/data_source/pokemon_remote_data_source.dart';
import 'package:zenmon/data/repository_impl/pokemon_repository_impl.dart';
import 'package:zenmon/domain/pokemon/use_case/get_pokemon_use_case.dart';
import 'package:zenmon/presentation/pages/home/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:zenmon/presentation/pages/home/home_view_model.dart';

import 'package:zenmon/presentation/pages/home/peer_connection_view_model.dart';

void main() {
  final client = http.Client();
  final pokemonRemoteDataSource = PokemonRemoteDataSourceImpl(client);
  final pokemonRepository = PokemonRepositoryImpl(pokemonRemoteDataSource);
  final getPokemonUseCase = GetPokemonUseCase(pokemonRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(getPokemonUseCase)
        ),
        ChangeNotifierProvider(
          create: (_) => PeerConnectionViewModel()
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    )
  );
}
