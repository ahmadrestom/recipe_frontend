class Follower{
  final String id;
  final String firstName;
  final String lastName;
  final String? imageUrl;
  final String role;

  Follower({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
    required this.role
  });

  factory Follower.fromJson(Map<String, dynamic> json){
    return Follower(
        id: json['id'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        imageUrl: json['imageUrl'] as String?,
        role: json['role'] as String
    );
  }

    Map<String, dynamic> toJson(){
      return {
        'id':id,
        'firstName':firstName,
        'lastName': lastName,
        'imageUrl': imageUrl,
        'role': role
      };
    }
  }