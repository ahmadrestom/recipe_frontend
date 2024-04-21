class NutritionalInformation{
    final int calories;
    final int totalFat;
    final int cholesterol;
    final int carbohydrates;
    final int protein;
    final int sugar;
    final int sodium;

    NutritionalInformation({required this.calories, required this.totalFat, required this.cholesterol,
      required this.carbohydrates, required this.protein, required this.sugar, required this.sodium});

    factory NutritionalInformation.fromJson(Map<String, dynamic> json) {
        return NutritionalInformation(
            calories: json['calories'] as int,
            totalFat: json['totalFat'] as int,
            cholesterol: json['cholesterol'] as int,
            carbohydrates: json['carbohydrates'] as int,
            protein: json['protein'] as int,
            sugar: json['sugar'] as int,
            sodium: json['sodium'] as int,
        );
    }

    Map<String, dynamic> toJson() {
        return {
            'calories': calories,
            'totalFat': totalFat,
            'cholesterol': cholesterol,
            'carbohydrates': carbohydrates,
            'protein': protein,
            'sugar': sugar,
            'sodium': sodium,
        };
    }

}