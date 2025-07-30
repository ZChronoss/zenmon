import 'package:zenmon/data/model/growth_rate_model.dart';
import 'package:zenmon/domain/pokemon/repository/pokemon_repository.dart';

class GetGrowthRateUseCase {
  final PokemonRepository repository;

  GetGrowthRateUseCase(this.repository);

  Future<GrowthRateModel> execute(String name) {
    return repository.getGrowthRate(name);
  }
}