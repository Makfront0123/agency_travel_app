package in.armando.travel_agency_back.entity;

import java.time.LocalDateTime;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
 
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "flight")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class FlightEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true)
    private String flightId;

    private String duration;
    private String airline;


    @ManyToOne
    @JoinColumn(name = "destination_id", referencedColumnName = "id")  
    private AirportEntity destination;
    
 
    @ManyToOne
    @JoinColumn(name = "origin_id", referencedColumnName = "id")  
    private AirportEntity origin;
    private LocalDateTime dateInitial;
    private LocalDateTime dateFinal;

    private Integer flightNumber;
    private Integer seatsAvailable;
    private double price;

    @CreationTimestamp
    @Column(updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(updatable = false)
    private LocalDateTime updatedAt;
}
