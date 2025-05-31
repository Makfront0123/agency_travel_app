package in.armando.travel_agency_back.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
 
import java.time.LocalDateTime;

@Entity
@Table(name = "user")
@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(unique = true)
    private String userId;
    private String name;
    private String lastName;
    private String email;
    private String password;
    private String role;
    private boolean verified;
    @CreationTimestamp
    @Column(updatable = false)
    private LocalDateTime createdAt;
    @UpdateTimestamp
    @Column(updatable = false)
    private LocalDateTime updatedAt;

    @Column(nullable = true)
    private LocalDateTime otpExpiration;  // Fecha de expiración del OTP
    
    @Column(nullable = true)
    private String otp; 
 
}
