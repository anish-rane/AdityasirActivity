package exceptions;

public class MemberNotFoundException extends Exception {
    public MemberNotFoundException(String message) {
        throw new RuntimeException(message);
    }
}
