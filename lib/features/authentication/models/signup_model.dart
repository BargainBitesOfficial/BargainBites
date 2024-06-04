class SignupModel {
  String name;
  String email;
  String password;
  String country;
  String postalCode;

  SignupModel({
    required this.name,
    required this.email,
    required this.password,
    required this.country,
    required this.postalCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'country': country,
      'postalCode': postalCode,
    };
  }
}