class  SinglyLinkedList{
	Node start; 
	static class Node{
		String name;
		long num;
		Node next;
		
		Node(String name,long num){
			this.name=name;
			this.num=num;
			next=null;
		}
	}
	
	void addContact(String name, long num){
		Node new_node = new Node(name,num);
		if(start == null)
		{
			start = new Node(name,num);// first node in the list
			System.out.println("Contact added: " + name + ", " + num);
			return;
		}
		Node n = start;
		while(n.next != null)
		{
			n=n.next;
		}
		System.out.println("Contact added: " + name + ", " + num);
		n.next = new_node;
		return;
	}
	
	void removeContact(String name){
		Node temp = start, prev = null;
		if(temp != null && temp.name == name){
			start = temp.next;//Deletion at begining: First node deleted
			System.out.println("Contact removed: " + name );
			return;	
		}
			
		while( temp != null && temp.name != name)
		{
			prev = temp;
			temp = temp.next;
		}
		if(temp == null)
			return;
		prev.next = temp.next;
	}
	
	boolean searchContact(String name){
		Node temp = start;
		while(temp != null)
		{
			if(temp.name == name)// if found 
				return true;
			temp = temp.next;
		}
		return false;// if not found 
	}
	void displayContacts(){
		System.out.println("Contact list: ");
		if (start == null) 
		{
            System.out.println("Contact list is empty.");// if linkilist is null 
            return;
        }
        Node n = start;
        while (n != null) 
		{
            System.out.println(n.name + " (" + n.num + ") ");// printing the linklist data 
            n = n.next; // going to next value 
        }
        System.out.println("null");
	}
	
	public static void main(String[] args){
		SinglyLinkedList list = new SinglyLinkedList();
		list.addContact("Aditya Kansana", 9425760166l);
		list.addContact("Anish Rane", 8108997893l);
		System.out.println();
		list.displayContacts();
		System.out.println();
		System.out.println("is Aditya Kansana in my contact list ?");
		System.out.print(list.searchContact("Aditya Kansana"));
		System.out.println();
		System.out.println();
		System.out.println("removing Aditya Kansana contact: ");
		list.removeContact("Aditya Kansana");
		System.out.println();
		list.displayContacts();
		System.out.println();
		list.addContact("Aditya Kansana", 9425760166l);
		System.out.println();
		list.displayContacts();
		
	}
}