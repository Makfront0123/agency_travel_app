package in.armando.travel_agency_back.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import in.armando.travel_agency_back.entity.AirportEntity;

@Repository
public interface AirportRepository extends JpaRepository<AirportEntity, Long> {
    Optional<AirportEntity> findByAirportId(String airportId);
    Optional<AirportEntity> deleteByAirportId(String airportId);
 

     @Query(value = """
        SELECT 
            a.id AS id,
            a.name AS name,
            a.city AS city,
            a.country AS country,
            a.image AS image,
            (SELECT MIN(f.price) FROM flight f WHERE f.destination_id = a.id) AS cheapestFlightPrice
        FROM airport a
        """, nativeQuery = true)
    List<Object[]> findAirportsWithCheapestFlightRaw();
}
