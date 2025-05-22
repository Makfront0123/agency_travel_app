package in.armando.travel_agency_back.controllers;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import in.armando.travel_agency_back.io.AirportRequest;
import in.armando.travel_agency_back.io.AirportResponse;
import in.armando.travel_agency_back.service.AirportService;
import lombok.RequiredArgsConstructor;

@RestController

@RequiredArgsConstructor
public class AirportController {
    private final AirportService service;

    @PostMapping("/admin/airport")
    @ResponseStatus(HttpStatus.CREATED)
    public AirportResponse addAirport(@RequestBody AirportRequest request) {
        try {
            return service.add(request);
        } catch (Exception e) {
            throw new Error(e);
        }
    }

    @GetMapping("/airport")
    public List<AirportResponse> getAllAirports() {
        try {
            return service.getAll();
        } catch (Exception e) {
            throw new Error(e);
        }
    }

    @DeleteMapping("/admin/airport/{airportId}")
    public void deleteAirport(@PathVariable String airportId) {
        try {
            service.delete(airportId);
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
        }
    }

    @GetMapping("/airport/with-prices")
    public ResponseEntity<List<AirportResponse>> getAirportsWithPrices() {
        List<AirportResponse> airports = service.getAirportsWithCheapestFlight()
        ;
        return ResponseEntity.ok(airports);
    }
}
