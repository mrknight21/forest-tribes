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

public class ProfileServlet extends HttpServlet {

    private static final MySQL DB = new MySQL();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {

        try {
            if (!SecurityUtility.loggingStatusChecker(request)) {
                response.sendRedirect("Login.jsp");
                return;

            } else {
                HttpSession session = request.getSession();
                String username = (String) session.getAttribute("username");

                String email = request.getParameter("profileEmail");
                String gender = request.getParameter("profileGender");
                String occupation = request.getParameter("profileOccupation");
                String education_level = request.getParameter("profileEducation");
                String politicalOri = request.getParameter("profilePolitical");

                String[] issues = new String[17];

                String issue01 = request.getParameter("profileIssuesPoverty");
                System.out.println(issue01);

                Profile updateProfile = new Profile(username, gender, occupation, education_level, politicalOri, issues);

                if (email != null && email.trim() != "") {
                    UserDAO.updateEmail(DB, email, username);
                }
                UserDAO.updateProfile(DB, username, updateProfile);
                request.setAttribute("message", "Profile updated successfully!!");
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/profile.jsp");
                dispatcher.forward(request, response);

            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}



