import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';

class BookingEntity extends Equatable {
  final String? id;
  final String userId;
  final String artistId;
  final DateTime date;
  final String time;
  final String status;
  final String paymentMethod;
  final AuthEntity? authEntity;

  const BookingEntity({
    this.id,
    required this.userId,
    required this.artistId,
    required this.date,
    required this.time,
    this.status = 'pending',
    this.paymentMethod = 'Cash on arrival',
    this.authEntity,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        artistId,
        date,
        time,
        status,
        paymentMethod,
        authEntity
      ];
}
