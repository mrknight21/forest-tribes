package User;

/**
 * Created by mche618 on 31/05/2017.
 */


import Utility.MiscellaneousUtility;
import Utility.MySQL;
import Utility.SecurityUtility;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

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
            if (SecurityUtility.loggingStatusChecker(request)){
                response.sendRedirect("user_interface/Home.jsp");
                return;
            } else if (!request.getParameterNames().hasMoreElements()) {
                response.sendRedirect("login_interface/Login.jsp");
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

                if(!password.equals(confirmPassword)){
                    request.setAttribute("messageRegistration", "Your password does not match with your confirmed password. Please try again.");
                } else if (UserDAO.getUserByUserName(DB, username) == null){

                    // Register user details
                    ServletContext servletContext = getServletContext();
                    String  imagePathway = servletContext.getRealPath("/images_material/Default/Userdefault.jpg");
                    UserDAO.registerUserDetails(DB, servletContext, username, registrationFirstName, registrationLastName, registrationEmail, imagePathway);

                    // Register user security details
                    byte[] salt = SecurityUtility.getNextSalt();
                    byte[] encodedPW = SecurityUtility.hash(password.toCharArray(), salt, ITERATIONS);
                    UserSecurity newSecurity = new UserSecurity(username, salt, ITERATIONS, encodedPW);
                    UserSecurityDAO.insertUser(DB, newSecurity);

                    session.setAttribute("loggingStatus", true);
                    session.setAttribute("username", username);
                    request.setAttribute("message", "Such wisdom, much intelligence. Welcome to the Forest!!");
                    dispatcher = getServletContext().getRequestDispatcher("/user_interface/Home.jsp");
                    System.out.println("registered");
                } else {
                    request.setAttribute("message", "The username you have registered already exists");
                }
                dispatcher.forward(request, response);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

}

/*
Input: from Registration.jsp
parameter:
registrationUsername
registrationPassword
registrationEmail

functions:
1. Checker1:
2. check username: if exist bounce back with Cookie(registProblem: usernameIssue) to registration page
3. store parameters by creating new user in the database. InsertUser
4. setSession with attribute logginStatus as true, setSeSession with username.

destination:
Registration.jsp
with a Cookie(registProblem: usernameIssue)

destination;
Content.jsp

 */



