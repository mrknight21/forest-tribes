package Article;

import Utility.MySQL;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ArticlesServlet extends HttpServlet {

    private static final MySQL db = new MySQL();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException {

        switch (request.getParameter("get")){
            case "openArticle":
                request.setAttribute("article", ArticleDAO.getArticleById(db, Integer.parseInt(request.getParameter("articleId"))));
                break;
            case "userArticles":
                request.setAttribute("articles", ArticleDAO.getArticlesByUser(db, request.getParameter("author")));
                break;
            case "allArticles":
                request.setAttribute("articles", ArticleDAO.getAllArticles(db));
        }

        dispatchToJSP(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {

        String username = (String) request.getSession().getAttribute("username");

        String newText = request.getParameter("newText");
        String editText = request.getParameter("editText");
        String deleteText = request.getParameter("deleteText");
        String likeText = request.getParameter("likeText");

        String title = request.getParameter("title");
        String content = request.getParameter("content");
        Text text = new Text(){};

        if (newText != null) {
            int parentId = Integer.parseInt(request.getParameter("parentId"));
            switch (newText){
                case "article":
                    text = new Article(username, title, content);
                    parentId = -1;
                    break;
                case "comment":
                    text = new Comment(username, content);
                    break;
                case "reply":
                    text = new Reply(username, content);
                    break;
            }
            ArticleDAO.createNewText(db, text, parentId);
        }
        else {
            int textId = Integer.parseInt(request.getParameter("textId"));
            if (editText != null) {
                switch (editText){
                    case "article":
                        text = new Article(textId, username, title, content);
                        break;
                    case "comment":
                        text = new Comment(textId, username, content);
                        break;
                    case "reply":
                        text = new Reply(textId, username, content);
                }
                ArticleDAO.updateText(db, text);
            }
            else if (deleteText != null)
                ArticleDAO.deleteText(db, textId, deleteText);
            else if (likeText != null)
                ArticleDAO.updateLikes(db, textId , likeText);
        }

        doGet(request,response);
    }


    private void dispatchToJSP(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/article_display/display-articles.jsp");
        try {
            dispatcher.forward(request, response);
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