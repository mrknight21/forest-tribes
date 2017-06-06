package User;

/**
 * Created by mche618 on 1/06/2017.
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
            req.setAttribute("message","Log out successfully! Hope to see you again");
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("Login.jsp");
            dispatcher.forward(req, resp);
        }
        resp.sendRedirect("/ex05/Login.jsp");
    }
}

/*From: content Page.

        Hyperink : login (redirect login.jsp)

        Steps:
        1.checkLogginStatus
        2.Logout. removing session.attributes of LogginStatus and username.
        3.sent
*/