package in.armando.travel_agency_back.service;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Service;

@Service
public class ActiveSessionService {

    private final Map<String, String> activeSessions = new ConcurrentHashMap<>();

    public void saveSession(String email, String token) {
        activeSessions.put(email, token);
    }

    public void createSession(String email, String token) {
        activeSessions.put(email, token);
    }
    public String getToken(String email) {
        return activeSessions.get(email);
    }

    public void removeSession(String email) {
        activeSessions.remove(email);
    }

    public boolean hasSession(String email) {
        return activeSessions.containsKey(email);
    }
}
