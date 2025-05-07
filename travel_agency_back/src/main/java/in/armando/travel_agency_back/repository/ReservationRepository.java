package in.armando.travel_agency_back.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import in.armando.travel_agency_back.entity.ReservationEntity;

@Repository
public interface ReservationRepository extends JpaRepository<ReservationEntity, Long> {
    Optional<ReservationEntity> findByReservationId(String reservationId);

    Optional<ReservationEntity> deleteByReservationId(String reservationId);

    List<ReservationEntity> findByUserId(Long userId);
}
