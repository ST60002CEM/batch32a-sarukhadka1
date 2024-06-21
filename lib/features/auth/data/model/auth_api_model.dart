import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
 
part 'auth_api_model.g.dart';
 
final authApiModelProvider =
    Provider<AuthApiModel>((ref) => const AuthApiModel.empty());
 
@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;
 
  const AuthApiModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
  });
 
  const AuthApiModel.empty()
      : id = '',
        firstName = '',
        lastName = '',
        email = '',
        phone = '',
        password = '';
 
  AuthEntity toEntity() {
    return AuthEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      phone: phone,
    );
  }
 
  AuthApiModel fromEntity(AuthEntity entity) {
    return AuthApiModel(
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      phone: entity.phone,
      password: entity.password,
    );
  }
 
  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);
 
  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);
 
  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        phone,
        password,
      ];
}