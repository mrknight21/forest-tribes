package Tree;


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
 * Created by mche618 on 14/06/2017.
 */
public class Serve_DeleteTreeComponents extends  HttpServlet {


    private static final MySQL DB = new MySQL();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {

        try {
            if (!SecurityUtility.loggingStatusChecker(request)) {
                response.sendRedirect("user_interface/Home.jsp");
                return;
            }

            int TreeID = Integer.parseInt(request.getParameter("TreeID"));
            int Deletetype = Integer.parseInt(request.getParameter("deletetype"));
            int ID = Integer.parseInt(request.getParameter("id"));
            boolean isfactual = true;


            if (Deletetype == 1 || Deletetype == 2) {
                isfactual = (request.getParameter("type").equals("factual"));
            }

            switch (Deletetype) {
                case 1:
                    TreeDAO.deleteURL(DB, ID, isfactual);
                    break;
                case 2:
                    TreeDAO.deleteURL(DB, ID, isfactual);
                    break;
                case 3:
                    TreeDAO.deleteReaction(DB, ID);
                    break;
                case 4:
                    TreeDAO.deleteReactionReply(DB, ID);
                    break;
            }

            String fullTreeAdress = "Serve_FullTree?TreeID=" + TreeID;
            response.sendRedirect(fullTreeAdress);

        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
