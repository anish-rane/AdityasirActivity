package exceptions;

public class BookAlreadyBorrowedException extends Exception {
    public BookAlreadyBorrowedException(String message) {
        throw new RuntimeException(message);
    }
}
