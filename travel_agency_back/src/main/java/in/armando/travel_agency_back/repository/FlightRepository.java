package in.armando.travel_agency_back.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import in.armando.travel_agency_back.entity.FlightEntity;


@Repository
public interface FlightRepository extends JpaRepository<FlightEntity, Long> {
    Optional<FlightEntity> findByFlightId(String flightId);
    Optional<FlightEntity> deleteByFlightId(String flightId);

    List<FlightEntity> findByOrigin_Id(Long originId);
    List<FlightEntity> findByDestination_Id(Long destinationId);
}

