// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  int id;
  String name;
  String email;
  String role;
  String? profileImage;
  User(
    this.profileImage, {
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['profile_image'],
      id: map['user']['id'] as int,
      name: map['user']['name'] as String,
      email: map['user']['email'] as String,
      role: map['user']['role'] as String,
    );
  }
}
