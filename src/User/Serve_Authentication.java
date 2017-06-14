package User;

/**
 * Created by Barns on 31/05/17.
 */

import Utility.MySQL;
import Utility.SecurityUtility;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson.JacksonFactory;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.GeneralSecurityException;
import java.util.Collections;

public class Serve_Authentication extends HttpServlet {

    private static final MySQL DB = new MySQL();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (SecurityUtility.loggingStatusChecker(request)) {
            response.sendRedirect("user_interface/Home.jsp");
            return;
        }
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/login_interface/Login.jsp");

        String idTokenString = request.getParameter("idtoken");

//        if (idTokenString != null) {
//
//            JsonFactory jsonFactory = new JacksonFactory();
//            NetHttpTransport transport = new NetHttpTransport();
//
//            GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(transport, jsonFactory)
//                    .setAudience(Collections.singletonList("528062179592-r23sffi9bm4tnntec1e6eei3s1oot0k9.apps.googleusercontent.com"))
//                    // Or, if multiple clients access the backend:
//                    //.setAudience(Arrays.asList(CLIENT_ID_1, CLIENT_ID_2, CLIENT_ID_3))
//                    .build();
//
//            // (Receive idTokenString by HTTPS POST)
//
//            GoogleIdToken idToken = null;
//
//            try {
//                idToken = verifier.verify(idTokenString);
//            } catch (GeneralSecurityException e) {
//                e.printStackTrace();
//            }
//
//            if (idToken != null) {
//                GoogleIdToken.Payload payload = idToken.getPayload();
//
//                // Print user identifier
//                String userId = payload.getSubject();
//                System.out.println("User ID: " + userId);
//
//                String userName = UserSecurityDAO.getUserByGoogleID(DB, userId);
//
//                // Use or store profile information
//                // ...
//                PrintWriter out = response.getWriter();
//
//                if (userName == null) {
//
//                    // Get profile information from payload
//                    String email = payload.getEmail();
//                    boolean emailVerified = Boolean.valueOf(payload.getEmailVerified());
//                    userName = (String) payload.get("name");
//                    String pictureUrl = (String) payload.get("picture");
//                    String locale = (String) payload.get("locale");
//                    String familyName = (String) payload.get("family_name");
//                    String givenName = (String) payload.get("given_name");
//
//                    UserDAO.registerUserDetails(DB, getServletContext(), userName, givenName, familyName, email, pictureUrl);
//                }
//
//                out.write(userName);
//
////                loginTrue(request, response, userName);
//                return;
//
//            } else {
//                System.out.println("Invalid ID token.");
//                request.setAttribute("message", "Invalid ID token.");
//                dispatcher.forward(request, response);
//            }
//        }


        String username = request.getParameter("loginUsername");
        String password = request.getParameter("loginPassword");

        if (username == null || password == null) {
            request.setAttribute("message", "Please enter a username and password to log in");
            System.out.println("No parameters received.");
        } else if (UserDAO.getUserByUserName(DB, username) != null) {
            if (SecurityUtility.passwordAuthentication(username, password)) {
                loginTrue(request, response, username);
                return;
            } else {
                request.setAttribute("message", "The combination of username and password you have entered is incorrect");
                System.out.println("Password was wrong");
            }
        } else {
            request.setAttribute("message", "The combination of username and password you have entered is incorrect");
            System.out.println("Username does not exist");
        }
        dispatcher.forward(request, response);
    }

    private void loginTrue(HttpServletRequest request, HttpServletResponse response, String username) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.setAttribute("loggingStatus", true);
        session.setAttribute("username", username);
        request.setAttribute("message", "You genius! Log in is successful!!");
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/user_interface/Home.jsp");
        System.out.println("logged in");
        dispatcher.forward(request, response);
    }
}


/*
* Input: Login.jsp
* Parameter:
* loginUsername
* loginPassword
*
* steps:
* 1. checkLogginStatus -> content page.
* 2. check Username exist
* 3. Authentificate password
* 4. setSession LogginStatus = true, username = username.
* 5. redirect to Content page.
* 6. or redirect to login page if authentification fail.
*
*
* Output:
* Cookie (loginAttempt: unsuccessful) to Login.jsp
*
*
*
*
*
* */