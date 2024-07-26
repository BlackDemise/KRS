package constant;

public interface IGoogleConnection {

    String GOOGLE_CLIENT_ID = "527549594418-9m2nkli21eoq6biph6c5lo0fnkdqaiok.apps.googleusercontent.com";

    String GOOGLE_CLIENT_SECRET = "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";

    String GOOGLE_REDIRECT_URI = "http://localhost:9999/google-login";

    String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";

    String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";

    String GOOGLE_GRANT_TYPE = "authorization_code";
}
