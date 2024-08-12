// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingApiModel _$BookingApiModelFromJson(Map<String, dynamic> json) =>
    BookingApiModel(
      id: json['_id'] as String?,
      userId: json['userId'] as String,
      artistId: json['artistId'] as String,
      date: DateTime.parse(json['date'] as String),
      time: json['time'] as String,
      status: json['status'] as String? ?? 'pending',
      paymentMethod: json['paymentMethod'] as String? ?? 'Pay on arrival',
      authEntity: json['authEntity'] == null
          ? null
          : AuthApiModel.fromJson(json['authEntity'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingApiModelToJson(BookingApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'artistId': instance.artistId,
      'date': instance.date.toIso8601String(),
      'time': instance.time,
      'status': instance.status,
      'paymentMethod': instance.paymentMethod,
      'authEntity': instance.authEntity,
    };
