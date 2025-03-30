package models;

import java.util.*;

public class Member {
	String name;
	int memberID;
	List<Book> borrowerdBooks;
	public Member(String name,int memberID,List<Book> borroerdBooks){
		this.name=name;
		this.memberID=memberID;
		this.borrowerdBooks = new ArrayList<>();
	}
	public String getName() {
		return name;
	}
	public int getMemberID() {
		return memberID;
	}
	
	 public List<Book> getBorrowedBooks() { 
		 return borrowerdBooks; 
	 }
	
	public void borrowBook(Book book) {
		borrowerdBooks.add(book);
        book.setisAvailable(false);
    }
	public void returnBook(Book book) {
		borrowerdBooks.remove(book);
        book.setisAvailable(true);
	}
	public void printBorrowedBooks(){
		ListIterator<Book> iterator = borrowerdBooks.listIterator();
        while (iterator.hasNext()) 
        {
            System.out.println(iterator.next());
        }
	}
	 @Override
	    public String toString() {
	        return name + " (ID: " + memberID + ")";
	    }
}
