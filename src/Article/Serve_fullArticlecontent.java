package Article;

import Utility.MySQL;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by mche618 on 10/06/2017.
 */
public class Serve_fullArticlecontent extends HttpServlet {


    private static final MySQL DB = new MySQL();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int id =0;

        try{
            id = Integer.parseInt(request.getParameter("articleID"));
        }catch (NumberFormatException e){
            System.out.println("wrong format of article ID");
        }

        Article article = ArticleDAO.getArticleById(DB, id);
        request.setAttribute("article", article);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/article_display/DisplayFullArticle.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {

    }


    }
