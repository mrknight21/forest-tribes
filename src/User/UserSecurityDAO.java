package User;

import Utility.Passwords;
import Utility.AbstractDB;
import static Utility.BlobManipulator.getBlob;
import static Utility.BlobManipulator.getByteArray;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserSecurityDAO {

    public static List<UserSecurity> getAllUsers(AbstractDB db) {

        List<UserSecurity> users = new ArrayList<>();

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("SELECT * FROM web_lab_19")) {
                try (ResultSet r = p.executeQuery()) {
                    while (r.next()) {
                        users.add(userFromResultSet(r));
                    }
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return users;
    }

    public static UserSecurity getUser(AbstractDB db, String username) {

        UserSecurity user = null;

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("SELECT * FROM web_lab_19 WHERE username = ?")) {
                p.setString(1, username);

                try (ResultSet r = p.executeQuery()) {
                    while (r.next()) {
                        user = userFromResultSet(r);
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            user = null;
        }
        return user;
    }

    public static boolean insertUser(AbstractDB db, UserSecurity newUser) {

        boolean status;

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("INSERT INTO web_lab_19 (username, salt, iterations, hash) VALUE (?, ?, ?, ?)")) {

                byte[] salt = newUser.getSalt();
                Blob saltBlob = getBlob(salt);

                byte[] hash = newUser.getHash();
                Blob hashBlob = getBlob(hash);

                p.setString(1, newUser.getUsername());
                p.setBlob(2, saltBlob);
                p.setInt(3, newUser.getIterations());
                p.setBlob(4, hashBlob);

                p.executeUpdate();
                status = true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            status = false;
        }
        return status;
    }

    public static boolean updatePassword(AbstractDB db, String username, String password) {

        boolean status;

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("UPDATE web_lab_19 SET salt = ?, iterations = ?, hash = ? WHERE username = ?")) {

                char[] passwordArray = password.toCharArray();

                byte[] salt = Passwords.getNextSalt();
                Blob saltBlob = getBlob(salt);

                int iterations = 50000;

                byte[] hash = Passwords.hash(passwordArray, salt, iterations);
                Blob hashBlob = getBlob(hash);

                p.setBlob(1, saltBlob);
                p.setInt(2, iterations);
                p.setBlob(3, hashBlob);
                p.setString(4, username);

                p.executeUpdate();
                status = true;
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            status = false;
        }
        return status;
    }

    private static UserSecurity userFromResultSet(ResultSet r) throws SQLException {
        Blob saltBlob = r.getBlob("salt");
        byte[] salt = getByteArray(saltBlob);

        Blob hashBlob = r.getBlob("hash");
        byte[] hash = getByteArray(hashBlob);

        return new UserSecurity(
                r.getString("username"),
                salt,
                r.getInt("iterations"),
                hash);
    }

}
