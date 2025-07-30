import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenmon/dependency_injection.dart';
import 'package:zenmon/presentation/pages/home/home_page.dart';
import 'package:zenmon/presentation/pages/home/home_view_model.dart';

import 'package:zenmon/presentation/pages/home/peer_connection_view_model.dart';

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
            di.savePokemonUseCase
          )
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
