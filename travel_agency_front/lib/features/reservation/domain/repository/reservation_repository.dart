import 'package:travel_agency_front/features/reservation/data/models/reservation_request_model.dart';
import 'package:travel_agency_front/features/reservation/domain/entities/reservation.dart';

abstract class ReservationRepository {
  Future<Reservation> addReservation(
      ReservationRequestModel request, String token);

  Future<Reservation> getReservation(String id, String token);
}
