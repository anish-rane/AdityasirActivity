import java.util.Scanner;

class CircularLinkList {
    Node Start;

    class Node {
        String title;
        String artist;
        Node pre, next;

        Node(String title, String artist) {
            this.title = title;
            this.artist = artist;
            pre = next = null;
        }
    }

    void addSong(String title, String artist) {
        Node n = new Node(title, artist);
        if (Start == null) {
            Start = n;
            Start.next = Start;
            Start.pre = Start;
        } else {
            Node temp = Start;
            while (temp.next != Start) {
                temp = temp.next;
            }
            temp.next = n;
            n.pre = temp;
            n.next = Start;
            Start.pre = n;
        }
        System.out.println("Song added: " + title + " by " + artist);
    }

    void removeSong(String title) {
        if (Start == null) {
            System.out.println("Playlist is empty.");
            return;
        }

        Node temp = Start;

        do {
            if (temp.title.equals(title)) {
                if (temp == Start && temp.next == Start) { 
                    Start = null;
                } else if (temp == Start) { 
                    Start.pre.next = Start.next;
                    Start.next.pre = Start.pre;
                    Start = Start.next;
                } else { // Removing a song in between
                    temp.pre.next = temp.next;
                    temp.next.pre = temp.pre;
                }
                System.out.println("Song removed: " + title);
                return;
            }
            temp = temp.next;
        } while (temp != Start);

        System.out.println("Song not found: " + title);
    }

    void playNext() {
        if (Start == null) {
            System.out.println("Playlist is empty.");
        } else {
            Start = Start.next;
            displayCurrentSong();
        }
    }

    void playPrevious() {
        if (Start == null) {
            System.out.println("Playlist is empty.");
        } else {
            Start = Start.pre;
            displayCurrentSong();
        }
    }

    void displayCurrentSong() {
        if (Start == null) {
            System.out.println("No song is playing.");
        } else {
            System.out.println("Now playing: " + Start.title + " by " + Start.artist);
        }
    }
}

public class CircularLinkListDemo {
    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        CircularLinkList playlist = new CircularLinkList();

        while (true) {
            System.out.println("\n1. Add a Song");
            System.out.println("2. Remove a Song");
            System.out.println("3. Play Next Song");
            System.out.println("4. Play Previous Song");
            System.out.println("5. Display Current Song");
            System.out.println("6. Exit");
            System.out.print("Enter your choice: ");

            int choice = input.nextInt();
            input.nextLine(); 

            switch (choice) {
                case 1:
                    System.out.print("Enter Title: ");
                    String title = input.nextLine();
                    System.out.print("Enter the Artist: ");
                    String artist = input.nextLine();
                    playlist.addSong(title, artist);
                    break;

                case 2:
                    System.out.print("Enter Title of the song to remove: ");
                    String removeTitle = input.nextLine();
                    playlist.removeSong(removeTitle);
                    break;

                case 3:
                    playlist.playNext();
                    break;

                case 4:
                    playlist.playPrevious();
                    break;

                case 5:
                    playlist.displayCurrentSong();
                    break;

                case 6:
                    System.out.println("Exiting...");
                    input.close();
                    return;

                default:
                    System.out.println("Enter a valid choice!");
            }
        }
    }
}
