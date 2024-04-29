class Ingredients{
  final String name;
  final int grams;

  Ingredients(this.name, this.grams);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'grams': grams,
    };
  }

  factory Ingredients.fromJson(Map<String, dynamic> json) {
    return Ingredients(
      json['name'] as String,
      json['grams'] as int,
    );
  }

}