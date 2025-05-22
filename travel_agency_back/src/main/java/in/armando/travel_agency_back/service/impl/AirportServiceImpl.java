
package in.armando.travel_agency_back.service.impl;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import in.armando.travel_agency_back.entity.AirportEntity;
import in.armando.travel_agency_back.io.AirportRequest;
import in.armando.travel_agency_back.io.AirportResponse;
import in.armando.travel_agency_back.repository.AirportRepository;
import in.armando.travel_agency_back.service.AirportService;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AirportServiceImpl implements AirportService {
    private final AirportRepository repository;

    @Override
    public AirportResponse add(AirportRequest request) {
        AirportEntity newAirport = convertToEntity(request);
        newAirport = repository.save(newAirport);
        return convertToResponse(newAirport);
    }

    @Override
    public List<AirportResponse> getAll() {
        return repository.findAll()
                .stream()
                .map(airportEntity -> convertToResponse(airportEntity))
                .collect(Collectors.toList());
    }

    private AirportEntity convertToEntity(AirportRequest request) {
        return AirportEntity.builder()
                .airportId(UUID.randomUUID().toString())
                .name(request.getName())
                .code(request.getCode())
                .city(request.getCity())
                .country(request.getCountry())
                .image(request.getImage())
                .build();
    }

    private AirportResponse convertToResponse(AirportEntity entity) {
        return AirportResponse.builder()
                .airportId(entity.getAirportId())
                .name(entity.getName())
                .code(entity.getCode())
                .city(entity.getCity())
                .country(entity.getCountry())
                .image(entity.getImage())
                .createdAt(entity.getCreatedAt())
                .updatedAt(entity.getUpdatedAt())
                .build();
    }

    @Override
    public void delete(String airportId) {
        AirportEntity existingAirport = repository.findByAirportId(airportId).orElseThrow(
                () -> new RuntimeException("Airport not found" + airportId));
        repository.delete(existingAirport);
    }

    @Override
    public List<AirportResponse> getAirportsWithCheapestFlight() {
        List<Object[]> results = repository.findAirportsWithCheapestFlightRaw();

        return results.stream()
                .map((Object[] r) -> AirportResponse.builder()
                        .airportId(String.valueOf(r[0])) 
                        .name((String) r[1])
                        .city((String) r[2])
                        .country((String) r[3])
                        .image((String) r[4])
                        .cheapestFlightPrice(r[5] != null ? ((Number) r[5]).doubleValue() : null)
                        .build())
                .collect(Collectors.toList());
    }

}
