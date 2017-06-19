package User;

/**
 * Created by Barns on 31/05/17.
 * This servelet authentificate user for their attempt of logging.
 * Two potential logging attemps: normal logging, google account logging.
 *
 * * Input: Login.jsp
 * Parameter:
 * loginUsername
 * loginPassword
 *
 ** steps:
 * 1. checkLogginStatus -> content page.
 * 2. check Username exist
 * 3. Authentificate password
 * 4. setSession LogginStatus = true, username = username.
 * 5. redirect to Content page.
 * 6. or redirect to login page if authentification fail.
 *
 *
 *--Bryan
 */

import Utility.MySQL;
import Utility.SecurityUtility;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;

import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.security.GeneralSecurityException;
import java.util.Collections;

public class Serve_Authentication extends HttpServlet {

    private static final MySQL DB = new MySQL();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
//use post to hide password etc.
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //checking login status
        if (SecurityUtility.loggingStatusChecker(request)) {
            response.sendRedirect("user_interface/Home.jsp");
            return;
        }

        String idTokenString = request.getParameter("idtoken");

        //if user use google account, the autentificateGoogleToken method is evoked .
        if (idTokenString != null) {
            authenticateGoogleToken(request, response, idTokenString);
            return;
        }

        //if user don't pass authentification, send back to login page
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/login_interface/Login.jsp");


        String username = request.getParameter("loginUsername");
        String password = request.getParameter("loginPassword");


        try {
            // if either username or password is empty, user is pumped out.
            if (username == null || password == null) {
                request.setAttribute("message", "Please enter a username and password to log in");
                //if user don't pass authentification (password not matching with database after hash and salt, user will be bumped out).
            } else if (SecurityUtility.passwordAuthentication(username, password)) {
                loginTrue(request, username);
                request.setAttribute("message", "You genius! Log in is successful!!");
                //direct to home page
                dispatcher = getServletContext().getRequestDispatcher("/user_interface/Home.jsp");
            } else {
                request.setAttribute("message", "The combination of username and password you have entered is incorrect");

            }

            dispatcher.forward(request, response);
            // Null pointer exception might occur when the entered username does not exit in the data base. a message of "user does not exist will be send"
        }catch (NullPointerException e){
            request.setAttribute("message", e.getMessage());
            dispatcher.forward(request, response);
        }
    }

    private void authenticateGoogleToken(HttpServletRequest request, HttpServletResponse response, String idTokenString) {

        JsonFactory jsonFactory = new JacksonFactory();
        HttpTransport httpTransport = new NetHttpTransport();

        GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(httpTransport, jsonFactory)
                .setAudience(Collections.singletonList("528062179592-r23sffi9bm4tnntec1e6eei3s1oot0k9.apps.googleusercontent.com"))
                // Or, if multiple clients access the backend:
                //.setAudience(Arrays.asList(CLIENT_ID_1, CLIENT_ID_2, CLIENT_ID_3))
                .build();

        // (Receive idTokenString by HTTPS POST)
        GoogleIdToken idToken = null;
        String userName = null;

        try {idToken = verifier.verify(idTokenString);}
        catch (GeneralSecurityException | IOException e) {e.printStackTrace();}

        if (idToken != null) {
            Payload payload = idToken.getPayload();

            // Print user identifier
            String userId = payload.getSubject();
            userName = UserSecurityDAO.getUserByGoogleID(DB, userId);
            System.out.println("User ID: " + userId);

            // Use or store profile information
            if (userName == null) {
                // Get profile information from payload
                // boolean emailVerified = Boolean.valueOf(payload.getEmailVerified());
                // String locale = (String) payload.get("locale");
                String email = payload.getEmail();
                userName = (String) payload.get("name");
                String pictureUrl = (String) payload.get("picture");
                String familyName = (String) payload.get("family_name");
                String givenName = (String) payload.get("given_name");

                URL imageUrl = null;
                try {imageUrl = new URL(pictureUrl);}
                catch (MalformedURLException e) {e.printStackTrace();}

                try {UserDAO.registerUserDetails(DB, getServletContext(), userId, userName, givenName, familyName, email, imageUrl);}
                catch (IOException e) {e.printStackTrace();}
            }
            loginTrue(request, userName);
        }
        try {response.getWriter().write(userName);}
        catch (IOException e) {e.printStackTrace();}
    }

    private void loginTrue(HttpServletRequest request, String username) {
        HttpSession session = request.getSession();
        session.setAttribute("loggingStatus", true);
        session.setAttribute("username", username);
        System.out.println("logged in");
    }
}

