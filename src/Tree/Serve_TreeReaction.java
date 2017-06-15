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
public class Serve_TreeReaction extends HttpServlet {

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
                String content = request.getParameter("content");
                int reactionID = Integer.parseInt(request.getParameter("reactionID"));
                int TreeID = Integer.parseInt(request.getParameter("TreeID"));
                boolean support = (request.getParameter("support").equals("for"));

             //public T_Reaction(String author, String text, int parentID, boolean supportForArgument )
                //public T_Reaction(int id, String text, boolean supportForArgument , int repliesCount)


                if (reactionID == -1) {
                    T_Reaction newReaction = new T_Reaction(username, content, TreeID, support);
                    TreeDAO.createReaction(DB, newReaction);
                    String fullTreeAdress = "Serve_FullTree?TreeID=" + TreeID;
                    response.sendRedirect(fullTreeAdress);
                }
                else {
                    int replieSize = Integer.parseInt(request.getParameter("repliesNum"));
                    T_Reaction reaction = new T_Reaction(reactionID, content, support, replieSize );
                    TreeDAO.updateReaction(DB, reaction);
                    String fullTreeAdress = "Serve_FullTree?TreeID=" + TreeID;
                    response.sendRedirect(fullTreeAdress);
                }


            }catch  (IOException e) {
                e.printStackTrace();
            }



        }
    }



