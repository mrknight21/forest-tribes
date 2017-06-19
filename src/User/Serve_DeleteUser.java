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

/**
 * Created by mche618 on 7/06/2017.
 *
 * This servelet deal with User's request to delete their own account.
 * Before excecution of deletion, the user's password will be checked if match with database.
 * --Bryan
 *
 *
 */
public class Serve_DeleteUser extends HttpServlet {

    private static final MySQL DB = new MySQL();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        try {
            //check loggin status
            if (!SecurityUtility.loggingStatusChecker(request)) {
                response.sendRedirect("login_interface/Login.jsp");
                return;
            } else {

                HttpSession session = request.getSession();
                String username = (String) session.getAttribute("username");
                String password = request.getParameter("profileDeletePassword");
                //Inside the DAO method, it undergo authentification of password before executing account deletioin, all in one connection.
                if(UserDAO.deleteUser(DB, username, password)){

                    //Send the farewell message to the users after successful deletion LOLOLOL
                    int random = (int)(Math.random()*9+1);
                    String link ="";
                    switch (random){
                        case 1: link="https://s-media-cache-ak0.pinimg.com/736x/50/d5/8b/50d58b5eea2851b4e10c1b8b5f79edee.jpg";
                            break;
                        case 2: link="https://s-media-cache-ak0.pinimg.com/736x/06/dc/7f/06dc7f91a12f4a9d1ddf49f1fdaf9e60.jpg";
                            break;
                        case 3: link="http://www.quotehd.com/imagequotes/authors10/martin-niemoller-quote-in-germany-they-first-came-for-the-communists.jpg";
                            break;
                        case 4: link="https://s-media-cache-ak0.pinimg.com/736x/39/aa/4d/39aa4dc845241e1dc9afbecac16940bd.jpg";
                            break;
                        case 5: link="https://s-media-cache-ak0.pinimg.com/736x/39/aa/4d/39aa4dc845241e1dc9afbecac16940bd.jpg";
                            break;
                        case 6: link="http://i.dailymail.co.uk/i/pix/2016/12/01/01/3AE6A93D00000578-3988450-image-m-20_1480554199376.jpg";
                            break;
                        case 7: link="http://i.dailymail.co.uk/i/pix/2016/12/01/02/3AE6A8E900000578-3988450-While_others_had_the_words_right_but_decorated_the_cake_in_the_s-a-9_1480560680314.jpg";
                            break;
                        case 8: link="https://s-media-cache-ak0.pinimg.com/736x/5e/86/e4/5e86e4e089b58d0bcb037c3ef35bf5b3.jpg";
                            break;
                        case 9: link="https://s-media-cache-ak0.pinimg.com/736x/9c/d8/84/9cd884a87a198fbc1f24e43d0ba340f0.jpg";
                            break;

                    }

                    response.sendRedirect(link);
                    /*request.setAttribute("message", "The username you have registered already exists");
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/login_interface/Login.jsp");
                    dispatcher.forward(request, response);*/
                }
            }


        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
