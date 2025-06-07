package in.armando.travel_agency_back.utils;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Function;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import in.armando.travel_agency_back.service.ActiveSessionService;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

@Component
public class JwpUtil {

    @Value("${jwt.secret}")
    private String secret;
    private ActiveSessionService activeSessionService;

    public String generateToken(UserDetails userDetails) {
        Map<String, Object> claims = new HashMap<>();
        return createToken(claims, userDetails.getUsername());
    }

    private String createToken(Map<String, Object> claims, String subject) {
        long now = System.currentTimeMillis();
        long expirationTime = 1000 * 60 * 60; // 60 minutes

        return Jwts.builder()
                .setClaims(claims)
                .setSubject(subject)
                .setIssuedAt(new Date(now))
                .setExpiration(new Date(now + expirationTime))
                .signWith(SignatureAlgorithm.HS256, secret)
                .compact();
    }

    public String extractUsername(String token) {
        return extractClaim(token, Claims::getSubject);
    }

    public Date extractExpiration(String token) {
        try {
            Date exp = extractClaim(token, Claims::getExpiration);
            System.out.println("Expiración del token: " + exp);
            return exp;
        } catch (Exception e) {
            System.out.println("Error extrayendo expiración: " + e.getMessage());
            return null;
        }
    }

    public <T> T extractClaim(String token, Function<Claims, T> claimsResolver) {
        try {
            final Claims claims = extractAllClaims(token);
            return claimsResolver.apply(claims);
        } catch (ExpiredJwtException e) {
            return claimsResolver.apply(e.getClaims());
        }
    }

    private Claims extractAllClaims(String token) {
        return Jwts.parser()
                .setSigningKey(secret)
                .parseClaimsJws(token)
                .getBody();
    }

    public boolean isTokenExpired(String token) {
        try {
            final Date expiration = extractExpiration(token);
            return expiration == null || expiration.before(new Date());
        } catch (ExpiredJwtException e) {
            System.out.println("Token expirado: " + e.getMessage());
            return true;
        } catch (Exception e) {
            System.out.println("Error verificando expiración del token: " + e.getMessage());
            return true;
        }
    }

    public Boolean validateToken(String token, UserDetails userDetails) {
        try {
            final String username = extractUsername(token);
            return (username.equals(userDetails.getUsername()) && !isTokenExpired(token));
        } catch (Exception e) {
            return false;
        }
    }

    public String extractToken(String email) {
        return activeSessionService.getToken(email);
    }

}
