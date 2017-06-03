package Article;

/**
 * Created by Barns on 31/05/17.
 */

import ictgradschool.ex05.MySQL;
import ictgradschool.ex05.UserDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class DisplayArticlesServlet extends HttpServlet {

    private static final MySQL DB = new MySQL();
    private static final int ITERATIONS = 50000;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {


        try {
            if (Server_Utility.loggingStatusChecker(request)){
            response.sendRedirect("/ex05/Content.jsp");
            return;
            }else {
                HttpSession session = request.getSession();
                String username = request.getParameter("loginUsername");
                String password = request.getParameter("loginPassword");

                if(UserDAO.getUser(DB, username) != null){
                    if(Server_Utility.passwordAuthentication(username, password)){
                        session.setAttribute("loggingStatus", true);
                        session.setAttribute("username", username);
                        request.setAttribute("Welcome", "Welcome logging!!");
                        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/ex05/Content.jsp");
                        System.out.println("logged in");
                        dispatcher.forward(request, response);
                    }else {

                        request.setAttribute("loginProb", "The combination of username and password you have entered is incorrect");
                        System.out.println("Password was wrong");
                        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/ex05/Login.jsp");
                        dispatcher.forward(request, response);
                    }
                }else {

                    request.setAttribute("loginProb", "The combination of username and password you have entered is incorrect");
                    System.out.println("Password was wrong");
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/ex05/Login.jsp");
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