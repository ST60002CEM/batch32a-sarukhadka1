// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingApiModel _$BookingApiModelFromJson(Map<String, dynamic> json) =>
    BookingApiModel(
      id: json['_id'] as String?,
      user: json['user'] as String?,
      artist: json['artist'] as String,
      date: DateTime.parse(json['date'] as String),
      time: json['time'] as String,
      status: json['status'] as String? ?? 'pending',
      paymentMethod: json['paymentMethod'] as String? ?? 'Cash on arrival',
      authEntity: json['authEntity'] == null
          ? null
          : AuthApiModel.fromJson(json['authEntity'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingApiModelToJson(BookingApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'artist': instance.artist,
      'date': instance.date.toIso8601String(),
      'time': instance.time,
      'status': instance.status,
      'paymentMethod': instance.paymentMethod,
      'authEntity': instance.authEntity,
    };
