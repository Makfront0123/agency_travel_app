package in.armando.travel_agency_back;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"in"})
public class TravelAgencyBackApplication {
    public static void main(String[] args) {
        SpringApplication.run(TravelAgencyBackApplication.class, args);
    }
}
