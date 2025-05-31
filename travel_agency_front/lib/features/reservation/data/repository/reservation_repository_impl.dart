import 'package:travel_agency_front/features/reservation/data/datasources/reservation_api_services.dart';
import 'package:travel_agency_front/features/reservation/data/models/reservation_request_model.dart';
import 'package:travel_agency_front/features/reservation/domain/entities/reservation.dart';
import 'package:travel_agency_front/features/reservation/domain/repository/reservation_repository.dart';

class ReservationRepositoryImpl implements ReservationRepository {
  final ReservationApiService reservationApiService;

  ReservationRepositoryImpl(this.reservationApiService);

  @override
  Future<Reservation> addReservation(
      ReservationRequestModel request, String token) {
    return reservationApiService.addReservation(request, token);
  }

  @override
  Future<Reservation> getReservation(String id, String token) {
    return reservationApiService.getReservation(id, token);
  }
}
