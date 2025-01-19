class ChefSpeciality{
  final String specialityId;
  final String speciality;

  ChefSpeciality(
    {required this.specialityId,
     required this.speciality
    }
     );

  Map<String, dynamic> toJson(){
    return {
      'specialityId': specialityId,
      'speciality': speciality
    };
  }

  factory ChefSpeciality.fromJson(Map<String, dynamic> json){
    return ChefSpeciality(
      specialityId: json['specialityId'] as String,
      speciality: json['speciality'] as String
  );
  }
}