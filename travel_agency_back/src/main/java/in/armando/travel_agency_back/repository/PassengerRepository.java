package in.armando.travel_agency_back.repository;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import in.armando.travel_agency_back.entity.PassengerEntity;

@Repository
public interface PassengerRepository extends JpaRepository<PassengerEntity, Long> {
    Optional<PassengerEntity> findByPassengerId(String passengerId);
}
