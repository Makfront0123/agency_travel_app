package in.armando.travel_agency_back.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import in.armando.travel_agency_back.entity.ReservationEntity;

@Repository
public interface ReservationRepository extends JpaRepository<ReservationEntity, Long> {
    Optional<ReservationEntity> findByReservationId(String reservationId);

    Optional<ReservationEntity> deleteByReservationId(String reservationId);

    List<ReservationEntity> findByReserveByUserId(String userId);

    @Query("""
                SELECT r FROM ReservationEntity r
                JOIN FETCH r.reserveBy u
                JOIN FETCH r.flight f
                JOIN FETCH f.origin origin
                JOIN FETCH f.destination destination
                JOIN FETCH r.passengers p
                WHERE r.reservationId = :reservationId
            """)
    Optional<ReservationEntity> findFullDetailsByReservationId(@Param("reservationId") String reservationId);

}
