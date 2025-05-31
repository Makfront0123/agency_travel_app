import 'package:travel_agency_front/features/reservation/data/models/reservation_request_model.dart';
import 'package:travel_agency_front/features/reservation/domain/entities/reservation.dart';
import 'package:travel_agency_front/features/reservation/domain/repository/reservation_repository.dart';

class SubmitReservationUsecase {
  final ReservationRepository repository;

  SubmitReservationUsecase(this.repository);

  Future<Reservation> call(
      ReservationRequestModel request, String token) async {
    return await repository.addReservation(request, token);
  }
}
