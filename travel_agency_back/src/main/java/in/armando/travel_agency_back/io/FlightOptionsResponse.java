package in.armando.travel_agency_back.io;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class FlightOptionsResponse {
    private List<String> origins;
    private List<String> destinations;
}
