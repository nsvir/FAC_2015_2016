import java.io.*;
import java.net.InetAddress;
import java.util.Scanner;

public class Main {

    private static final String multicastAddress = "224.0.0.1";
    private static final int multicastPort = 7654;
    private static final int port = 1500;

    public static void exo3() throws IOException {
        new NetClient(multicastAddress, multicastPort).start();
        new NetServer(multicastAddress, multicastPort).start();
    }

    private static void exo1(String post) throws IOException {
        new NetClient(InetAddress.getByName(post).getHostAddress(), port).start();
        new NetServer(InetAddress.getByName(post).getHostAddress(), port).start();
    }


    public static void main(String[] args) throws IOException {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Exercice numéro (1-3): ");
        if (scanner.hasNext()) {
            switch ((int) scanner.nextLong()) {
                case 1:
                    System.out.print("Nom de la machine à envoyer des messages: ");
                    exo1(scanner.nextLine());
                    break;
                case 2:
                case 3:
                    exo3();
                    break;
            }
        }
    }
}
