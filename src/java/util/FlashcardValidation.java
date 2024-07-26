/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

public class FlashcardValidation {

    public static boolean isValidName(String name) {
        return name != null && !name.isEmpty() && name.length() < 100;
    }

    public static boolean isValidDescription(String des) {
        return des != null && !des.isEmpty() && des.length() < 1000;
    }

    public static boolean isValidStatus(String status) {
        return status != null && !status.isEmpty() && status.equals("Show") || status.equals("Hidden");
    }

    public static boolean isValidTerm(String term) {
        return term != null && !term.isEmpty() && term.length() < 1000;
    }

    public static boolean isValidDefinition(String definition) {
        return definition != null && !definition.isEmpty() && definition.length() < 1000;
    }
}
