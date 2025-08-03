import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenmon/dependency_injection.dart';
import 'package:zenmon/presentation/pages/collection/pokemon_collection_view_model.dart';
import 'package:zenmon/presentation/pages/home/home_view_model.dart';

import 'package:zenmon/presentation/pages/home/peer_connection_view_model.dart';
import 'package:zenmon/presentation/pages/main_navigation.dart';

void main() {
  final di = DependencyInjection();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(
            di.getPokemonFromRemoteUseCase,
            di.getAllSavedPokemonUseCase,
            di.getSavedPokemonByIDUseCase,
            di.savePokemonUseCase,
            di.getGrowthRateUseCase
          )
        ),
        ChangeNotifierProvider(
          create: (_) => PeerConnectionViewModel()
        ),
        ChangeNotifierProvider(
          create: (_) => PokemonCollectionViewModel(
            di.getAllSavedPokemonUseCase
          )
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const MainNavigation(),
      ),
    )
  );
}
