package Article;

import Utility.AbstractDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ArticleDAO {

    // Method to return all Articles as an ArrayList from the database.
    public static List<Article> getAllArticles(AbstractDB db) {

        List<Article> articles = new ArrayList<>();

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_Articles")) {
                try (ResultSet r = p.executeQuery()) {
                    while (r.next()) {
                        articles.add(articleFromResultSet(r, c));
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return articles;
    }

    // Method to return all Articles by Author as an ArrayList from the database.
    public static List<Article> getArticlesByUser(String username, AbstractDB db) {

        List<Article> articles = new ArrayList<>();

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_Articles WHERE username = ?")) {
                p.setString(1, username);
                try (ResultSet r = p.executeQuery()) {
                    while (r.next()) {
                        articles.add(articleFromResultSet(r, c));
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return articles;
    }

    // Method to return an article relating to the parsed-in article ID, from the database.
    public static Article getArticleById(AbstractDB db, int articleId) {
        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_Articles WHERE ID = ?")) {
                p.setInt(1, articleId);
                try (ResultSet r = p.executeQuery()) {
                    while (r.next()) {
                        return articleFromResultSet(r, c);
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Method to insert a parsed-in Article, Comment & Reply into the database.
    public static boolean createNewText(AbstractDB db, Article newArticle) {
        return createNewText(db, newArticle, -1);
    }

    public static boolean createNewText(AbstractDB db, Text newText, int parentId) {

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("INSERT INTO ? (?, username, content) VALUE (?, ?, ?)")) {

                if (parentId == -1) {
                    p.setString(1,"inFoJaxs_Articles");
                    p.setString(2, "title");
                    p.setString(3, ((Article) newText).getTitle());
                } else {
                    if (newText instanceof Comment) p.setString(1,"inFoJaxs_Comments");
                    else if (newText instanceof Reply) p.setString(1,"inFoJaxs_Replies");
                    p.setString(2,"parent_ID");
                    p.setInt(3,parentId);
                }

                p.setString(4, newText.getAuthor());
                p.setString(5, newText.getText());
                p.executeUpdate();
                return true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Methods to update the parsed-in Article, Comment, Reply in the database.
    public static boolean updateText(AbstractDB db, Text text) {
        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("UPDATE ? SET ? content = ? WHERE ID = ?")) {
                if (text instanceof  Article) {
                    p.setString(1,"inFoJaxs_Articles");
                    p.setString(2,"title = " + ((Article) text).getTitle() + ",");
                } else if (text instanceof Comment)
                    p.setString(1,"inFoJaxs_Comments");
                else if (text instanceof Reply)
                    p.setString(1,"inFoJaxs_Replies");
                p.setString(3, text.getText());
                p.setInt(4, text.getId());
                p.executeUpdate();
                return true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to delete the Article, Comment, Reply in the database.
    public static boolean deleteText(AbstractDB db, String textClassName, int textId) {
        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("DELETE FROM ? WHERE ID = ?")) {
                switch (textClassName){
                    case "Article":
                        p.setString(1,"inFoJaxs_Articles");
                    case "Comment":
                        p.setString(1,"inFoJaxs_Comments");
                    case "Reply":
                        p.setString(1,"inFoJaxs_Replies");
                }
                p.setInt(2, textId);
                p.executeUpdate();
                return true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    private static List<Comment> getArticleComments(int articleId, Connection c) throws SQLException {
        List<Comment> comments = new ArrayList<>();

        try (PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_Comments WHERE article_ID = ?")) {
            p.setInt(1, articleId);
            try (ResultSet r = p.executeQuery()) {
                while (r.next()) {
                    comments.add(commentFromResultSet(r,c));
                }
            }
        }
        return comments;
    }

    private static List<Reply> getCommentReplies(int commentId, Connection c) throws SQLException {
        List<Reply> comments = new ArrayList<>();

        try (PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_Replies WHERE comment_ID = ?")) {
            p.setInt(1, commentId);
            try (ResultSet r = p.executeQuery()) {
                while (r.next()) {
                    comments.add(replyFromResultSet(r, c));
                }
            }
        }
        return comments;
    }

    // Methods to create a new Article/Comment/Reply objects from the information stored in the ResultSet.
    private static Article articleFromResultSet(ResultSet r, Connection c) throws SQLException {
        int articleId = r.getInt("ID");

        return new Article(
                articleId,
                r.getString("username"),
                r.getString("title"),
                r.getString("content"),
                getArticleComments(articleId, c),
                r.getString("creationDate"),
                r.getString("lastEdited"),
                getTextLikes(c, articleId,"Article"));
    }

    private static Comment commentFromResultSet(ResultSet r, Connection c) throws SQLException {
        int commentId = r.getInt("ID");

        return new Comment(
                commentId,
                r.getString("username"),
                r.getString("content"),
                getCommentReplies(commentId, c),
                r.getString("creationDate"),
                r.getString("lastEdited"),
                getTextLikes(c, commentId,"Comment"));
    }

    private static Reply replyFromResultSet(ResultSet r, Connection c) throws SQLException {
        int replyId = r.getInt("ID");

        return new Reply(
                replyId,
                r.getString("username"),
                r.getString("content"),
                r.getString("creationDate"),
                r.getString("lastEdited"),
                getTextLikes(c, replyId,"Reply"));
    }


    private static int getTextLikes( Connection c, int textId, String textClassName) throws SQLException {
        try (PreparedStatement p = c.prepareStatement("SELECT likes FROM inFoJaxs_"+ textClassName+"Likes WHERE ID = ?")) {
            p.setInt(1, textId);
            try (ResultSet r = p.executeQuery()) {
                while (r.next()) {
                    return r.getInt("likes");
                }
            }
            return 0;
        }
    }

    public static boolean updateTextLikes(AbstractDB db, int articleId, String textClassName) {
        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("UPDATE inFoJaxs_" + textClassName + "Likes SET likes = likes + 1 WHERE ID = ?")) {
                p.setInt(1, articleId);
                p.executeUpdate();
                return true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }
}
