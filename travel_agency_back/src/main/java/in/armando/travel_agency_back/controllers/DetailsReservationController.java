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
        try {
            return service.add(entity);
        } catch (Exception e) {
            throw new Error(e);
        }
    }

    @GetMapping("/details")
    public List<DetailsReservationResponse> getAllDetails() {
        try {
            return service.getAll();
        } catch (Exception e) {
            throw new Error(e);
        }
    }

    @DeleteMapping("/details/{reservationId}")
    public void deleteDetails(@PathVariable String reservationId) {
        try {
            service.delete(reservationId);
        } catch (Exception e) {
            throw new Error(e);
        }
    }

}
