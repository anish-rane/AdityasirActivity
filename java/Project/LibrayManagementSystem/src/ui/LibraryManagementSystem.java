package ui;

import models.*;
import services.*;
import exceptions.*;

import java.util.Scanner;

public class LibraryManagementSystem {
	public static void main(String[] args) {
        Library library = new Library();
        LibraryService service = new LibraryService(library);
        Scanner scanner = new Scanner(System.in);

        while (true) {
            System.out.println("\nLibrary Management System");
            System.out.println("1. Add Book");
            System.out.println("2. Add Member");
            System.out.println("3. Display Books");
            System.out.println("4. Borrow Book");
            System.out.println("5. Return Book");
            System.out.println("6. Display Statistics");
            System.out.println("7. Exit");
            System.out.print("Enter choice: ");

            int choice = scanner.nextInt();
            scanner.nextLine();

            try {
                switch (choice) {
                    case 1:
                        System.out.print("Title: ");
                        String title = scanner.nextLine();
                        System.out.print("Author: ");
                        String author = scanner.nextLine();
                        System.out.print("ISBN: ");
                        String isbn = scanner.nextLine();
                        library.addBook(new Book(title, author, isbn, false));
                        break;

                    case 2:
                        System.out.print("Name: ");
                        String name = scanner.nextLine();
                        System.out.print("Member ID: ");
                        int memberId = scanner.nextInt();
                        library.addMember(new Member(name, memberId, null));
                        break;

                    case 3:
                        library.displayBooks(null);
                        break;

                    case 4:
                        System.out.print("Member ID: ");
                        int memID = scanner.nextInt();
                        System.out.print("ISBN: ");
                        String bookISBN = scanner.next();
                        service.borrowBook(memID, bookISBN);
                        break;

                    case 5:
                        System.out.print("Member ID: ");
                        int memIDReturn = scanner.nextInt();
                        System.out.print("ISBN: ");
                        String bookISBNReturn = scanner.next();
                        service.returnBook(memIDReturn, bookISBNReturn);
                        break;

                    case 6:
                        service.printStatistics();
                        break;

                    case 7:
                        System.exit(0);
                }
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
    }
}
