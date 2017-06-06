package User;

import Utility.AbstractDB;
import Utility.SecurityUtility;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static Utility.BlobConverter.getBlob;

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
    public static boolean registerUser(AbstractDB db, User newUser) {

        boolean status;

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("INSERT INTO inFoJaxs_User (username, first_name, last_name, email) VALUE (?, ?, ?, ?)")) {
                p.setString(1, newUser.getUsername());
                p.setString(2, newUser.getFirst_name());
                p.setString(3, newUser.getLast_name());
                p.setString(4, newUser.getEmail());

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
            try (PreparedStatement p = c.prepareStatement("UPDATE inFoJaxs_User SET username = ?, first_name = ?, last_name = ?, email = ? WHERE username = ?")) {
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
///Change password
    public static boolean updatePassword(AbstractDB db, String username, String password) {

        boolean status;

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("UPDATE web_lab_19 SET salt = ?, iterations = ?, hash = ? WHERE username = ?")) {

                char[] passwordArray = password.toCharArray();

                byte[] salt = SecurityUtility.getNextSalt();
                Blob saltBlob = getBlob(salt);

                int iterations = 50000;

                byte[] hash = SecurityUtility.hash(passwordArray, salt, iterations);
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

///Will try to make the method more generic
    public static boolean updateEmail(AbstractDB db, String value, String username) {

        boolean status;

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("UPDATE inFoJaxs_User SET email = ? WHERE username = ?;")) {
                //p.setString(1, colunm);
                p.setString(1, value);
                p.setString(2, username);
                p.executeUpdate();
                status = true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            status = false;
        }
        return status;
    }

    public static boolean updateProfile(AbstractDB db, String username, Profile profile){

        boolean status;

        String dateOfBirth = profile.getDateOfBirth();
        String gender = profile.getGender();
        String occupation = profile.getOccupation();
        String education_level = profile.getEducation_level();
        String politicalOri= profile.getPoliticalOri();
        String thingsLoves= profile.getThingsLoves();
        String short_intro= profile.getShort_intro();
        String[] issues = profile.getIssues();

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("UPDATE inFoJaxs_Profile SET date_Of_Birth = ?, gender = ?, occupation = ?, education_level = ?, political_Orientation = ?, things_Loved = ?, short_intro = ? WHERE username = ?")) {
                p.setString(1, dateOfBirth);
                p.setString(2, gender);
                p.setString(3, occupation);
                p.setString(4, education_level);
                p.setString(5, politicalOri);
                p.setString(6, thingsLoves);
                p.setString(7, short_intro);
                p.setString(8, username);
                p.executeUpdate();
                status = true;
            }
            try (PreparedStatement p = c.prepareStatement("DELETE FROM inFoJaxs_IssuesCared WHERE username = ?")) {
                p.setString(1, username);
               p.executeUpdate();
            }

            for(String issue: issues) {
                try (PreparedStatement p = c.prepareStatement("INSERT INTO inFoJaxs_IssuesCared (username, issues_Cared) VALUE (?, ?)")) {
                    p.setString(1, username);
                    p.setString(2, issue);
                    p.executeUpdate();
                }
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
                r.getString("email")
        );
    }
}
