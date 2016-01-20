import java.io.IOException;

/**
 * Created by svirchevsky on 14/01/16.
 */
public abstract class NetThread extends Thread {
    NetUtil netUtil;

    public NetThread(String ip, int port) throws IOException {
        netUtil = NetUtil.getNetUtil(ip, port);
    }

    @Override
    public void run() {
        super.run();
        try {
            runWithoutException();
        } catch (Exception exception) {
            exception.printStackTrace();
        }
    }

    protected abstract void runWithoutException() throws Exception;
}
