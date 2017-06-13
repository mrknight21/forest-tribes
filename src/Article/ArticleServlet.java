package Article;

import Utility.MySQL;
import Utility.SecurityUtility;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collections;
import java.util.List;

import static Article.ArticleDAO.*;

/**
 * Created by mche618 on 10/06/2017.
 */
public class ArticleServlet extends HttpServlet {

    private static final MySQL DB = new MySQL();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int id = 0;

        try {
            id = Integer.parseInt(request.getParameter("articleID"));
        } catch (NumberFormatException e) {
            System.out.println("wrong format of article ID");
        }

        Article article = ArticleDAO.getArticleById(DB, id);
        request.setAttribute("article", article);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/article_display/DisplayFullArticle.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            if (!SecurityUtility.loggingStatusChecker(request)) {
                response.sendRedirect("login_interface/Login.jsp");
                return;
            } else if (!request.getParameterNames().hasMoreElements()) {
                response.sendRedirect("user_interface/Home.jsp");
                return;
            } else {

                List<String> params = Collections.list(request.getParameterNames());

                chooser:
                for (String parameter : params) {
                    switch (parameter) {
                        case "createArticle":
                            createArticle(request);
                            response.sendRedirect("article_display/DisplayUserAllArticles.jsp");
                            return;
                        case "createComment":
                            createComment(request);
                            break chooser;
                        case "createReply":
                            createReply(request);
                            break chooser;
                        case "updateArticle":
                            editArticle(request);
                            break chooser;
                        case "updateComment":
                            editComment(request);
                            break chooser;
                        case "updateReply":
                            editReply(request);
                            break chooser;
                    }
                }
                response.sendRedirect("article_display/DisplayFullArticle.jsp?article_id=" + request.getParameter("article_id"));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            if (!SecurityUtility.loggingStatusChecker(request)) {
                response.sendRedirect("login_interface/Login.jsp");
                return;
            } else if (!request.getParameterNames().hasMoreElements()) {
                response.sendRedirect("user_interface/Home.jsp");
                return;
            } else {

                List<String> params = Collections.list(request.getParameterNames());

                String username = getUsername(request);

                chooser:
                for (String parameter : params) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    switch (parameter) {
                        case "deleteArticle":
                            if (username.equals(getArticleById(DB,id).getAuthor()))
                                deleteText(DB, id, "Article");
                            break chooser;
                        case "deleteComment":
                            Comment comment = getCommentById(DB, id);
                            if (username.equals(getArticleById(DB, getCommentById(DB, id).getParentID()).getAuthor())
                                    || username.equals(comment.getAuthor()))
                                deleteText(DB, id, "Comment");
                            break chooser;
                        case "deleteReply":
                            Reply reply = getReplyById(DB,id);
                            if (username.equals(getArticleById(DB, getCommentById(DB, reply.getParentID()).getParentID()).getAuthor())
                                    || username.equals(reply.getAuthor()))
                                deleteText(DB, id, "Reply");
                            break chooser;
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private boolean createReply(HttpServletRequest request) {
        createNewReply(
                DB,
                new Reply(
                        getUsername(request),
                        request.getParameter("text"),
                        Integer.parseInt(request.getParameter("parentId"))));
        return false;
    }

    private boolean createComment(HttpServletRequest request) {
        createNewComment(
                DB,
                new Comment(
                        getUsername(request),
                        request.getParameter("text"),
                        Integer.parseInt(request.getParameter("parentId"))));
        return false;
    }

    private boolean createArticle(HttpServletRequest request) {
        createNewArticle(
                DB,
                new Article(
                        getUsername(request),
                        request.getParameter("title"),
                        request.getParameter("text")));

        return true;
    }

    private boolean editReply(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        if (getUsername(request).equals(getReplyById(DB,id).getAuthor())) {
            updateReply(
                    DB,
                    new Reply(
                            id,
                            request.getParameter("text")));
            return true;
        } else return false;
    }

    private boolean editComment(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        if (getUsername(request).equals(getCommentById(DB,id).getAuthor())) {
            updateComment(
                    DB,
                    new Comment(
                            id,
                            request.getParameter("text")));
            return true;
        } else return false;
    }

    private boolean editArticle(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        if (getUsername(request).equals(getArticleById(DB,id).getAuthor()))
        updateArticle(
                DB,
                new Article(request.getParameter("id"),
                        request.getParameter("title"),
                        request.getParameter("text")));
        return true;
    }

    private String getUsername(HttpServletRequest request) {
        return (String) request.getSession().getAttribute("username");
    }
}