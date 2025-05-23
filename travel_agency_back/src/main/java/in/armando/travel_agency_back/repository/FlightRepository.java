package in.armando.travel_agency_back.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import in.armando.travel_agency_back.entity.FlightEntity;

@Repository
public interface FlightRepository extends JpaRepository<FlightEntity, Long> {

    Optional<FlightEntity> findByFlightId(String flightId);

    List<FlightEntity> findByOrigin_Id(Long originId);

    List<FlightEntity> findByDestination_Id(Long destinationId);

    @Query("SELECT f FROM FlightEntity f " +
            "WHERE CONCAT(f.origin.city, ', ', f.origin.country) = :from " +
            "AND CONCAT(f.destination.city, ', ', f.destination.country) = :to")
    List<FlightEntity> findByOriginAndDestination(@Param("from") String from, @Param("to") String to);

    @Query("SELECT DISTINCT CONCAT(a.city, ', ', a.country) FROM FlightEntity f JOIN f.origin a")
    List<String> findDistinctOriginCities();

    @Query("SELECT DISTINCT CONCAT(a.city, ', ', a.country) FROM FlightEntity f JOIN f.destination a")
    List<String> findDistinctDestinationCities();

}
