package Article;

import Utility.AbstractDB;
import Utility.MySQL;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;




public class ArticleDAO {

    // Method to return all Articles with brief information from the Articles table in database as an ArrayList from the database.
    public static List<Article> getAllArticles(AbstractDB db) {

        List<Article> articles = new ArrayList<>();

        try (Connection c = db.connection()) {
            PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_Articles");
                ResultSet r = p.executeQuery();
                    while (r.next()) articles.add(fullArticleFromResultSet(r, c));
                } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return articles;
    }

    // Method to return all Articles with brief information from the Articles table in database by Author as an ArrayList from the database.
    public static List<Article> getArticlesByUser(AbstractDB db, String username) {

        List<Article> articles = new ArrayList<>();

        try (Connection c = db.connection()) {
            PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_Articles WHERE username = ?");
                p.setString(1, username);
                ResultSet r = p.executeQuery();
                    while (r.next()) articles.add(fullArticleFromResultSet(r, c));
                }
         catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return articles;
    }

    // Method to return a complete article relating to the parsed-in article ID, from the database, with all comments and replies that is under the article.
    //This method made several calls of other methods in order to collect all the relevent comment and replies as list to return a full article object.
    public static Article getArticleById(AbstractDB db, int articleId) {
        try (Connection c = db.connection()) {

           PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_Articles WHERE ID = ?");
                p.setInt(1, articleId);
                ResultSet r = p.executeQuery();
                    while (r.next()) {
                        return fullArticleFromResultSet(r, c);
                    }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Method to return a complete comment relating to the parsed-in article ID, from the database, with all replies that is under the article.
    public static Comment getCommentById(AbstractDB db, int commentId) {
        try (Connection c = db.connection()) {
            PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_Comments WHERE ID = ?");
                p.setInt(1, commentId);
                ResultSet r = p.executeQuery();
                    while (r.next()) {
                        return commentFromResultSet(r, c);
                    }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Reply getReplyById(AbstractDB db, int replyId) {
        try (Connection c = db.connection()) {
           PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_Replies WHERE ID = ?");
                p.setInt(1, replyId);
                ResultSet r = p.executeQuery();
                    while (r.next()) {
                        return replyFromResultSet(r, c);
                    }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }




//get all comments under the particular article, this function is part of the get fullarticle method.
    private static List<Comment> getArticleComments(int articleId, Connection c) throws SQLException {
        List<Comment> comments = new ArrayList<>();

        PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_Comments WHERE parent_ID = ?");
            p.setInt(1, articleId);
           ResultSet r = p.executeQuery();
                while (r.next()) {
                    comments.add(commentFromResultSet(r, c));
        }
        System.out.println("got comments");
        return comments;
    }

    private static List<Reply> getCommentReplies(int commentId, Connection c) throws SQLException {
        List<Reply> replies = new ArrayList<>();

        PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_Replies WHERE parent_ID = ?");
            p.setInt(1, commentId);
           ResultSet r = p.executeQuery();
                while (r.next()) {
                    replies.add(replyFromResultSet(r, c));
        }
        System.out.println("got replies");
        return replies;
    }


    // Method to insert a parsed-in Article, Comment & Reply into the database.
    public static boolean createNewText(AbstractDB db, Text newText, int parentId) {
        String statement1 = "INSERT INTO #1 (username, content, #2";
        String injection1 = "";
        String statement2 = ") VALUE (?, ?, ?";
        String injection2 = "";
        String statement3 = ")";

        if (parentId == -1) {
            statement1 = statement1.replaceFirst("#1", "inFoJaxs_Articles");
            statement1 = statement1.replaceFirst("#2", "title");
            injection1 = ", shortIntro";
            injection2 = ", ?";
        } else {
            if (newText instanceof Comment)
                statement1 = statement1.replaceFirst("#1","inFoJaxs_Comments");
            else if (newText instanceof Reply)
                statement1 = statement1.replaceFirst("#1","inFoJaxs_Replies");
            statement1 = statement1.replaceFirst("#2","parent_ID");
        }

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement(statement1 + injection1 + statement2 + injection2 + statement3)) {

                if (parentId == -1) {
                    p.setString(3, ((Article) newText).getTitle());
                    p.setString(4, ((Article) newText).getShortIntro());
                } else p.setInt(3, parentId);

                p.setString(1, newText.getAuthor());
                p.setString(2, newText.getText());
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
        String statement1 = "UPDATE #1 SET content = ?, lastEdit = ?";
        String injection = " ";
        String statement2 = "WHERE ID = ?";

        boolean article = false;
        int id = 3;

        if (text instanceof  Article) {
            injection = ", title = ?, shortIntro = ? ";
            statement1 = statement1.replaceFirst("#1", "inFoJaxs_Articles");
            article = true;
            id = 5;
        } else if (text instanceof Comment) statement1 = statement1.replaceFirst("#1","inFoJaxs_Comments");
        else if (text instanceof Reply) statement1 = statement1.replaceFirst("#1","inFoJaxs_Replies");

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement(statement1 + injection + statement2)) {
                p.setString(1, text.getText());
                p.setString(2, new Timestamp(System.currentTimeMillis()).toString());
                if (article) {
                    p.setString(3, ((Article) text).getTitle());
                    p.setString(4, ((Article) text).getShortIntro());
                }
                p.setInt(id, text.getId());
                p.executeUpdate();
                return true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }


    // Methods to return Article/Comment/Reply instances from the information stored in the ResultSet.
    private static Article fullArticleFromResultSet(ResultSet r, Connection c) throws SQLException {
        int id = r.getInt("ID");
        //(int id, String author, String title, String text, String shortIntro, List<Comment> comments,  int likes, int view, String dateCreated, String dateLastEdited)//
        return new Article(
                id,
                r.getString("username"),
                r.getString("title"),
                r.getString("content"),
                r.getString("shortIntro"),
                getArticleComments(id, c),
                r.getInt("likes"),
                r.getInt("views"),
                r.getTimestamp("creationDate").toString(),
                r.getTimestamp("lastEdit").toString());
    }

    private static Comment commentFromResultSet(ResultSet r, Connection c) throws SQLException {
        int commentId = r.getInt("ID");
//        (int id, String author, String text, List<Reply> replies, int likes, int views,  String dateCreated, String dateLastEdited)
        return new Comment(
                commentId,
                r.getInt("parent_ID"),
                r.getString("username"),
                r.getString("content"),
                getCommentReplies(commentId, c),
                r.getInt("likes"),
                r.getInt("views"),
                r.getTimestamp("creationDate").toString(),
                r.getTimestamp("lastEdit").toString());
    }

    private static Reply replyFromResultSet(ResultSet r, Connection c) throws SQLException {
        int replyId = r.getInt("ID");
//        (int id, String author, String text,  int likes, int views, String dateCreated, String dateLastEdited)
        return new Reply(
                replyId,
                r.getInt("parent_ID"),
                r.getString("username"),
                r.getString("content"),
                r.getInt("likes"),
                // getTextLikes(c, replyId,"Reply")),
                r.getInt("views"),
                r.getTimestamp("creationDate").toString(),
                r.getTimestamp("lastEdit").toString());
    }

    // Method to delete the Article, Comment, Reply in the database.
    public static boolean deleteText(Connection c, int textId, String textClassName) throws SQLException {

        String statement = "DELETE FROM #1 WHERE #2 = ?";

        switch (textClassName) {
            case "Article":
                statement = statement.replaceFirst("#1", "inFoJaxs_Articles");
                statement = statement.replaceFirst("#2", "ID");

                // Add ON DELETE CASCADE to SQL database
                /*deleteText(c, textId, "ArticleChildren");
                break;

            case "ArticleChildren":
                statement = statement.replaceFirst("#1", "inFoJaxs_Comments");
                statement = statement.replaceFirst("#2", "parent_ID");
                for (Comment comment : getArticleComments(textId, c))
                    deleteText(c, comment.getId(), "CommentChildren");
                break;*/

            case "Comment":
                statement = statement.replaceFirst("#1", "inFoJaxs_Comments");
                statement = statement.replaceFirst("#2", "ID");

                // Add ON DELETE CASCADE to SQL database
                /*deleteText(c, textId, "CommentChildren");
                break;

            case "CommentChildren":
                statement = statement.replaceFirst("#1", "inFoJaxs_Replies");
                statement = statement.replaceFirst("#2", "parent_ID");
                break;*/

            case "Reply":
                statement = statement.replaceFirst("#1", "inFoJaxs_Replies");
                statement = statement.replaceFirst("#2", "ID");
                break;
        }
        System.out.println(statement);

        PreparedStatement p = c.prepareStatement(statement);
        p.setInt(1, textId);
        p.executeUpdate();
        return true;
    }


    // Method to increase one view for article.
    public static void increaseViews(AbstractDB db, int articleId) {
        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("UPDATE inFoJaxs_Articles SET views = views + 1 WHERE ID = ?")) {
                p.setInt(1, articleId);
                p.executeUpdate();
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }



    // Legacy create text methods


    /*public static boolean createNewArticle(AbstractDB db, Article article) {
        boolean success;

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("INSERT INTO inFoJaxs_Articles (username, content, title, shortIntro) VALUE (?, ?, ?, ?)")) {
                p.setString(1, article.getAuthor());
                p.setString(2, article.getText());
                p.setString(3, article.getTitle());
                p.setString(4, article.getShortIntro());
                p.executeUpdate();
                success = true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            success = false;
        }
        return success;

    }

    public static boolean createNewComment(AbstractDB db, Comment comment) {
        boolean success;
        //Comment(String author, String text, int parentID)//
        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("INSERT INTO inFoJaxs_Comments (parent_ID, username, content) VALUE ( ?, ?, ?)")) {
                p.setInt(1, comment.getParentID());
                p.setString(2, comment.getAuthor());
                p.setString(3, comment.getText());
                p.executeUpdate();
                success = true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            success = false;
        }
        return success;

    }

    public static boolean createNewReply(AbstractDB db, Reply reply) {
        boolean success;
        //Comment(String author, String text, int parentID)//
        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("INSERT INTO inFoJaxs_Replies (parent_ID, username, content) VALUE (?, ?, ?)")) {
                p.setInt(1, reply.getParentID());
                p.setString(2, reply.getAuthor());
                p.setString(3, reply.getText());
                p.executeUpdate();
                success = true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            success = false;
        }
        return success;

    }*/

    // Legacy update text methods

    /*public static boolean updateArticle(AbstractDB db, Article article) {
        boolean status;

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("UPDATE inFoJaxs_Articles SET title = ?, content = ?, shortIntro = ?, lastEdit = ? WHERE ID = ?;")) {
                p.setString(1, article.getTitle());
                p.setString(2, article.getText());
                p.setString(3, article.getShortIntro());
                p.setString(4, new Timestamp(System.currentTimeMillis()).toString());
                p.setInt(5, article.getId());
                p.executeUpdate();
                status = true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            status = false;
        }
        return status;
    }


    public static boolean updateComment(AbstractDB db, Comment comment) {
        boolean status;

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("UPDATE inFoJaxs_Comments SET content = ?, lastEdit = ? WHERE ID = ?;")) {
                //p.setString(1, colunm);
                p.setString(1, comment.getText());
                p.setString(2, new Timestamp(System.currentTimeMillis()).toString());
                p.setInt(3, comment.getId());
                p.executeUpdate();
                status = true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            status = false;
        }
        return status;
    }


    public static boolean updateReply(AbstractDB db, Reply reply) {
        boolean status;

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("UPDATE inFoJaxs_Replies SET content = ?,lastEdit = ? WHERE ID = ?;")) {
                //p.setString(1, colunm);
                p.setString(1, reply.getText());
                p.setString(2, new Timestamp(System.currentTimeMillis()).toString());
                p.setInt(3, reply.getId());
                p.executeUpdate();
                status = true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            status = false;
        }
        return status;
    }*/



    // Legacy delete text methods

    /*public static boolean deleteArticle(AbstractDB db, int articleID) {
        boolean success = false;
        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("DELETE FROM inFoJaxs_Articles WHERE ID = ?;")) {
                //p.setString(1, colunm);
                p.setInt(1, articleID);
                p.executeUpdate();
                success = true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            success = false;
        }
        return success;
    }


    public static boolean deleteComment(AbstractDB db, int commentID) {
        boolean success = false;
        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("DELETE FROM inFoJaxs_Comments WHERE ID = ?;")) {
                //p.setString(1, colunm);
                p.setInt(1, commentID);
                p.executeUpdate();
                success = true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            success = false;
        }
        return success;
    }


    public static boolean deleteReply(AbstractDB db, int replyID) {
        boolean success = false;
        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("DELETE FROM inFoJaxs_Replies WHERE ID = ?;")) {
                //p.setString(1, colunm);
                p.setInt(1, replyID);
                p.executeUpdate();
                success = true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            success = false;
        }
        return success;
    }*/



    // Legacy article instance

    /*private static Article articleSummaryFromResultSet(ResultSet r) throws SQLException {

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
    }*/


    // Legacy Likes code:

    /* private static int getTextLikes( Connection c, int textId, String textClassName) throws SQLException {
        String statement = "SELECT likes FROM #1 WHERE ID = ?";
        statement.replaceFirst("#1", likesTableSelector(textClassName));

        try (PreparedStatement p = c.prepareStatement(statement)) {
            p.setInt(1, textId);
            try (ResultSet r = p.executeQuery()) {
                while (r.next()) {
                    return r.getInt("likes");
                }
            }
            return 0;
        }
    }*/

    // Methods to update or delete the Article, Comment, Reply in the database.
   /* private static boolean deleteLikes(AbstractDB db, int textId, String textClassName) {
        String statement = "DELETE FROM #1 WHERE ID = ?";
        return executeLikesUpdate(db, textId, textClassName, statement);
    }*/

    /*public static boolean updateLikes(AbstractDB db, int textId, String textClassName) {
        String statement = "UPDATE #1 SET likes = likes + 1 WHERE ID = ?";
        return executeLikesUpdate(db, textId, textClassName, statement);
    }

    private static boolean executeLikesUpdate(AbstractDB db, int textId, String textClassName, String statement) {
        statement.replaceFirst("#1", likesTableSelector(textClassName));

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
    }*/
}
