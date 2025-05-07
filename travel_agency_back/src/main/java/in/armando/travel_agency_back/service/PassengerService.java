package in.armando.travel_agency_back.service;

import java.util.List;

import in.armando.travel_agency_back.io.PassengerResponse;

public interface PassengerService {
    PassengerResponse add(PassengerResponse reservation);
    List<PassengerResponse> getAll();
    void delete(String reservationId);
}
