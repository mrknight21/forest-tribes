package User;

/**
 * Created by mche618 on 31/05/2017.
 */


import Utility.MicellaneousUntility;
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
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

public class Serve_Registration extends HttpServlet {

    private static final MySQL DB = new MySQL();
    private static final int ITERATIONS = 5000;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {

        try {
            if (SecurityUtility.loggingStatusChecker(request)){
                response.sendRedirect("/user_interface/Home.jsp");
                return;
            } else {
                HttpSession session = request.getSession();
                String username = request.getParameter("registrationUsername");
                String registrationFirstName = request.getParameter("registrationFirstName");
                String registrationLastName = request.getParameter("registrationLastName");
                String registrationEmail = request.getParameter("registrationEmail");
                String password = request.getParameter("registrationPassword");
                String confirmPassword = request.getParameter("registrationConfirmPassword");

                //get path for creating files
                ServletContext servletContext = getServletContext();
                String userFilePath = servletContext.getRealPath("/"+username);
                File userFolder = new File(userFilePath);
                MicellaneousUntility.DirCeation(userFolder);

                if (UserDAO.getUser(DB, username) == null){

                    byte[] salt = SecurityUtility.getNextSalt();

                    byte[] encodedPW = SecurityUtility.hash(password.toCharArray(), salt, ITERATIONS);

                    User newUser = new User(username, registrationFirstName, registrationLastName, registrationEmail);
                    UserSecurity newSecurity = new UserSecurity(username, salt, ITERATIONS, encodedPW);

                    UserDAO.registerUser(DB, newUser);
                    UserSecurityDAO.insertUser(DB, newSecurity);

                    //auto set-up user profile photo
                    File defaultImage = new File("/images_material/Default/Userdefault.jpg");
                    BufferedImage sourceImage = ImageIO.read(defaultImage);

                    try {
                        // retrieve image
                        File outputfile = new File(userFilePath+"/User_Profile_Image.jpg");
                        ImageIO.write(sourceImage, "jpg", outputfile);
                    } catch (IOException e) {
                        System.out.println(e.getMessage());
                    }

                    session.setAttribute("loggingStatus", true);
                    session.setAttribute("username", username);
                    request.setAttribute("message", "Welcome logging!!");
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/user_interface/Home.jsp");
                    System.out.println("registered");
                    dispatcher.forward(request, response);
                }
                else {
                    request.setAttribute("message", "The username you have registered already exists");
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/login_interface/Login.jsp");
                    dispatcher.forward(request, response);
                }
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



