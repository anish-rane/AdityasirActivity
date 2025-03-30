package models;

public class Book {
	public String title;
	public String author;
	public String ISBN;
	public boolean isAvailable;
	
	public Book(String title,String author,String ISBN,boolean isAvailable){
		this.title=title;
		this.author=author;
		this.ISBN=ISBN;
		this.isAvailable=isAvailable;
	}
	String getTitle() { 
		return title; 
	}
	void setTitle(String title) {
		this.title=title;
	}
	String getauthor() { 
		return author; 
	}
	void setauthor(String author) {
		this.author=author;
	}
	String getISBN() { 
		return title; 
	}
	void setISBN(String ISBN) {
		this.ISBN=ISBN;
	}
	boolean getisAvailable() { 
		return isAvailable; 
	}
	void setisAvailable(boolean isAvailable) {
		this.isAvailable=isAvailable;
	}
	public boolean isAvailable() { 
		return isAvailable; 
	}
	@Override 
	public String toString() {
		return title + " by " + author + " (ISBN: " + ISBN + ")";
	}
}
