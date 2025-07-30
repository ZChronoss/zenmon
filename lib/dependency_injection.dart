import 'package:http/http.dart' as http;
import 'package:zenmon/data/data_source/pokemon_local_data_source.dart';
import 'package:zenmon/data/data_source/pokemon_remote_data_source.dart';
import 'package:zenmon/data/repository_impl/pokemon_repository_impl.dart';
import 'package:zenmon/domain/pokemon/use_case/get_all_saved_pokemon_use_case.dart';
import 'package:zenmon/domain/pokemon/use_case/get_growth_rate_use_case.dart';
import 'package:zenmon/domain/pokemon/use_case/get_pokemon_from_remote_use_case.dart';
import 'package:zenmon/domain/pokemon/use_case/get_saved_pokemon_by_id_use_case.dart';
import 'package:zenmon/domain/pokemon/use_case/save_pokemon_use_case.dart';

class DependencyInjection {
  DependencyInjection._internal(); // Private constructor

  static final DependencyInjection _instance = DependencyInjection._internal();

  factory DependencyInjection() => _instance;

  final client = http.Client();

  // Data Sources
  late final pokemonRemoteDataSource = PokemonRemoteDataSourceImpl(client);
  late final pokemonLocalDataSource = PokemonLocalDataSourceImpl();

  // Repositories
  late final pokemonRepository = PokemonRepositoryImpl(pokemonRemoteDataSource, pokemonLocalDataSource);

  // Use Cases
  late final getPokemonFromRemoteUseCase = GetPokemonFromRemoteUseCase(pokemonRepository);
  late final getAllSavedPokemonUseCase = GetAllSavedPokemonUseCase(pokemonRepository);
  late final getGrowthRateUseCase = GetGrowthRateUseCase(pokemonRepository);
  late final getSavedPokemonByIDUseCase = GetSavedPokemonByIDUseCase(pokemonRepository);
  late final savePokemonUseCase = SavePokemonUseCase(pokemonRepository);
}