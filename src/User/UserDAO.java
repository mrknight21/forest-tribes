package User;

import Utility.AbstractDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // Method to return all Users as an ArrayList from the database.
    public static List<User> getAllUsers(AbstractDB db) {

        List<User> users = new ArrayList<>();

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_User")) {
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

    // Method to return a User relating to the parsed-in username, from the database.
    public static User getUser(AbstractDB db, String username) {

        User user = null;

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_User WHERE username = ?")) {
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

    // Method to insert a parsed-in User into the database.
    public static boolean insertUser(AbstractDB db, User newUser) {

        boolean status;

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("INSERT INTO inFoJaxs_User (username, first_name, last_name, email, date_of_birth) VALUE (?, ?, ?, ?, ?)")) {
                p.setString(1, newUser.getUsername());
                p.setString(2, newUser.getFirst_name());
                p.setString(3, newUser.getLast_name());
                p.setString(4, newUser.getEmail());
                p.setDate(5, newUser.getDate_of_birth());

                p.executeUpdate();
                status = true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            status = false;
        }
        return status;
    }

    // Method to update the parsed-in User's information in the database, relating to the parsed-in username.
    public static boolean updateUser(AbstractDB db, User user, String username) {

        boolean status;

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("UPDATE inFoJaxs_User SET username = ?, first_name = ?, last_name = ?, email = ?, date_of_birth = ? WHERE username = ?")) {
                p.setString(1, user.getUsername());
                p.setString(2, user.getFirst_name());
                p.setString(3, user.getLast_name());
                p.setString(4, user.getEmail());
                p.setString(5, username);

                p.executeUpdate();
                status = true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            status = false;
        }
        return status;
    }

    // Method to create a new User object from the information stored in the ResultSet.
    private static User userFromResultSet(ResultSet r) throws SQLException {
        return new User(
                r.getString("username"),
                r.getString("first_name"),
                r.getString("last_name"),
                r.getString("email"),
                r.getDate("date")
        );
    }
}
