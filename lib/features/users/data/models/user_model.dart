import 'package:my_app/features/users/domain/entities/user.dart';

class UserModel extends User {
  // Use a const constructor and forward parameters to the super class
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
    };
  }
}