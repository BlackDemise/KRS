package repository.impl;

import entity.Token;
import java.util.HashMap;
import java.util.Map;

public class TokenRepository {
    private static TokenRepository instance;
    private Map<String, Token> tokens = new HashMap<>();

    private TokenRepository() {}

    public static synchronized TokenRepository getInstance() {
        if (instance == null) {
            instance = new TokenRepository();
        }
        return instance;
    }

    public void saveToken(Token token) {
        tokens.put(token.getToken(), token);
    }

    public Token findToken(String token) {
        return tokens.get(token);
    }

    public void deleteToken(String token) {
        tokens.remove(token);
    }
}
