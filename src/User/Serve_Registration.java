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
import java.awt.*;
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
                response.sendRedirect("user_interface/Home.jsp");
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
                String UsersFolder = servletContext.getRealPath("/User");
                File UsersFolderfile = new File(UsersFolder);
                MicellaneousUntility.DirCeation(UsersFolderfile);
                String  UserfilePath = servletContext.getRealPath("/User/"+username);
                File userFolder = new File(UserfilePath);
                MicellaneousUntility.DirCeation(userFolder);

                if(!password.equals(confirmPassword)){
                    request.setAttribute("messageRegistration", "Your password does not match with your confirmed password. Please try again.");
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/login_interface/Login.jsp");
                    dispatcher.forward(request, response);
                }




                if (UserDAO.getUser(DB, username) == null){




                    byte[] salt = SecurityUtility.getNextSalt();

                    byte[] encodedPW = SecurityUtility.hash(password.toCharArray(), salt, ITERATIONS);

                    //UserDAO.RegisterUser(DB, new User(username,salt,ITERATIONS,encodedPW));


                    User newUser = new User(username, registrationFirstName, registrationLastName, registrationEmail, "/User/"+username+"/User_profile_picture.jpg", "/User/"+username);
                    UserSecurity newSecurity = new UserSecurity(username, salt, ITERATIONS, encodedPW);
                    UserDAO.registerUser(DB, newUser);
                    UserSecurityDAO.insertUser(DB, newSecurity);


                    //auto set-up user profile photo
                    String  DefaultImagePathway = servletContext.getRealPath("/images_material/Default/Userdefault.jpg");
                    File defaultImage = new File(DefaultImagePathway);
                    BufferedImage sourceImage = ImageIO.read(defaultImage);

                    try {
                        // retrieve image
                        File outputfile = new File(UserfilePath+"/User_profile_picture.jpg");
                        ImageIO.write(sourceImage, "jpg", outputfile);
                    } catch (IOException e) {
                        System.out.println(e.getMessage());
                    }



                    //generate thumbnail images
                    BufferedImage img = new BufferedImage(100, 100, BufferedImage.TYPE_INT_RGB);
                    img.createGraphics().drawImage(ImageIO.read(new File(UserfilePath+"/User_profile_picture.jpg")).getScaledInstance(100, 100, Image.SCALE_SMOOTH),0,0,null);
                    ImageIO.write(img, "jpg", new File(UserfilePath+"/User_profile_picture_thumb.jpg"));


                    //create a row in profile with username
                    UserDAO.createProfile(DB, username);


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



