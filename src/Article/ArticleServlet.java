package Article;

import Utility.MySQL;
import Utility.SecurityUtility;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

import static Article.ArticleDAO.*;

/**
 * Created by mche618 on 10/06/2017.
 */
public class ArticleServlet extends HttpServlet {

    private static final MySQL DB = new MySQL();
    private int id;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);

//        if (!SecurityUtility.loggingStatusChecker(request)) {
//            response.sendRedirect("login_interface/Login.jsp");
//            return;
//        } else if (!request.getParameterNames().hasMoreElements()) {
//            response.sendRedirect("user_interface/Home.jsp");
//            return;
//        }
//
//        int id = 0;
//
//        try {
//            id = Integer.parseInt(request.getParameter("article_id"));
//        } catch (NumberFormatException e) {
//            System.out.println("wrong format of article ID");
//        }
//
//        Article article = ArticleDAO.getArticleById(DB, id);
//        request.setAttribute("article", article);
//        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/article_display/DisplayFullArticle.jsp");
//        dispatcher.forward(request, response);
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
                String username = getUsername(request);

                chooser:
                for (String parameter : params) {
                    if (parameter.startsWith("create"))
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
                        }
                    else if (parameter.startsWith("update")) {
                        id = Integer.parseInt(request.getParameter("id"));
                        switch (parameter) {
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
                    } else if (parameter.startsWith("delete")) {
                        id = Integer.parseInt(request.getParameter("id"));
                        try {
                            switch (parameter) {
                                case "deleteArticle":
                                    if (username.equals(getArticleById(DB, id).getAuthor()))
                                        deleteText(DB.connection(), id, "Article");
                                    response.sendRedirect("article_display/DisplayUserAllArticles.jsp");
                                    return;
                                case "deleteComment":
                                    Comment comment = getCommentById(DB, id);
                                    Article article = getArticleById(DB, comment.getParentID());
                                    if (username.equals(comment.getAuthor()) || username.equals(article.getAuthor()))
                                        deleteText(DB.connection(), id, "Comment");
                                    break chooser;
                                case "deleteReply":
                                    Reply reply = getReplyById(DB, id);
                                    if (username.equals(getArticleById(DB, getCommentById(DB, reply.getParentID()).getParentID()).getAuthor())
                                            || username.equals(reply.getAuthor()))
                                        deleteText(DB.connection(), id, "Reply");
                                    break chooser;
                            }
                        } catch (ClassNotFoundException | SQLException e) {
                            e.printStackTrace();
                        }

                    }
                }
                getServletContext().getRequestDispatcher("/article_display/DisplayFullArticle.jsp").forward(request, response);
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
        System.out.println(request.getParameter("text"));
        createNewArticle(
                DB,
                new Article(
                        getUsername(request),
                        request.getParameter("title"),
                        request.getParameter("text")));

        return true;
    }

    private boolean editReply(HttpServletRequest request) {
        if (getUsername(request).equals(getReplyById(DB, id).getAuthor())) {
            updateReply(
                    DB,
                    new Reply(
                            id,
                            request.getParameter("text")));
            return true;
        } else return false;
    }

    private boolean editComment(HttpServletRequest request) {
        if (getUsername(request).equals(getCommentById(DB, id).getAuthor())) {
            updateComment(
                    DB,
                    new Comment(
                            id,
                            request.getParameter("text")));
            return true;
        } else return false;
    }

    private boolean editArticle(HttpServletRequest request) {
        if (getUsername(request).equals(getArticleById(DB, id).getAuthor()))
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