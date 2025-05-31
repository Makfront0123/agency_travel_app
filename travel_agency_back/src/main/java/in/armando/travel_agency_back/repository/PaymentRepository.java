package in.armando.travel_agency_back.repository;

import in.armando.travel_agency_back.entity.PaymentEntity;
 
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PaymentRepository extends JpaRepository<PaymentEntity, Long> {

    Optional<PaymentEntity> findByPaymentId(String paymentId);

    @Query("SELECT p FROM PaymentEntity p JOIN ReservationEntity r ON p.reservationId = r.reservationId WHERE r.reserveBy.id = :userId")
List<PaymentEntity> findPaymentsByUserId(@Param("userId") Long userId);

}
