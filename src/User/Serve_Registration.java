package User;

/**
 * Created by mche618 on 31/05/2017.
 *
 * Input: from Registration.jsp
 * parameter:
 * registrationUsername
 * registrationPassword
 * registrationEmail
 *
 * functions:
 * 1. Checker1: check loggin status
 * 2. check username: if exist bounce back;
 * 3. store parameters by creating new user in the database. InsertUser
 * 4. setSession with attribute logginStatus as true, setSeSession with username.
 *
 * destination:
 * Registration.jsp
 * with a Cookie(registProblem: usernameIssue)
 *
 *
 */


import Utility.MiscellaneousUtility;
import Utility.MySQL;
import Utility.SecurityUtility;

import javax.imageio.ImageIO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

public class Serve_Registration extends HttpServlet {

    private static final MySQL DB = new MySQL();
    private static final int ITERATIONS = 5000;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        try {
            //check loggin status
            if (SecurityUtility.loggingStatusChecker(request)){
                response.sendRedirect("user_interface/Home.jsp");
                return;
                //check if form is empty
            } else if (!request.getParameterNames().hasMoreElements()) {
                response.sendRedirect("login_interface/Login.jsp");
                return;
                //checking if the request was from an Ajax call. If it is from an Ajax call, then gone through the method to check user name availability.
            } else if (request.getParameter("usernameCheck") != null) {
                checkUserNameAvailable(request, response);
                return;
            } else {
                HttpSession session = request.getSession();


                // Get registration Parameters:
                String username = request.getParameter("registrationUsername");
                String registrationFirstName = request.getParameter("registrationFirstName");
                String registrationLastName = request.getParameter("registrationLastName");
                String registrationEmail = request.getParameter("registrationEmail");
                String password = request.getParameter("registrationPassword");
                String confirmPassword = request.getParameter("registrationConfirmPassword");

                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/login_interface/Login.jsp");;

                //check if password matches to confrim password
                if(!password.equals(confirmPassword)){
                    request.setAttribute("messageRegistration", "Your password does not match with your confirmed password. Please try again.");
                } else if (UserDAO.getUserByUserName(DB, username) == null){

                    // Register user details
                    ServletContext servletContext = getServletContext();
                    String  imagePathway = servletContext.getRealPath("/images_material/Default/Userdefault.jpg");
                    //this method, insert new user, create new profile, create user photo folder, create deafult photo.
                    UserDAO.registerUserDetails(DB, servletContext, username, registrationFirstName, registrationLastName, registrationEmail, ImageIO.read(new File(imagePathway)));

                    // Register user security details
                    byte[] salt = SecurityUtility.getNextSalt();
                    byte[] encodedPW = SecurityUtility.hash(password.toCharArray(), salt, ITERATIONS);
                    //create new UserSecurity object in database to store hashed and salted password.
                    UserSecurity newSecurity = new UserSecurity(username, salt, ITERATIONS, encodedPW);
                    UserSecurityDAO.insertUser(DB, newSecurity);


                    //setup login session
                    session.setAttribute("loggingStatus", true);
                    session.setAttribute("username", username);
                    request.setAttribute("message", "Such wisdom, much intelligence. Welcome to the Forest!!");
                    //send to home page.
                    dispatcher = getServletContext().getRequestDispatcher("/user_interface/Home.jsp");

                } else {
                    request.setAttribute("message", "The username you have registered already exists");
                }
                dispatcher.forward(request, response);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

    }


    //checking whether username is available for the Ajax call from the registration form
    private void checkUserNameAvailable(HttpServletRequest request, HttpServletResponse response) {


        try {
            PrintWriter out = response.getWriter();

            if (UserDAO.getUserByUserName(DB, request.getParameter("usernameCheck")) == null)
                out.write("" + null);
            else out.write("available");

        } catch (IOException e) {
            e.printStackTrace();
        }


    }

}




