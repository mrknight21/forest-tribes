package Utility;

import javax.sql.rowset.serial.SerialBlob;
import java.sql.Blob;
import java.sql.SQLException;

public class BlobConverter {

    public static byte[] getByteArray(Blob blob) {
        byte[] bytes;

        try {
            SerialBlob serialBlob = new SerialBlob(blob);
            bytes = serialBlob.getBytes(1, (int) blob.length());
            return bytes;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static Blob getBlob(byte[] bytes) {
        Blob blob = null;

        try {
            blob = new SerialBlob(bytes);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return blob;
    }
}
