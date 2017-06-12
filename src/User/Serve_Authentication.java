package User;

/**
 * Created by Barns on 31/05/17.
 */

import Utility.MySQL;
import Utility.SecurityUtility;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class Serve_Authentication extends HttpServlet {

    private static final MySQL DB = new MySQL();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {

        try {
            if (SecurityUtility.loggingStatusChecker(request)){
            response.sendRedirect("user_interface/Home.jsp");
            return;
            }else {
                HttpSession session = request.getSession();
                String username = request.getParameter("loginUsername");
                String password = request.getParameter("loginPassword");

                if (username == null || password == null) {
                    request.setAttribute("message", "Please enter a username and password to log in");
                    System.out.println("No parameters received.");
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/login_interface/Login.jsp");
                    dispatcher.forward(request, response);

                } else if (UserDAO.getUser(DB, username) != null){
                    if(SecurityUtility.passwordAuthentication(username, password)){
                        session.setAttribute("loggingStatus", true);
                        session.setAttribute("username", username);
                        request.setAttribute("message", "Welcome logging!!");
                        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/user_interface/Home.jsp");
                        System.out.println("logged in");
                        dispatcher.forward(request, response);
                    } else {
                        request.setAttribute("message", "The combination of username and password you have entered is incorrect");
                        System.out.println("Password was wrong");
                        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/login_interface/Login.jsp");
                        dispatcher.forward(request, response);
                    }
                } else if (UserDAO.getUser(DB, username) == null){
                    request.setAttribute("message", "The combination of username and password you have entered is incorrect");
                    System.out.println("Password was wrong");
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