package User;

import Utility.MySQL;
import Utility.SecurityUtility;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by mche618 on 31/05/2017.
 * /*
 Input: from changePassword.jsp
 username,
 password,
 new password,
 confirm password,

 steps:
 1.checkLoginStatus
 2. Authentification
 3. confirm password
 4. Update password
 5. Redirect back to content page. dispatch "password update successful".
 destination:
 ChangingpasssWord page: with Cookie(passWordChangingProb: values
 *
 *
 *
 * --Bryan
 */
public class Serve_Changepassword extends HttpServlet{

    private static final MySQL DB = new MySQL();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {

        try {
            if (!SecurityUtility.loggingStatusChecker(request)){
                response.sendRedirect("login_interface/Login.jsp");
                return;
            } else if (!request.getParameterNames().hasMoreElements()) {
                response.sendRedirect("user_interface/changePassword.jsp");
                return;
            } else {
                String currpassword = request.getParameter("CurrentPassword");
                String newPassword = request.getParameter("NewPassword");
                String confirmpassword = request.getParameter("ConfirmPassword");
                HttpSession session = request.getSession();

                if(!newPassword.equals(confirmpassword)){
                    request.setAttribute("passwordStatus","New password and confirm password does not match");
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/user_interface/changePassword.jsp");
                    dispatcher.forward(request, response);
                }else
                {
                    String username = (String)session.getAttribute("username");
                if(!SecurityUtility.passwordAuthentication(username, currpassword)){
                    request.setAttribute("passwordStatus","The password was wrong. Try again!");
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/user_interface/changePassword.jsp");
                    dispatcher.forward(request, response);
                }
                else {
                    UserDAO.updatePassword(DB, username, newPassword);
                    request.setAttribute("message","Your password has been successfully changed");
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/user_interface/Home.jsp");
                    dispatcher.forward(request, response);
                }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}






