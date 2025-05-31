import 'package:travel_agency_front/features/reservation/domain/entities/reservation.dart';
import 'package:travel_agency_front/features/reservation/domain/repository/reservation_repository.dart';

class GetReservationUseCase {
  final ReservationRepository repository;

  GetReservationUseCase(this.repository);

  Future<Reservation> execute(String id, String token) {
    return repository.getReservation(id, token);
  }
}
