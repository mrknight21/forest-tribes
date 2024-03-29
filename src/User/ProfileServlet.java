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
import java.util.ArrayList;
import java.util.List;

public class ProfileServlet extends HttpServlet {

    private static final MySQL DB = new MySQL();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    //This servelet handles the updating request to profile.
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        try {
            //check login status
            if (!SecurityUtility.loggingStatusChecker(request)) {
                response.sendRedirect("login_interface/Login.jsp");
                return;
//            } else if (!request.getParameterNames().hasMoreElements()) {
//                response.sendRedirect("Profile.jsp");
//                return;
            } else {
                HttpSession session = request.getSession();
                String username = (String) session.getAttribute("username");

                String email = request.getParameter("profileEmail");
                String gender = request.getParameter("profileGender");
                String occupation = request.getParameter("profileOccupation");
                String education = request.getParameter("profileEducation");
                String political = request.getParameter("profilePolitical");

                String[] allIssues = new String[17];

                allIssues[0] = "Poverty";
                allIssues[1] = "Hunger";
                allIssues[2] = "Health";
                allIssues[3] = "Education";
                allIssues[4] = "Gender";
                allIssues[5] = "Water";
                allIssues[6] = "Energy";
                allIssues[7] = "Economic";
                allIssues[8] = "Innovation";
                allIssues[9] = "Inequality";
                allIssues[10] = "Community";
                allIssues[11] = "Consumption";
                allIssues[12] = "Climate";
                allIssues[13] = "WaterLife";
                allIssues[14] = "LandLife";
                allIssues[15] = "Peace";
                allIssues[16] = "Partnerships";

                String issues = "";

                //making the issues array into a string
                StringBuilder sb = new StringBuilder("");

                for (int i = 0; i < 17; i++) {
                    String issue = request.getParameter("profileIssues" + allIssues[i]);

                    if (issue != null) {
                        sb.append(issue).append(", ");
                    }
                }

                if (!sb.equals(null)) {
                    issues = sb.toString();
                }


                Profile updateProfile = new Profile(username, gender, occupation, education, political, issues);

                if (email != null && !(email.trim()).equals("")) {
                    UserDAO.updateEmail(DB, email, username);
                }

                UserDAO.updateProfile(DB, username, updateProfile);

                request.setAttribute("message", "Profile successfully updated.");

                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Profile.jsp");
                dispatcher.forward(request, response);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}



