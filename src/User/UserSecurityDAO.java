package User;

import Utility.Passwords;
import Utility.AbstractDB;
import static Utility.BlobConverter.getBlob;
import static Utility.BlobConverter.getByteArray;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserSecurityDAO {

    // Method to return all UserSecurity objects as an ArrayList from the database.
    public static List<UserSecurity> getAllUsers(AbstractDB db) {

        List<UserSecurity> users = new ArrayList<>();

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_UserSecurity")) {
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

    // Method to return a UserSecurity object relating to the parsed-in username, from the database.
    public static UserSecurity getUser(AbstractDB db, String username) {

        UserSecurity user = null;

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_UserSecurity WHERE username = ?")) {
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

    // Method to insert a parsed-in UserSecurity object into the database.
    public static boolean insertUser(AbstractDB db, UserSecurity newUser) {

        boolean status;

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("INSERT INTO inFoJaxs_UserSecurity (username, salt, iterations, hash) VALUE (?, ?, ?, ?)")) {

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

    // Method to update a UserSecurity object's password database value to the parsed-in
    // password String, relating to the parsed-in username.
    public static boolean updatePassword(AbstractDB db, String username, String password) {

        boolean status;

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("UPDATE inFoJaxs_UserSecurity SET salt = ?, iterations = ?, hash = ? WHERE username = ?")) {

                char[] passwordArray = password.toCharArray();

                byte[] salt = Passwords.getNextSalt();
                Blob saltBlob = getBlob(salt);

                int iterations = Passwords.getNextIteration();

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

    // Method to create a new UserSecurity object from the information stored in the ResultSet.
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
