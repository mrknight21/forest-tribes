package Utility;

/**
 * Created by mche618 on 31/05/2017.
 */


import User.User;
import User.UserDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;


public class Server_Utility {

    private static final MySQL DB = new MySQL();

    public static boolean loggingStatusChecker(HttpServletRequest request) throws IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("loggingStatus") == null) return false;

        String username = (String) session.getAttribute("username");

        if (username != null) {
            List<User> users = UserDAO.getAllUsers(DB);
            for (User user : users) if ((user.getUsername()).equals(username)) return true;
        }
        return false;
    }


    public static boolean passwordAuthentication(String username, String password) {

        char[] passwordArray = password.toCharArray();

        // Get the user relating to the parsed-in username from the database.
        User user = UserDAO.getUser(DB, username);

        // Get the salt byte array assigned to the user.
        byte[] salt = user.getSalt();

        // Get the hash byte array assigned to the user.
        byte[] hash = user.getHash();

        // Get the iterations, assigned to the user.
        int iterations = user.getIterations();

        // Call Passwords method, isExpectedPassword to determine whether the user-parsed password matches the password stored in the database. The the result is returned.
        return Passwords.isExpectedPassword(passwordArray, salt, iterations, hash);
    }

}







