package Article;

import User.User;
import Utility.AbstractDB;
import Utility.SecurityUtility;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static Utility.BlobConverter.getBlob;

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
    public static Article getArticle(AbstractDB db, int articleId) {
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

//    // Method to insert a parsed-in Article into the database.
//    public static boolean createNewArticle(AbstractDB db, Article article) {
//
//        boolean status;
//
//
//
//        try (Connection c = db.connection()) {
//            try (PreparedStatement p = c.prepareStatement("INSERT INTO inFoJaxs_Articles (username, title,first_name, last_name, email) VALUE (?, ?, ?, ?)")) {
//                p.setString(1, newUser.getUsername());
//                p.setString(2, newUser.getFirst_name());
//                p.setString(3, newUser.getLast_name());
//                p.setString(4, newUser.getEmail());
//
//                p.executeUpdate();
//                status = true;
//            }
//        } catch (SQLException | ClassNotFoundException e) {
//            e.printStackTrace();
//            status = false;
//        }
//
//        r.getString("title"), getArticleComments(id, c),id, r.getString("username"),r.getString("creationDate"), r.getString("lastEdited"), r.getString("text")
//
//        return status;
//    }
//
//    // Method to update the parsed-in Artciles's information in the database, relating to the parsed-in username.
//    public static boolean updateArticle(AbstractDB db, Article article) {
//
//        boolean status;
//
//        try (Connection c = db.connection()) {
//            try (PreparedStatement p = c.prepareStatement("UPDATE inFoJaxs_User SET username = ?, first_name = ?, last_name = ?, email = ? WHERE username = ?")) {
//                p.setString(1, user.getUsername());
//                p.setString(2, user.getFirst_name());
//                p.setString(3, user.getLast_name());
//                p.setString(4, user.getEmail());
//                p.setString(5, username);
//
//                p.executeUpdate();
//                status = true;
//            }
//        } catch (SQLException | ClassNotFoundException e) {
//            e.printStackTrace();
//            status = false;
//        }
//        return status;
//    }
/////Change password
//    public static boolean updatePassword(AbstractDB db, String username, String password) {
//
//        boolean status;
//
//        try (Connection c = db.connection()) {
//            try (PreparedStatement p = c.prepareStatement("UPDATE web_lab_19 SET salt = ?, iterations = ?, hash = ? WHERE username = ?")) {
//
//                char[] passwordArray = password.toCharArray();
//
//                byte[] salt = SecurityUtility.getNextSalt();
//                Blob saltBlob = getBlob(salt);
//
//                int iterations = 50000;
//
//                byte[] hash = SecurityUtility.hash(passwordArray, salt, iterations);
//                Blob hashBlob = getBlob(hash);
//
//                p.setBlob(1, saltBlob);
//                p.setInt(2, iterations);
//                p.setBlob(3, hashBlob);
//                p.setString(4, username);
//
//                p.executeUpdate();
//                status = true;
//            }
//
//        } catch (SQLException | ClassNotFoundException e) {
//            e.printStackTrace();
//            status = false;
//        }
//        return status;
//    }
//
/////Will try to make the method more generic
//    public static boolean updateEmail(AbstractDB db, String value, String username) {
//
//        boolean status;
//
//        try (Connection c = db.connection()) {
//            try (PreparedStatement p = c.prepareStatement("UPDATE inFoJaxs_User SET email = ? WHERE username = ?;")) {
//                //p.setString(1, colunm);
//                p.setString(1, value);
//                p.setString(2, username);
//                p.executeUpdate();
//                status = true;
//            }
//        } catch (SQLException | ClassNotFoundException e) {
//            e.printStackTrace();
//            status = false;
//        }
//        return status;
//    }
//
//    public static boolean updateProfile(AbstractDB db, String username, User.Profile profile){
//
//        boolean status;
//
//        String dateOfBirth = profile.getDateOfBirth();
//        String gender = profile.getGender();
//        String occupation = profile.getOccupation();
//        String education_level = profile.getEducation_level();
//        String politicalOri= profile.getPoliticalOri();
//        String thingsLoves= profile.getThingsLoves();
//        String short_intro= profile.getShort_intro();
//        String[] issues = profile.getIssues();
//
//        try (Connection c = db.connection()) {
//            try (PreparedStatement p = c.prepareStatement("UPDATE inFoJaxs_Profile SET date_Of_Birth = ?, gender = ?, occupation = ?, education_level = ?, political_Orientation = ?, things_Loved = ?, short_intro = ? WHERE username = ?")) {
//                p.setString(1, dateOfBirth);
//                p.setString(2, gender);
//                p.setString(3, occupation);
//                p.setString(4, education_level);
//                p.setString(5, politicalOri);
//                p.setString(6, thingsLoves);
//                p.setString(7, short_intro);
//                p.setString(8, username);
//                p.executeUpdate();
//                status = true;
//            }
//            try (PreparedStatement p = c.prepareStatement("DELETE FROM inFoJaxs_IssuesCared WHERE username = ?")) {
//                p.setString(1, username);
//               p.executeUpdate();
//            }
//
//            for(String issue: issues) {
//                try (PreparedStatement p = c.prepareStatement("INSERT INTO inFoJaxs_IssuesCared (username, issues_Cared) VALUE (?, ?)")) {
//                    p.setString(1, username);
//                    p.setString(2, issue);
//                    p.executeUpdate();
//                }
//            }
//
//        } catch (SQLException | ClassNotFoundException e) {
//            e.printStackTrace();
//            status = false;
//        }
//        return status;
//    }




    private static List<Comment> getArticleComments(int articleId, Connection c) throws SQLException {
        List<Comment> comments = new ArrayList<>();

        try (PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_Comments WHERE article_ID = ?")) {
            p.setInt(1, articleId);
            try (ResultSet r = p.executeQuery()) {
                while (r.next()) {
                    comments.add(commentFromResultSet(r,c,articleId));
                }
            }
        }
        return comments;
    }

    private static List<Reply> getCommentReplies(int articleId, int commentId, Connection c) throws SQLException {
        List<Reply> comments = new ArrayList<>();

        try (PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_Replies WHERE comment_ID = ?")) {
            p.setInt(1, commentId);
            try (ResultSet r = p.executeQuery()) {
                while (r.next()) {
                    comments.add(replyFromResultSet(r, c, articleId+"."+commentId));
                }
            }
        }
        return comments;
    }

    // Methods to create a new Article/Comment/Reply objects from the information stored in the ResultSet.
    private static Article articleFromResultSet(ResultSet r, Connection c) throws SQLException {
        int id = r.getInt("ID");

        return new Article(
                r.getString("title"),
                getArticleComments(id, c),
                id,
                r.getString("username"),
                r.getString("creationDate"),
                r.getString("lastEdited"),
                getLikes(""+id, c),
                r.getString("article"));
    }

    private static Comment commentFromResultSet(ResultSet r, Connection c, int articleId) throws SQLException {
        int commentId = r.getInt("ID");

        return new Comment(
                commentId,
                r.getString("username"),
                getCommentReplies(articleId,commentId, c),
                r.getString("creationDate"),
                r.getString("lastEdited"),
                getLikes(articleId+"."+commentId, c),
                r.getString("comment"));
    }

    private static Reply replyFromResultSet(ResultSet r, Connection c, String s) throws SQLException {
        int replyId = r.getInt("ID");

        return new Reply(
                replyId,
                r.getString("username"),
                r.getString("creationDate"),
                r.getString("lastEdited"),
                getLikes(s+"."+replyId, c),
                r.getString("reply"));
    }

    private static int getLikes(String textID, Connection c) throws SQLException {
        try (PreparedStatement p = c.prepareStatement("SELECT likes FROM inFoJaxs_Likes WHERE ID = ?")) {
            p.setString(1, textID);
            try (ResultSet r = p.executeQuery()) {
                while (r.next()) {
                    return r.getInt("likes");
                }
            }
        }
        return 0;
    }
}
