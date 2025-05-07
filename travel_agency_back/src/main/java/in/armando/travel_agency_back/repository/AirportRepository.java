package in.armando.travel_agency_back.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import in.armando.travel_agency_back.entity.AirportEntity;

@Repository
public interface AirportRepository extends JpaRepository<AirportEntity, Long> {
    Optional<AirportEntity> findByAirportId(String airportId);
    Optional<AirportEntity> deleteByAirportId(String airportId);
}
