import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/auth/data/model/auth_api_model.dart';
import 'package:final_assignment/features/booking/domain/entity/booking_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_api_model.g.dart';

final bookingModelProvider = Provider<BookingApiModel>((ref) {
  return BookingApiModel.empty();
});

@JsonSerializable()
class BookingApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? user;
  final String artist;
  final DateTime date;
  final String time;
  final String status;
  final String paymentMethod;
  final AuthApiModel? authEntity;

  BookingApiModel({
    this.id,
    required this.user,
    required this.artist,
    required this.date,
    required this.time,
    this.status = 'pending',
    this.paymentMethod = 'Cash on arrival',
    this.authEntity,
  });

  BookingApiModel.empty()
      : id = '',
        user = '',
        artist = '',
        date = DateTime.now(),
        time = '',
        paymentMethod = 'Cash on arrival',
        status = '',
        authEntity = const AuthApiModel.empty();

  factory BookingApiModel.fromJson(Map<String, dynamic> json) =>
      _$BookingApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingApiModelToJson(this);

  factory BookingApiModel.fromEntity(BookingEntity entity) => BookingApiModel(
        id: entity.id,
        user: entity.user,
        artist: entity.artist,
        date: entity.date,
        time: entity.time,
        paymentMethod: entity.paymentMethod,
        status: entity.status,
        authEntity: entity.authEntity != null
            ? AuthApiModel.fromEntity(entity.authEntity!)
            : null,
      );

  BookingEntity toEntity() => BookingEntity(
        id: id,
        user: user,
        artist: artist,
        date: date,
        time: time,
        paymentMethod: paymentMethod,
        status: status,
        authEntity: authEntity?.toEntity(),
      );

  static List<BookingEntity> toEntities(List<BookingApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        id,
        user,
        artist,
        date,
        time,
        paymentMethod,
        status,
        authEntity,
      ];
}
