package in.armando.travel_agency_back.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import in.armando.travel_agency_back.entity.DetailsReservationEntity;


@Repository
public interface DetailsRepository extends JpaRepository<DetailsReservationEntity, Long> {
    Optional<DetailsReservationEntity> findByDetailsId(String detailsId);
}
