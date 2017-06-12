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

                String[] listOfIssues = new String[17];

                listOfIssues[0] = "Poverty";
                listOfIssues[1] = "Hunger";
                listOfIssues[2] = "Health";
                listOfIssues[3] = "Education";
                listOfIssues[4] = "Gender";
                listOfIssues[5] = "Water";
                listOfIssues[6] = "Energy";
                listOfIssues[7] = "Economic";
                listOfIssues[8] = "Innovation";
                listOfIssues[9] = "Inequality";
                listOfIssues[10] = "Community";
                listOfIssues[11] = "Consumption";
                listOfIssues[12] = "Climate";
                listOfIssues[13] = "WaterLife";
                listOfIssues[14] = "LandLife";
                listOfIssues[15] = "Peace";
                listOfIssues[16] = "Partnerships";

                List<String> userIssues = new ArrayList<>();

                for (int i = 0; i < 17; i++) {
                    String issue = request.getParameter("profileIssues" + listOfIssues[i]);

                    if (issue != null) {
                        userIssues.add(issue);
                    }
                }

                Profile updateProfile = new Profile(username, gender, occupation, education_level, politicalOri, listOfIssues);

                if (email != null && !(email.trim()).equals("")) {
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



