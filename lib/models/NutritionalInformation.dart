class NutritionalInformation{
  final double calories;
  final double totalFat;
  final double cholesterol;
  final double carbohydrates;
  final double protein;
  final double sugar;
  final double sodium;
  final double fiber;
  final double zinc;
  final double magnesium;
  final double potassium;

  NutritionalInformation({
    required this.calories,
    required this.totalFat,
    required this.cholesterol,
    required this.carbohydrates,
    required this.protein,
    required this.sugar,
    required this.sodium,
    required this.fiber,
    required this.zinc,
    required this.magnesium,
    required this.potassium
  });

  int getCount(){
    return 11;//return the number of info attributes for the listview
  }

  factory NutritionalInformation.fromJson(Map<String, dynamic> json) {
    return NutritionalInformation(
      calories: json['calories'] as double,
      totalFat: json['total_fat'] as double,
      cholesterol: json['cholesterol'] as double,
      carbohydrates: json['carbohydrates'] as double,
      protein: json['protein'] as double,
      sugar: json['sugar'] as double,
      sodium: json['sodium'] as double,
      fiber: json['fiber'] as double,
      zinc: json['zinc'] as double,
      magnesium: json['magnesium'] as double,
      potassium: json['potassium'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
      'total_fat': totalFat,
      'cholesterol': cholesterol,
      'carbohydrates': carbohydrates,
      'protein': protein,
      'sugar': sugar,
      'sodium': sodium,
      'fiber': fiber,
      'zinc': zinc,
      'magnesium': magnesium,
      'potassium': potassium
    };
  }

}