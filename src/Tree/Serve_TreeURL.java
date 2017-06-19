package Tree;

/**
 * Created by mche618 on 14/06/2017.
 *
 * This servelet handle the creating and updateing request for both commentary and factual URL under a particular InfoTree.
 * The type and position of the particular URL will be firstly identified, then the request type will be identified based on the URLid.
 * Existing URL will has its own URL id, while the request to create a new URL will have id as "-1".
 *--Bryan
 *
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


public class Serve_TreeURL extends HttpServlet{

    private static final MySQL DB = new MySQL();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {


        try {
            if (!SecurityUtility.loggingStatusChecker(request)) {
                response.sendRedirect("login_interface/Login.jsp");
                return;
            }

            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("username");
            String title = request.getParameter("title");
            String shortIntro = request.getParameter("shortIntro");
            String URL = request.getParameter("URL");
            int URLid = Integer.parseInt(request.getParameter("URLid"));
            int TreeID = Integer.parseInt(request.getParameter("TreeID"));
            //identify type of the URL
            boolean isfactual = (request.getParameter("URLtype").equals("factual"));
            //identify position of the URL
            boolean support = (request.getParameter("support").equals("for"));

            //Existing URL will has its own URL id, while the request to create a new URL will have id as "-1".
            //After the URL has been either created or updated, the user will be redirected to the full tree view.
            if (URLid == -1) {
                System.out.println(support);
                T_URL newURL = new T_URL(username, title, shortIntro, TreeID, URL, support, isfactual);
                TreeDAO.createNewURL(DB, newURL);
                String fullTreeAdress = "Serve_FullTree?TreeID=" + TreeID;
                response.sendRedirect(fullTreeAdress);
            }
            else {
                T_URL newURL = new T_URL(URLid, title, shortIntro, URL, support, isfactual);
                TreeDAO.updateURL(DB, newURL);
                String fullTreeAdress = "Serve_FullTree?TreeID=" + TreeID;
                response.sendRedirect(fullTreeAdress);
            }


        }catch  (IOException e) {
            e.printStackTrace();
        }



    }
}
