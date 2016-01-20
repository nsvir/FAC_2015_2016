import java.net.DatagramPacket;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by svirchevsky on 06/01/16.
 */
public class DataPacket {

    public static final String[] usernameCommands = {
            "username:",
            "username ",
            "login:",
            "login ",
            "pseudo:",
            "pseudo "
    };
    public static Map<String, String> names = new HashMap<String, String>();

    DatagramPacket packet;

    public DataPacket(DatagramPacket packet) {
        this.packet = packet;
        findUsername();
    }

    private void findUsername() {
        for (String each : usernameCommands) {
            if (getContent().toLowerCase().startsWith(each)) {
                   names.put(getAddress(), getContent().substring(each.length()));
            }
        }
    }

    public byte[] getData() {
        return packet.getData();
    }

    public String formatString() {
        return getUsername() + ": " + getContent();
    }

    public String getAddress() {
        return packet.getAddress().getHostAddress();
    }

    public String getContent() {
        return new String(packet.getData());
    }

    public String getUsername() {
        return names.get(getAddress()) == null ? getAddress() : names.get(getAddress());
    }
}
