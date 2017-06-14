package User;

import Utility.AbstractDB;
import Utility.MiscellaneousUtility;
import Utility.MySQL;
import Utility.SecurityUtility;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static Utility.BlobConverter.getBlob;
import static Utility.BlobConverter.getByteArray;

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
    public static User getUserByUserName(AbstractDB db, String username) {
        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_User WHERE username = ?")) {
                p.setString(1, username);

                try (ResultSet r = p.executeQuery()) {while (r.next()) return userFromResultSet(r);}
            }
        }
        catch (SQLException | ClassNotFoundException e) {e.printStackTrace();}
        return null;
    }

    // Method to insert a parsed-in User into the database.
    public static boolean registerUser(AbstractDB db, User newUser) {

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("INSERT INTO inFoJaxs_User (username, first_name, last_name, email, ProfileImagePath, UserFolderPath) VALUE (?, ?, ?, ?, ?, ?)")) {
                p.setString(1, newUser.getUsername());
                p.setString(2, newUser.getFirst_name());
                p.setString(3, newUser.getLast_name());
                p.setString(4, newUser.getEmail());
                p.setString(5, newUser.getProfileImagePath());
                p.setString(6, newUser.getUserFolderPath());

                p.executeUpdate();
                return true;
            }
        } catch (SQLException | ClassNotFoundException e) {e.printStackTrace();}
        return false;
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
            try (PreparedStatement p = c.prepareStatement("UPDATE inFoJaxs_UserSecurity SET salt = ?, iterations = ?, hash = ? WHERE username = ?")) {

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


    public static boolean createProfile(AbstractDB db, String username) {
        boolean status = false;

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("SELECT username FROM inFoJaxs_Profile WHERE username = ?")) {
                p.setString(1, username);
                try (ResultSet r = p.executeQuery()) {
                    if (r.next()) {
                        if (username.equals(r.getString("username"))) {
                            status = false;
                        }
                    } else {
                        try (PreparedStatement b = c.prepareStatement("INSERT INTO inFoJaxs_Profile (username) VALUE (?);")) {
                            b.setString(1, username);
                            b.executeUpdate();
                            status = true;
                            System.out.println("profile created");
                        }
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            status = false;
        }
        return status;
    }

    public static Profile getProfile(AbstractDB db, String username) {

        Profile profile = null;

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_Profile WHERE username = ?")) {
                p.setString(1, username);

                try (ResultSet r = p.executeQuery()) {
                    while (r.next()) {
                        profile = profileFromResultSet(r);
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return profile;
    }


    public static boolean updateProfile(AbstractDB db, String username, Profile profile) {

        boolean status;

        String gender = profile.getGender();
        String occupation = profile.getOccupation();
        String education = profile.getEducation();
        String political = profile.getPolitical();
        String issues = profile.getIssues();

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("UPDATE inFoJaxs_Profile SET gender = ?, occupation = ?, education = ?, political = ?, issues = ? WHERE username = ?")) {
                p.setString(1, gender);
                p.setString(2, occupation);
                p.setString(3, education);
                p.setString(4, political);
                p.setString(5, issues);
                p.setString(6, username);
                p.executeUpdate();
                status = true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            status = false;
        }
        return status;
    }

    public static boolean updateProfileImagePath(AbstractDB db, String path, String username) {
        boolean status;

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("UPDATE inFoJaxs_User SET ProfileImagePath = ? WHERE username = ?")) {
                //p.setString(1, colunm);
                p.setString(1, path);
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

    // Method to create a new User object from the information stored in the ResultSet.
    private static User userFromResultSet(ResultSet r) throws SQLException {
        return new User(
                r.getString("username"),
                r.getString("first_name"),
                r.getString("last_name"),
                r.getString("email"),
                r.getString("ProfileImagePath"),
                r.getString("UserFolderPath")
        );
    }

    private static Profile profileFromResultSet(ResultSet r) throws SQLException {
        return new Profile(
                r.getString("username"),
                r.getString("gender"),
                r.getString("occupation"),
                r.getString("education"),
                r.getString("political"),
                r.getString("issues")
        );
    }

    public static boolean deleteUser(AbstractDB db, String username, String password) {

        boolean success = false;

        UserSecurity user = null;

        char[] passwordArray = password.toCharArray();

        // Get the user relating to the parsed-in username from the database.
        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_UserSecurity WHERE username = ?")) {
                p.setString(1, username);

                try (ResultSet r = p.executeQuery()) {
                    while (r.next()) {
                        user = new UserSecurity(
                                r.getString("username"),
                                getByteArray(r.getBlob("salt")),
                                r.getInt("iterations"),
                                getByteArray(r.getBlob("hash")));
                    }
                }
            }

            // Get the salt byte array assigned to the user.
            byte[] salt = user.getSalt();

            // Get the hash byte array assigned to the user.
            byte[] hash = user.getHash();

            // Get the iterations, assigned to the user.
            int iterations = user.getIterations();

            // Call SecurityUtility method, isExpectedPassword to determine whether the user-parsed password matches the password stored in the database. The the result is returned.
            if (SecurityUtility.isExpectedPassword(passwordArray, salt, iterations, hash)) {
                try (PreparedStatement p = c.prepareStatement("DELETE FROM inFoJaxs_User WHERE username = ?;")) {
                    p.setString(1, username);
                    p.executeUpdate();
                    success = true;
                }
            }
            ;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return success;
    }

    public static void registerUserDetails(AbstractDB DB, ServletContext servletContext, String username, String registrationFirstName, String registrationLastName, String registrationEmail, String imagePathway) throws IOException {

        // Register user and create profile
        User newUser = new User(username, registrationFirstName, registrationLastName, registrationEmail, "/User/"+username+"/User_profile_picture.jpg", "/User/"+username);

        //auto set-up user profile photo
        setUserDP(imagePathway, username, servletContext);

        registerUser(DB, newUser);

        createProfile(DB, username);
    }

    private static void setUserDP(String imagePathway, String username, ServletContext servletContext) throws IOException {

        // Create user dir
        String userDirPath = MiscellaneousUtility.createUserDir(servletContext, username);

        BufferedImage sourceImage = ImageIO.read(new File(imagePathway));

        try {
            // retrieve image
            File outputfile = new File(userDirPath +"/User_profile_picture.jpg");
            ImageIO.write(sourceImage, "jpg", outputfile);
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }

        //generate thumbnail images
        BufferedImage img = new BufferedImage(100, 100, BufferedImage.TYPE_INT_RGB);
        img.createGraphics().drawImage(ImageIO.read(new File(userDirPath +"/User_profile_picture.jpg")).getScaledInstance(100, 100, Image.SCALE_SMOOTH),0,0,null);
        ImageIO.write(img, "jpg", new File(userDirPath +"/User_profile_picture_thumb.jpg"));
    }
}
