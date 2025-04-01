import java.util.Scanner;
class History{
	Node head;
	class Node{
		String url;
		Node pre;
		Node next;
		Node(String url){
			this.url=url;
			pre=next=null;
		}
	}
	
	void visitPage(String url){
		Node n= new Node(url);
		n.pre=null;
		n.next=head;
		if(head!=null)
		{
			head.pre=n;
		}
		head=n;
		System.out.println("Visted: "+ url);	
	}
		
	void moveForward(){
		if(head==null || head.next==null)
		{
			System.out.print("no History avialable");
		}
		else
		{
			head=head.next;
			System.out.println("Moved forwared to: "+head.url);
		}
	}
		
	void moveBackward(){
		if(head==null||head.pre==null){
			System.out.println("no History avialable");
		}
		else{
			head=head.pre;
			System.out.println("Moved forwared to: "+head.url);
		}
	}
		
	void clearHistory(){
		head=null;
		System.out.println("History Deleted");
	}
		
	void displayCurrentPage(){
		if(head!=null){
			System.out.println("You are currently on: "+head.url);
		}
		else{
			System.out.println("No page currently visited. To preint thr result visit any side first");
		}
	}
	
}
class BrowserHistory{
	public static void main(String[] args){
		Scanner input= new Scanner(System.in);
		History h1= new History();
		
		while(true){
			System.out.println("Select the choice to do:");
			System.out.println("1.Vist the page");
			System.out.println("2.Move Forward page");
			System.out.println("3.Move Backword page");
			System.out.println("4.Clear the History");
			System.out.println("5.Display the current page name.");
			System.out.println("6.Exit");
			
			int choice= input.nextInt();
			input.nextLine(); 
			switch(choice){
				case 1:
					System.out.println();
					System.out.print("Enter the url to visit: ");
					String url=input.nextLine();
					h1.visitPage(url);
					break;
			
				case 2:
					System.out.println();
					h1.moveForward();
					break;
			
				case 3:
					System.out.println();
					h1.moveBackward();
					break;
			
				case 4:
					System.out.println();
					h1.clearHistory();
					break;
			
				case 5:
					System.out.println();
					h1.displayCurrentPage();
					break;
			
				case 6:
					System.out.println();
					System.out.println("Exiting");
					return;
			
				default:
					System.out.println();
					System.out.println("Invalid choice, try again.");
			}
		}
		
	}
}