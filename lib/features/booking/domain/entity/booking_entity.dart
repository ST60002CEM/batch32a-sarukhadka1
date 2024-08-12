import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';

class BookingEntity extends Equatable {
  final String? id;
  final String user;
  final String artist;
  final DateTime date;
  final String time;
  final String status;
  final String paymentMethod;
  final AuthEntity? authEntity;

  const BookingEntity({
    this.id,
    required this.user,
    required this.artist,
    required this.date,
    required this.time,
    this.status = 'pending',
    this.paymentMethod = 'Cash on arrival',
    this.authEntity,
  });

  @override
  List<Object?> get props => [
        id,
        user,
        artist,
        date,
        time,
        status,
        paymentMethod,
        authEntity
      ];
}
