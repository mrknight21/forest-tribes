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
 *
 * A multi-purposes servelet dealing with different article relating requests.
 *
 */
public class ArticleServlet extends HttpServlet {

    private static final MySQL DB = new MySQL();
    private int id;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            //checking login status
            if (!SecurityUtility.loggingStatusChecker(request)) {
                response.sendRedirect("login_interface/Login.jsp");
                return;
                //checking form not empty.
            } else if (!request.getParameterNames().hasMoreElements()) {
                response.sendRedirect("user_interface/Home.jsp");
                return;
            } else {

                //getting all available parameters
                List<String> params = Collections.list(request.getParameterNames());
                String username = getUsername(request);


                //Identify the purpose of the request: create ,update, delete.  Inside each request, identify text types from: Article, comment or reply. Article has
                // no parent ID or has parent ID as "-1".
                //Appropriate DAO functions are called in accordance to the types and request identified.
                chooser:
                for (String parameter : params) {
                    if (parameter.startsWith("create")) {
                        if (parameter.endsWith("Article")) {
                            createArticle(request);
                            //if article has been successfully created, sent to the User's article list. The new article should already be added into the collection.
                            response.sendRedirect("article_display/DisplayUserAllArticles.jsp?author="+username);
                            return;
                        } else {
                            //comment and reply have parent ID.
                            id = Integer.parseInt(request.getParameter("parentId"));
                            switch (parameter) {
                                case "createComment":
                                    createComment(request);
                                    break chooser;
                                case "createReply":
                                    createReply(request);
                                    break chooser;
                            }
                        }
                    } else {
                        if (parameter.startsWith("update")) {
                            id = Integer.parseInt(request.getParameter("id"));
                            System.out.println(id);
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
                                        response.sendRedirect("article_display/DisplayUserAllArticles.jsp?author="+username);
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
                }
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/article_display/DisplayFullArticle.jsp");
                dispatcher.forward(request, response);
//                getServletContext().getRequestDispatcher("/article_display/DisplayFullArticle.jsp").forward(request, response);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    //functions that collect data then combine and construct appropriate text types.
    private boolean createReply(HttpServletRequest request) {
        createNewText(
                DB,
                new Reply(
                        getUsername(request),
                        request.getParameter("text"),
                        id),
                id);
        return false;
    }

    private boolean createComment(HttpServletRequest request) {
        createNewText(
                DB,
                new Comment(
                        getUsername(request),
                        request.getParameter("text"),
                        id),
                id);
        return false;
    }

    private boolean createArticle(HttpServletRequest request) {
        createNewText(
                DB,
                new Article(
                        getUsername(request),
                        request.getParameter("title"),
                        request.getParameter("text"),
                        request.getParameter("summary")),
                -1);
        return true;
    }

    private boolean editReply(HttpServletRequest request) {
        if (getUsername(request).equals(getReplyById(DB, id).getAuthor())) {
            updateText(
                    DB,
                    new Reply(
                            id,
                            request.getParameter("text")));
            return true;
        } else return false;
    }

    private boolean editComment(HttpServletRequest request) {
        if (getUsername(request).equals(getCommentById(DB, id).getAuthor())) {
            updateText(
                    DB,
                    new Comment(
                            id,
                            request.getParameter("text")));
            return true;
        } else return false;
    }

    private boolean editArticle(HttpServletRequest request) {
        if (getUsername(request).equals(getArticleById(DB, id).getAuthor()))
        updateText(
                    DB,
                    new Article(Integer.parseInt(request.getParameter("id")),
                            request.getParameter("text"),
                            request.getParameter("title"),
                            request.getParameter("summary")));
        return true;
    }

    private String getUsername(HttpServletRequest request) {
        return (String) request.getSession().getAttribute("username");
    }
}