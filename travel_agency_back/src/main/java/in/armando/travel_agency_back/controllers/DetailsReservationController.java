package in.armando.travel_agency_back.controllers;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import in.armando.travel_agency_back.io.DetailsReservationRequest;
import in.armando.travel_agency_back.io.DetailsReservationResponse;
import in.armando.travel_agency_back.service.DetailsReservationService;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class DetailsReservationController {
    private final DetailsReservationService service;

    @PostMapping("/details")
    @ResponseStatus(HttpStatus.CREATED)
    public DetailsReservationResponse addDetails(@RequestBody DetailsReservationRequest entity) {
        return service.add(entity);
    }

    @GetMapping("/details")
    public List<DetailsReservationResponse> getAllDetails() {
        return service.getAll();
    }

    @DeleteMapping("/details/{reservationId}")
    public void deleteDetails(@PathVariable String reservationId) {
        service.delete(reservationId);
    }

}
