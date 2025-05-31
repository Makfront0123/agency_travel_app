package in.armando.travel_agency_back.service.impl;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import in.armando.travel_agency_back.entity.AirportEntity;
import in.armando.travel_agency_back.entity.FlightEntity;
import in.armando.travel_agency_back.io.FlightOptionsResponse;
import in.armando.travel_agency_back.io.FlightRequest;
import in.armando.travel_agency_back.io.FlightResponse;
import in.armando.travel_agency_back.repository.AirportRepository;
import in.armando.travel_agency_back.repository.FlightRepository;
import in.armando.travel_agency_back.service.FlightService;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FlightServiceImpl implements FlightService {
        private final FlightRepository repository;
        private final AirportRepository airportRepository;

        @Override
        public FlightResponse add(FlightRequest request) {
                FlightEntity newFlight = convertToEntity(request);
                newFlight = repository.save(newFlight);
                return convertToResponse(newFlight);
        }

        @Override
        public List<FlightResponse> getAll() {
                return repository.findAll()
                                .stream()
                                .map(this::convertToResponse)
                                .collect(Collectors.toList());
        }

        @Override
        public void delete(String flightId) {
                FlightEntity existingFlight = repository.findByFlightId(flightId).orElseThrow(
                                () -> new RuntimeException("Flight not found" + flightId));
                repository.delete(existingFlight);
        }

        public FlightEntity convertToEntity(FlightRequest request) {

                AirportEntity destination = airportRepository.findById(request.getDestinationId())
                                .orElseThrow(() -> new RuntimeException("Destination airport not found"));
                AirportEntity origin = airportRepository.findById(request.getOriginId())
                                .orElseThrow(() -> new RuntimeException("Origin airport not found"));

                return FlightEntity.builder()
                                .flightId(UUID.randomUUID().toString())
                                .duration(request.getDuration())
                                .airline(request.getAirline())
                                .flightNumber(request.getFlightNumber())
                                .seatsAvailable(request.getSeatsAvailable())
                                .destination(destination)
                                .origin(origin)
                                .dateInitial(request.getDateInitial())
                                .dateFinal(request.getDateFinal())
                                .price(request.getPrice())
                                .build();
        }

        public FlightResponse convertToResponse(FlightEntity entity) {
                return FlightResponse.builder()
                                .id(entity.getId())
                                .flightId(entity.getFlightId())
                                .duration(entity.getDuration())
                                .airline(entity.getAirline())
                                .flightNumber(entity.getFlightNumber())
                                .seatsAvailable(entity.getSeatsAvailable())
                                .price(entity.getPrice())
                                .destinationId(entity.getDestination().getCity()+ ", " + entity.getDestination().getCountry())
                                .originId(entity.getOrigin().getCity()+ ", " + entity.getOrigin().getCountry())
                                .dateInitial(entity.getDateInitial())
                                .dateFinal(entity.getDateFinal())
                                .createdAt(entity.getCreatedAt())
                                .updatedAt(entity.getUpdatedAt())
                                .build();
        }

        @Override
        public List<FlightResponse> searchFlights(String from, String to) {
                return repository.findByOriginAndDestination(from, to)
                                .stream()
                                .map(this::convertToResponse)
                                .collect(Collectors.toList());
        }

        @Override
        public FlightOptionsResponse getFlightOptions() {
                List<String> origins = repository.findDistinctOriginCities();
                List<String> destinations = repository.findDistinctDestinationCities();
                return new FlightOptionsResponse(origins, destinations);
        }

}
