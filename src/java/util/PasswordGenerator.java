package util;

import java.util.Random;

public class PasswordGenerator {

    public static String generatePassword() {
        String lowerCase = "abcdefghijklmnopqrstuvwxyz";
        String upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String digits = "0123456789";
        String special = "!@#%^&*";
        String allCharacters = lowerCase + upperCase + digits + special;

        Random random = new Random();

        StringBuilder password = new StringBuilder();
        password.append(lowerCase.charAt(random.nextInt(lowerCase.length())));
        password.append(upperCase.charAt(random.nextInt(upperCase.length())));
        password.append(digits.charAt(random.nextInt(digits.length())));
        password.append(special.charAt(random.nextInt(special.length())));

        for (int i = 4; i < 8; i++) {
            password.append(allCharacters.charAt(random.nextInt(allCharacters.length())));
        }

        StringBuilder finalPassword = new StringBuilder();
        while (password.length() > 0) {
            int index = random.nextInt(password.length());
            finalPassword.append(password.charAt(index));
            password.deleteCharAt(index);
        }

        return finalPassword.toString();
    }
}
