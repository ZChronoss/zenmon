import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zenmon/data/model/growth_rate_model.dart';
import 'package:zenmon/data/model/pokemon.dart';

abstract class PokemonLocalDataSource {
  Future<void> saveGrowthRate(GrowthRateModel model);
  Future<GrowthRateModel?> getCachedGrowthRate(String name);
  Future<void> savePokemon(Pokemon pokemon);
  Future<List<Pokemon>> getAllSavedPokemon();
  Future<Pokemon?> getSavedPokemonById(int id);
}

class PokemonLocalDataSourceImpl extends PokemonLocalDataSource {
  late Future<Isar> db;

  PokemonLocalDataSourceImpl() {
    db = openDB();
  }

  // MARK: Growth Rate
  @override
  Future<void> saveGrowthRate(GrowthRateModel model) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.growthRateModels.put(model);
    });
  }

  @override
  Future<GrowthRateModel?> getCachedGrowthRate(String name) async {
    final isar = await db;
    return await isar.growthRateModels
        .filter()
        .nameEqualTo(name)
        .findFirst();
  }

  // MARK: Pokemon
  @override
  Future<void> savePokemon(Pokemon pokemon) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.pokemons.put(pokemon);
    });
  }

  @override
  Future<List<Pokemon>> getAllSavedPokemon() async {
    final isar = await db;
    return await isar.pokemons.where().findAll();
  }

  @override
  Future<Pokemon?> getSavedPokemonById(int id) async {
    final isar = await db;
    return await isar.pokemons.get(id);
  }

  Future<Isar> openDB() async {
    var dir = await getApplicationDocumentsDirectory();
    // to get application directory information

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        //open isar
        [
          PokemonSchema,
          GrowthRateModelSchema
        ],
        //user.g.dart includes the schemes that we need to define here - it can be single or multiple.
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }
}