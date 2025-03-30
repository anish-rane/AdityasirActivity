package services;

import models.*;
import exceptions.*;
public class LibraryService {
	private Library library;

    public LibraryService(Library library) {
        this.library = library;
    }

    public void borrowBook(int memberID, String ISBN) throws MemberNotFoundException, BookNotAvailableException, BookAlreadyBorrowedException {
        Member member = library.getMembers().stream().filter(m -> m.getMemberID() == memberID).findFirst().orElse(null);
        if (member == null) throw new MemberNotFoundException("Member not found!");

        Book book = library.searchBook(ISBN);
        if (book == null || !book.isAvailable()) throw new BookNotAvailableException("Book is not available!");

        if (member.getBorrowedBooks().contains(book)) throw new BookAlreadyBorrowedException("You have already borrowed this book!");

        member.borrowBook(book);
        System.out.println("Book borrowed successfully: " + book);
    }

    public void returnBook(int memberID, String ISBN) throws MemberNotFoundException {
        Member member = library.getMembers().stream().filter(m -> m.getMemberID() == memberID).findFirst().orElse(null);
        if (member == null) throw new MemberNotFoundException("Member not found!");

        Book book = library.searchBook(ISBN);
        if (book == null || book.isAvailable() || !member.getBorrowedBooks().contains(book)) {
            System.out.println("You did not borrow this book.");
            return;
        }

        member.returnBook(book);
        System.out.println("Book returned successfully: " + book);
    }

    public void printStatistics() {
        System.out.println("Total Members: " + library.getTotalMembers());
        System.out.println("Total Books: " + library.getTotalBooks());
        long borrowedCount = library.getMembers().stream().flatMap(m -> m.getBorrowedBooks().stream()).count();
        System.out.println("Currently Borrowed Books: " + borrowedCount);
    }
}
