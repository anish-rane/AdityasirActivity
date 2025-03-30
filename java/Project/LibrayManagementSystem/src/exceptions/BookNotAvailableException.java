package exceptions;

public class BookNotAvailableException extends Exception {
    public BookNotAvailableException(String message) {
        throw new RuntimeException(message);
    }
}
