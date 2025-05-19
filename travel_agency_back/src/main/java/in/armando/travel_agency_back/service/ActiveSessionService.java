package in.armando.travel_agency_back.service;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Service;
@Service
public class ActiveSessionService {
    private final Map<String, String> activeSessions = new ConcurrentHashMap<>();
    
    public boolean hasActiveSession(String email) {
        return activeSessions.containsKey(email);
    }

    public void createSession(String email, String token) {
        activeSessions.put(email, token);
    }

    public void removeSession(String email) {
        activeSessions.remove(email);
    }

    public String getToken(String email) {
        return activeSessions.get(email);
    }

    public boolean isTokenActive(String token) {
        return activeSessions.containsValue(token);
    }
}
