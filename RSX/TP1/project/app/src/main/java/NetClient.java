import java.io.IOException;
import java.util.Scanner;

/**
 * Created by svirchevsky on 14/01/16.
 */
public class NetClient extends NetThread {

    Scanner scanner = new Scanner(System.in);

    public NetClient(String ip, int port) throws IOException {
        super(ip, port);
    }

    @Override
    protected void runWithoutException() throws Exception {
        while (scanner.hasNext()) {
            netUtil.send(scanner.nextLine());
        }
    }
}
