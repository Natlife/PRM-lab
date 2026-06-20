class UserModel {
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String image;
  final String token;
  final String loginType;

  UserModel({
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.token,
    required this.loginType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      image: json['image'] ?? '',
      token: json['token'] ?? '',
      loginType: json['loginType'] ?? 'Real API',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'image': image,
      'token': token,
      'loginType': loginType,
    };
  }
}
