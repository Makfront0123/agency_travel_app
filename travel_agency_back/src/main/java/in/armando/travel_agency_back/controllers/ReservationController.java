package in.armando.travel_agency_back.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import in.armando.travel_agency_back.io.ReservationRequest;
import in.armando.travel_agency_back.io.ReservationResponse;

import in.armando.travel_agency_back.service.ReservationService;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class ReservationController {
    private final ReservationService service;

    @PostMapping("/reservation")
    @ResponseStatus(HttpStatus.CREATED)
    public ReservationResponse addReservation(@RequestBody ReservationRequest entity) {
        try {
            return service.add(entity);
        } catch (Exception e) {
            throw new Error(e);
        }
    }

    @GetMapping("admin/reservation")
    @ResponseStatus(HttpStatus.OK)
    public Iterable<ReservationResponse> getAllReservations() {
        try {
            return service.getAll();
        } catch (Exception e) {
            throw new Error(e);
        }
    }

    @DeleteMapping("admin/reservation/{id}")
    public void deleteReservation(@PathVariable String id) {
        try {
            service.delete(id);
        } catch (Exception e) {
            throw new Error(e);
        }
    }

}
