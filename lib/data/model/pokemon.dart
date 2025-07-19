class Pokemon {
  final int id;
  final String name;
  final String? animatedSpriteUrl;

  Pokemon({
    required this.id,
    required this.name,
    this.animatedSpriteUrl,
  });
}