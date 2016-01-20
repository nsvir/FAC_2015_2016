import java.io.IOException;
import java.net.*;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by svirchevsky on 06/01/16.
 */
public class NetUtil {

    private static final int DEFAULT_BUFF_SIZE = 1024;
    static Map<String, NetUtil> netUtils = new HashMap<String, NetUtil>();
    DatagramSocket socket;
    InetAddress address;
    boolean inGroup;
    int port;

    private NetUtil(String address, int port) throws IOException {
        this.address = InetAddress.getByName(address);
        if (address.startsWith("224.")) {
            //Is a multicast situation
            MulticastSocket socket = new MulticastSocket(port);
            socket.joinGroup(this.address);
            this.socket = socket;
            inGroup = true;
        } else {
            //Is a normal situation
            this.socket = new DatagramSocket(port);
        }
        this.port = port;
    }

    //This function is used to not connect to the same address twice
    public static NetUtil getNetUtil(String address, int port) throws IOException {
        String key = address + ":" + port;
        NetUtil content = netUtils.get(key);
        if (content == null) {
            //Cr
            content = new NetUtil(address, port);
            netUtils.put(key, content);
        }
        return content;
    }

    public void send(String message) throws IOException {
        send(new DatagramPacket(message.getBytes(), message.length(), this.address, this.port));
    }

    public void send(DatagramPacket packet) throws IOException {
        this.socket.send(packet);
    }

    public String receiveString() throws IOException {
        return new String(receive().getData());
    }

    public DataPacket receive() throws IOException {
        DatagramPacket packet = new DatagramPacket(new byte[DEFAULT_BUFF_SIZE], DEFAULT_BUFF_SIZE);
        this.socket.receive(packet);
        return new DataPacket(packet);
    }

    public void disconnect() {
        try {
            if (inGroup) {
                ((MulticastSocket) socket).leaveGroup(this.address);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
