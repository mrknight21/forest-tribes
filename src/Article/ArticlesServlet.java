package Article;

import Utility.MySQL;
import org.json.simple.JSONObject;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Enumeration;

public class ArticlesServlet extends HttpServlet {

    private static final MySQL db = new MySQL();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setAttribute("message", "Profile updated successfully!!");
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/profile.jsp");
        try {
            dispatcher.forward(request, response);
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {

        HttpSession session = request.getSession();
        String username = (String)session.getAttribute("username");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        int parentId = Integer.parseInt(request.getParameter("parentId"));
        int textId = Integer.parseInt(request.getParameter("textId"));

        if (request.getParameter("newText") != null)
            switch (request.getParameter("newText")){
                case "article":
                    ArticleDAO.createNewText(db, new Article(username, title, content));
                    break;
                case "comment":
                    ArticleDAO.createNewText(db, new Comment(username, content), parentId);
                    break;
                case "reply":
                    ArticleDAO.createNewText(db, new Reply(username, content), parentId);
            }
        else if (request.getParameter("editText") != null)
            switch (request.getParameter("editText")){
                case "article":
                    ArticleDAO.updateText(db, new Article(textId, username, title, content));
                    break;
                case "comment":
                    ArticleDAO.updateText(db, new Comment(textId, username, content));
                    break;
                case "reply":
                    ArticleDAO.updateText(db, new Reply(textId, username, content));
            }
        else if (request.getParameter("deleteText") != null)
            ArticleDAO.deleteText(db, request.getParameter("deleteText"), textId);
        else if (request.getParameter("likeText") != null)
            ArticleDAO.updateTextLikes(db,textId,request.getParameter("likeText"));

        try {
            doGet(request, response);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}


/*
* doPost:
*
* Articles || Comments || replies
*
*
* Receive new articles in servlet request.
* Receive new comments in servlet request.
* Save to JSON
*
* doGet:
* For contents page - get user articles list from servlet and send to JSP.
* For article page - get article and comments from servlet and send to JSP.
*
* Same for comments, but load comments asynchronously with AJAX?
*
* */