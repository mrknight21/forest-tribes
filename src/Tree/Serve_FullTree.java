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
import java.util.ArrayList;
import java.util.List;

/**
 * Created by mche618 on 14/06/2017.
 *
 * This servelet handle the request to display a particular full InfoTree, include all text contents and other properties.
 * As the tree has 6 different text type collections, base on their support or against position regarding the topic and the text types(factualURL, commentaryURL, Reaction).
 * , it will be chaotic to sort everything in the displaying jsp. Therefore, handle the requests and prepare the 6 collections list is important in this servelet.
 *--Bryan
 *
 *
 */
public class Serve_FullTree extends HttpServlet {

    private static final MySQL DB = new MySQL();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {


        try {
            //check loggin status
            if (!SecurityUtility.loggingStatusChecker(request)) {
                response.sendRedirect("user_interface/Home.jsp");
                return;
            }

            int ID;

            //There are two situation when a full tree is requested to be displayed.
            // 1. the normal situation when an user click on a tree on the map to look the detail of the tree. In this case TreeID will be passed in as parameter"TreeID"
            //2. After a new tree has just been successfully created, user will be directed to its full tree view to add more context information. In this case, TreeID will be passed in as attribute"TreeID"
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("username");
            if(request.getParameter("TreeID") == null){
                ID = (int) request.getAttribute("TreeID");
            }
            else {
                ID = Integer.parseInt(request.getParameter("TreeID"));
            }

            InfoTree tree = TreeDAO.getInfoTreeById(DB, ID);



            //Getting all factual URL, then sort them based on their position(support, against).
            List<T_URL> factual = new ArrayList<>();
            List<T_URL> fact_for = new ArrayList<>();
            List<T_URL> fact_against = new ArrayList<>();

            //Getting all commentary URL, then sort them based on their position(support, against).
            List<T_URL> commentary = new ArrayList<>();
            List<T_URL> commentary_for = new ArrayList<>();
            List<T_URL> commentary_against = new ArrayList<>();

            //Getting all reaction, then sort them based on their position(support, against).
            List<T_Reaction> reaction = new ArrayList<>();
            List<T_Reaction> reaction_for = new ArrayList<>();
            List<T_Reaction> reaction_against = new ArrayList<>();


            factual = tree.getFactual();
            for( T_URL URL : factual){
                if(URL.isSupportForArgument()){
                    fact_for.add(URL);
                }
                else {
                    fact_against.add(URL);
                }
            }

            commentary = tree.getCommentary();
            for( T_URL URL : commentary){
                if(URL.isSupportForArgument()){
                    commentary_for.add(URL);
                }
                else {
                    commentary_against.add(URL);
                }
            }

            reaction = tree.getReactoin();
            for( T_Reaction react : reaction){
                if(react.isSupportForArgument()){
                    reaction_for.add(react);
                }
                else {
                    reaction_against.add(react);
                }
            }



            //packing all sorted lists as attribute and pass on
            request.setAttribute("tree", tree);
            request.setAttribute("fact_for", fact_for);
            request.setAttribute("fact_against", fact_against);
            request.setAttribute("commentary_for", commentary_for);
            request.setAttribute("commentary_against", commentary_against);
            request.setAttribute("reaction_for", reaction_for);
            request.setAttribute("reaction_against", reaction_against);

            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/tree_TRIAL/FullTree.jsp");
            dispatcher.forward(request, response);


        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
