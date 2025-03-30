package models;
import java.util.*;
public class Library {
	Map<String,Book>books;
	Set<Member>members;
	
	public Library(){
		books=new HashMap<>();
		members= new HashSet<>();
	}
	
	public void addBook(Book book) {
		books.put(book.getISBN(), book);
		System.out.println("Book added: " + book);
	}
	
	public void addMember(Member member) {
		members.add(member);
        System.out.println("Member added: " + member);
	}
	
	public void displayBooks(Book book) {
		Iterator<Book> iterator = books.values().iterator();
        while (iterator.hasNext()) {
            book = iterator.next();
            if (book.isAvailable()) {
                System.out.println(book);
            }
        }
	}
	public Book searchBook(String ISBN) {
		return books.getOrDefault(ISBN, null);
	}
	
	public int getTotalMembers() {
        return members.size();
    }

    public int getTotalBooks() {
        return books.size();
    }

    public Set<Member> getMembers() {
        return members;
    }
}
