
import 'package:isar/isar.dart';

part 'growth_rate_model.g.dart';

@collection
class GrowthRateModel {
  Id id = Isar.autoIncrement;
  final String name;
  final List<int> levelToExp;

  GrowthRateModel({
    required this.name,
    required this.levelToExp,
  });

  factory GrowthRateModel.fromJson(Map<String, dynamic> json) {
    final levels = json['levels'] as List;
    final Set<int> levelToExp = {
      for (var level in levels)
        level['experience'] as int
    };

    return GrowthRateModel(
      name: json['name'],
      levelToExp: levelToExp.toList(),
    );
  }
}