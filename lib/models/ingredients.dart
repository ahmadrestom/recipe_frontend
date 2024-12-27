class Ingredients{
  final String name;
  final int grams;

  Ingredients(this.name, this.grams);

  Map<String, dynamic> toJson() {
    return {
      'ingredientName': name,
      'grams': grams,
    };
  }

  factory Ingredients.fromJson(Map<String, dynamic> json) {

    return Ingredients(
      json['ingredientName'] as String,
      json['grams'] as int,
    );
  }

}