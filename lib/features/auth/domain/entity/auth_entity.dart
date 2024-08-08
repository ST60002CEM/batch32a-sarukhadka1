import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String firstName;
  final String lastName;
  final String? image;
  final int phone;
  final String email;
  final String password; 

  const AuthEntity({
    this.id,
    required this.firstName,
    required this.lastName,
    this.image,
    required this.phone,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props =>
      [id, firstName, lastName, image, phone, email, password];
}
