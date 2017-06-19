package User;

/**
 * Created by mche618 on 1/06/2017.
 * Log out
 */

import Utility.SecurityUtility;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


public class Serve_Logout extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        if (SecurityUtility.loggingStatusChecker(req)){
            HttpSession session = req.getSession();
            session.removeAttribute("username");
            session.removeAttribute("loggingStatus");
            req.setAttribute("message","Logged out. Hope to see you again!");
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/login_interface/Login.jsp");
            dispatcher.forward(req, resp);
        }
        resp.sendRedirect("login_interface/Login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}

/*From: content Page.
        Hyperink : login (redirect login.jsp)
        Steps:
        1.checkLogginStatus
        2.Logout. removing session.attributes of LogginStatus and username.
        3.sent
*/