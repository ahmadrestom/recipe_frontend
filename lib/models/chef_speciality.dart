class ChefSpeciality{
  final String specialityId;
  final String speciality;
  final String description;

  ChefSpeciality(
    {required this.specialityId,
     required this.speciality,
     required this.description
    }
     );

  Map<String, dynamic> toJson(){
    return {
      'specialityId': specialityId,
      'speciality': speciality,
      'description':description
    };
  }

  factory ChefSpeciality.fromJson(Map<String, dynamic> json){
    return ChefSpeciality(
      specialityId: json['specialityId'] as String,
      speciality: json['speciality'] as String,
      description: json['description'] as String
  );
  }
}