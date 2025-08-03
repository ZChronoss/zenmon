import 'package:isar/isar.dart';

part 'pokemon.g.dart';

@collection
class Pokemon {
  final Id id;
  final String name;
  final String? animatedSpriteUrl;
  int level = 1;
  int experience = 0;

  Pokemon({
    required this.id,
    required this.name,
    this.animatedSpriteUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final sprites = json['sprites']?['versions']?['generation-v']?['black-white']?['animated'];
    final spriteUrl = sprites?['front_default'] as String?;

    return Pokemon(
      id: json['id'],
      name: json['name'],
      animatedSpriteUrl: spriteUrl,
    );
  }
}