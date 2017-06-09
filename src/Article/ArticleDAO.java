package Article;

import Utility.AbstractDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


//http://alvinalexander.com/java/java-timestamp-example-current-time-now

public class ArticleDAO {

    // Method to return all Articles as an ArrayList from the database.
    public static List<Article> getAllArticles(AbstractDB db) {

        List<Article> articles = new ArrayList<>();

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_Articles")) {
                try (ResultSet r = p.executeQuery()) {
                    while (r.next()) {
                        articles.add(articleSummaryFromResultSet(r));
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return articles;
    }

    // Method to return all Articles by Author as an ArrayList from the database.
   public static List<Article> getArticlesByUser(AbstractDB db, String username) {

        List<Article> articles = new ArrayList<>();

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_Articles WHERE username = ?")) {
                p.setString(1, username);
                try (ResultSet r = p.executeQuery()) {
                    while (r.next()) {
                        articles.add(articleSummaryFromResultSet(r));
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
                        return fullArticleFromResultSet(r);
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Method to insert a parsed-in Article, Comment & Reply into the database.
    public static boolean createNewText(AbstractDB db, Text newText, int parentId) {
        String statement = "INSERT INTO $1 ($2, username, content) VALUE (?, ?, ?)";
        if (parentId == -1) {
            statement.replaceFirst("$1", "inFoJaxs_Articles");
            statement.replaceFirst("$2", "title");
        } else {
            if (newText instanceof Comment)
                statement.replaceFirst("$1","inFoJaxs_Comments");
            else if (newText instanceof Reply)
                statement.replaceFirst("$1","inFoJaxs_Replies");
            statement.replaceFirst("$2","parent_ID");
        }

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement(statement)) {
                if (parentId == -1) {
                    p.setString(1, ((Article) newText).getTitle());
                } else {
                    p.setInt(1, parentId);
                }
                p.setString(2, newText.getAuthor());
                p.setString(3, newText.getText());
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
        String statement = "UPDATE $1 SET $2content = ? WHERE ID = ?";
        if (text instanceof  Article) {
            statement.replaceFirst("$1", "inFoJaxs_Articles");
            statement.replaceFirst("$2", "title = " + ((Article) text).getTitle() + ", ");
        } else {
            statement.replaceFirst("$2","");
            if (text instanceof Comment)
                statement.replaceFirst("$1","inFoJaxs_Comments");
            else if (text instanceof Reply)
                statement.replaceFirst("$1","inFoJaxs_Replies");
        }

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement(statement)) {
                p.setString(1, text.getText());
                p.setInt(2, text.getId());
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
                    comments.add(commentFromResultSet(r, c));
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
    private static Article articleSummaryFromResultSet(ResultSet r) throws SQLException {

        //(int id, String author, String title, String text,int likes, int view, int commentsCount,  String shortIntro, String dateCreated, String dateLastEdited)//
        return new Article(
                r.getInt("ID"),
                r.getString("username"),
                r.getString("title"),
                r.getString("content"),
                r.getInt("likes"),
                r.getInt("views"),
                r.getInt("commentCount"),
                r.getString("shortIntro"),
                r.getTimestamp("creationDate").toString(),
                r.getTimestamp("lastEdit").toString());
    }



    private static Article fullArticleFromResultSet(ResultSet r) throws SQLException {
        int id = r.getInt("ID");
        //(int id, String author, String title, String text,int likes, int view, int commentsCount,  String shortIntro, String dateCreated, String dateLastEdited)//
        return new Article(
                id,
                r.getString("username"),
                r.getString("title"),
                r.getString("content"),
                r.getInt("likes"),
                r.getInt("views"),
                r.getInt("commentCount"),
                r.getString("shortIntro"),
                r.getTimestamp("creationDate").toString(),
                r.getTimestamp("lastEdit").toString());
    }

    /*

    ID INT AUTO_INCREMENT,
  username VARCHAR(50) NOT NULL,
  title VARCHAR(80) NOT NULL,
  content VARCHAR (8000) NOT NULL,
  likes INT,
  views INT,
  commentCount INT,
  shortIntro VARCHAR(120),
  creationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  lastEdit TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
     */



    private static Comment commentFromResultSet(ResultSet r, Connection c) throws SQLException {
        int commentId = r.getInt("ID");
//        (int id, String author, String text, List<Reply> replies, int likes, int views,  String dateCreated, String dateLastEdited)
        return new Comment(
                commentId,
                r.getString("username"),
                r.getString("content"),
                getCommentReplies(commentId, c),
                r.getInt("likes"),
                r.getInt("views"),
                r.getString("creationDate"),
                r.getString("lastEdited"));
    }

    private static Reply replyFromResultSet(ResultSet r, Connection c) throws SQLException {
        int replyId = r.getInt("ID");
//        (int id, String author, String text,  int likes, int views, String dateCreated, String dateLastEdited)
        return new Reply(
                replyId,
                r.getString("username"),
                r.getString("content"),
                r.getInt("likes"),
                // getTextLikes(c, replyId,"Reply")),
                r.getInt("views"),
                r.getString("creationDate"),
                r.getString("lastEdited"));
    }


    private static int getTextLikes( Connection c, int textId, String textClassName) throws SQLException {
        String statement = "SELECT likes FROM $1 WHERE ID = ?";
        statement.replaceFirst("$1", likesTableSelector(textClassName));

        try (PreparedStatement p = c.prepareStatement(statement)) {
            p.setInt(1, textId);
            try (ResultSet r = p.executeQuery()) {
                while (r.next()) {
                    return r.getInt("likes");
                }
            }
            return 0;
        }
    }

    // Methods to update or delete the Article, Comment, Reply in the database.
    private static boolean deleteLikes(AbstractDB db, int textId, String textClassName) {
        String statement = "DELETE FROM $1 WHERE ID = ?";
        return executeLikesUpdate(db, textId, textClassName, statement);
    }

    public static boolean updateLikes(AbstractDB db, int textId, String textClassName) {
        String statement = "UPDATE $1 SET likes = likes + 1 WHERE ID = ?";
        return executeLikesUpdate(db, textId, textClassName, statement);
    }

    private static boolean executeLikesUpdate(AbstractDB db, int textId, String textClassName, String statement) {
        statement.replaceFirst("$1", likesTableSelector(textClassName));

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement(statement)) {
                p.setInt(1, textId);
                p.executeUpdate();
                return true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    private static String likesTableSelector(String textClassName) {
        switch (textClassName){
            case "Article":
                return "inFoJaxs_ArticleLikes";
            case "Comment":
                return "inFoJaxs_CommentLikes";
            case "Reply":
                return "inFoJaxs_ReplyLikes";
        }
        return null;
    }

    // Method to delete the Article, Comment, Reply in the database.
    public static boolean deleteText(AbstractDB db, int textId, String textClassName) {

        String statement = "DELETE FROM $1 WHERE $2 = ?";

        switch (textClassName){
            case "Article":
                statement.replaceFirst("$1", "inFoJaxs_Articles");
                statement.replaceFirst("$2", "ID");
                deleteText(db, textId, "ArticleChildren");
                break;

            case "ArticleChildren":
                statement.replaceFirst("$1","inFoJaxs_Comments");
                statement.replaceFirst("$2","article_ID");
                try {
                    for (Comment comment : getArticleComments(textId, db.connection())) {
                        deleteText(db, comment.getId(), "Comment");
                    }
                } catch (SQLException | ClassNotFoundException e) {
                    e.printStackTrace();
                }
                break;

            case "Comment":
                statement.replaceFirst("$1","inFoJaxs_Comments");
                statement.replaceFirst("$2","ID");
                deleteText(db, textId, "CommentChildren");
                break;

            case "CommentChildren":
                statement.replaceFirst("$1","inFoJaxs_Replies");
                statement.replaceFirst("$2","comment_ID");
                try {
                    for (Reply reply : getCommentReplies(textId, db.connection())) {
                        deleteText(db, reply.getId(), "Reply");
                    }
                } catch (SQLException | ClassNotFoundException e) {
                    e.printStackTrace();
                }
                break;

            case "Reply":
                statement.replaceFirst("$1","inFoJaxs_Replies");
                statement.replaceFirst("$2","ID");
                break;
        }

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement(statement)) {
                deleteLikes(db, textId, textClassName);
                p.setInt(1, textId);
                p.executeUpdate();
                return true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }
}
