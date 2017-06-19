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
 *
 *
 * This servelet create a plain tree after user has decided the basic properties(title, shortIntro, coordinates) of the InfoTree.
 * --Bryan
 *
 */
public class Serve_TreeCreation extends HttpServlet{

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
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        int Xcoor = (int) Double.parseDouble(request.getParameter("X"));
        int Ycoor = (int) Double.parseDouble(request.getParameter("Y"));
        String title = request.getParameter("title");
        String shorIntro = request.getParameter("shortIntro");

        InfoTree newTree = new InfoTree(username, title, shorIntro, Xcoor, Ycoor);
        int NewID = TreeDAO.createNewTree(DB, newTree);
            System.out.println("FROM TREE CREATION ID: "+NewID);

        request.setAttribute("TreeID", NewID);
        //user is redirected to the full tree view of the newly created tree to do more edition, adding more URLs etc.
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Serve_FullTree");
        dispatcher.forward(request, response);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }



}
