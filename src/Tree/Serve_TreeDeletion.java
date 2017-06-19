package Tree;

import Utility.MySQL;
import Utility.SecurityUtility;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by mche618 on 19/06/2017.
 *
 * this servelet handle request to delete a whole infoTree.
 * All related URLS and reactions will be deleted in the database due to "ON DELETE CASCADE".
 * --Bryan
 */
public class Serve_TreeDeletion extends HttpServlet{


    private static final MySQL DB = new MySQL();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        try {
            if (!SecurityUtility.loggingStatusChecker(request)) {
                response.sendRedirect("user_interface/Home.jsp");
                return;
            }


            HttpSession session = request.getSession();
            int TreeID = Integer.parseInt(request.getParameter("TreeID"));


            //double check user and author matched.
            String username = (String) session.getAttribute("username");
            String treeAuthor = request.getParameter("author");
            if(!username.equals(treeAuthor)){
                String fullTreeAdress = "Serve_FullTree?TreeID=" + TreeID;
                response.sendRedirect(fullTreeAdress);
                return;
            }

            //delete tree then redirect back to home
            TreeDAO.deleteInfoTree(DB, TreeID);
            response.sendRedirect("user_interface/Home.jsp");
            return;




        }catch (IOException e) {
            e.printStackTrace();
        }

    }









}
