package User;

import Utility.MySQL;
import Utility.SecurityUtility;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by mche618 on 5/06/2017.
 */
public class ProfileServlet extends HttpServlet {


    private static final MySQL DB = new MySQL();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {

        try {
            if (!SecurityUtility.loggingStatusChecker(request)) {
                response.sendRedirect("/Login.jsp");
                return;
            } else {

                HttpSession session = request.getSession();
                String username = (String)session.getAttribute("username");
                String email = request.getParameter("email");
                String dateOfBirth = request.getParameter("dateOfBirth");
                String gender = request.getParameter("gender");
                String occupation = request.getParameter("occupation");
                String education_level = request.getParameter("education_level");
                String politicalOri = request.getParameter("politicalOri");
                String thingsLoves = request.getParameter("thingsLoves");
                String short_intro = request.getParameter("short_intro");
                String[] issues = request.getParameter("");

            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}



