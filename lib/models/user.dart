class UserModel {
  int? id;

  String firstName;
  String lastName;
  String phone;
  String email;
  String password;
  String role;

  String? city;
  String? job;
  String? description;
  String? experience;
  String? image;

  UserModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.password,
    required this.role,
    this.city,
    this.job,
    this.description,
    this.experience,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "phone": phone,
      "email": email,
      "password": password,
      "role": role,
      "city": city,
      "job": job,
      "description": description,
      "experience": experience,
      "image": image,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map["id"],
      firstName: map["firstName"],
      lastName: map["lastName"],
      phone: map["phone"],
      email: map["email"],
      password: map["password"],
      role: map["role"],
      city: map["city"],
      job: map["job"],
      description: map["description"],
      experience: map["experience"],
      image: map["image"],
    );
  }
}