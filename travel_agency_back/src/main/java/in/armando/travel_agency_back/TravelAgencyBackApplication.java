package in.armando.travel_agency_back;

import java.util.TimeZone;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class TravelAgencyBackApplication {

    public static void main(String[] args) {
        // Establece la zona horaria predeterminada a Colombia
        TimeZone.setDefault(TimeZone.getTimeZone("America/Bogota"));
        SpringApplication.run(TravelAgencyBackApplication.class, args);
    }
}
