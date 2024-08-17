import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/booking/data/dto/get_booking_dto.dart';
import 'package:final_assignment/features/booking/data/model/booking_api_model.dart';
import 'package:final_assignment/features/booking/domain/entity/booking_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookingRemoteDataSourceProvider =
    Provider<BookingRemoteDataSource>((ref) {
  return BookingRemoteDataSource(
      ref.watch(httpServiceProvider), ref.watch(userSharedPrefsProvider));
});

class BookingRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPreferences;

  BookingRemoteDataSource(this.dio, this.userSharedPreferences);

  Future<Either<Failure, bool>> createBooking(BookingEntity booking) async {
    try {
      String? token;
      final data = await userSharedPreferences.getUserToken();

      data.fold((l) => token = null, (r) => token = r);
      print('test');
      print("token: $token");
      print(booking);
      print(BookingApiModel.fromEntity(booking).toJson());

      final response = await dio.post(
        ApiEndpoints.createBooking,
        data: BookingApiModel.fromEntity(booking).toJson(),
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        throw Exception('Error creating booking');
      }
    } catch (e) {
      return Left(Failure(error: 'Error creating booking: $e'));
    }
  }

  Future<Either<Failure, List<BookingEntity>>> fetchBookings() async {
    try {
      String? token;
      final data = await userSharedPreferences.getUserToken();

      data.fold((l) => token = null, (r) => token = r);

      final response = await dio.get(
        ApiEndpoints.getUserBookings,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        final bookingDto = GetBookingDto.fromJson(response.data);
        return Right(BookingApiModel.toEntities(bookingDto.data));
      } else {
        throw Exception('Error fetching user bookings');
      }
    } catch (e) {
      return Left(Failure(error: 'Error fetching user bookings: $e'));
    }
  }
}
