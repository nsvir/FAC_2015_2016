import java.io.IOException;

/**
 * Created by svirchevsky on 14/01/16.
 */
public class NetServer extends NetThread {

    public NetServer(String ip, int port) throws IOException {
        super(ip, port);
    }

    @Override
    protected void runWithoutException() throws Exception {
        while (true) {
            System.out.println(netUtil.receive().formatString());
        }
    }
}
