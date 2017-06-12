package Tree;

import Article.Reply;
import Utility.AbstractDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by mche618 on 12/06/2017.
 */
public class TreeDAO {

//infoTressDAO


    //get summary of all
    public static List<InfoTree> getAllArticles(AbstractDB db) {

        List<InfoTree> trees = new ArrayList<>();

        try (Connection c = db.connection()) {
            PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_Tree_Trees");
                ResultSet r = p.executeQuery();
                    while (r.next()) {
                        trees.add(TreesSummaryFromResultSet(r));
                    }
                }
            catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return trees;
    }

    public static List<InfoTree> getAllArticles(AbstractDB db, String username) {

        List<InfoTree> trees = new ArrayList<>();

        try (Connection c = db.connection()) {
            PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_Tree_Trees WHERE username = ?;");
            p.setString(1, username);
            ResultSet r = p.executeQuery();
            while (r.next()) {
                trees.add(TreesSummaryFromResultSet(r));
            }
        }
        catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return trees;
    }



    public static InfoTree getInfoTreeById(AbstractDB db, int TreeId) {
        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_Tree_Trees WHERE ID = ?")) {
                p.setInt(1, TreeId);
                try (ResultSet r = p.executeQuery()) {
                    while (r.next()) {
                        return fullTreeFromResultSet(r, c);
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }








    //////////////////////////////////////////////////////////////////////////////assemblers

    //infoTrees

    //get brief data of an infotree
    private static InfoTree TreesSummaryFromResultSet (ResultSet r) throws SQLException {
//(int id, String username, String title,String introText, int likes, int views, String dateCreated, String dateLastEdited,  int exp, int leaves, int coordinX, int coordinY )
        return new InfoTree(
                r.getInt("ID"),
                r.getString("username"),
                r.getString("title"),
                r.getString("content"),
                r.getInt("likes"),
                r.getInt("views"),
                r.getTimestamp("creationDate").toString(),
                r.getTimestamp("lastEdit").toString(),
                r.getInt("exp"),
                r.getInt("leaves"),
                r.getInt("XCoordinate"),
                r.getInt("YCoordinate"));
    }


    //get a full infoTree
//int id, String username, String introText, int likes, int views, String dateCreated, String dateLastEdited, String title, List<T_URL> factual, List<T_URL> commentary, List<T_Reaction> reactoin, int exp, int coordinX, int coordinY

    private static InfoTree fullTreeFromResultSet (ResultSet r, Connection c) throws SQLException {
        int id =  r.getInt("ID");
        return new InfoTree(
               id,
                r.getString("username"),
                r.getString("content"),
                r.getInt("likes"),
                r.getInt("views"),
                r.getTimestamp("creationDate").toString(),
                r.getTimestamp("lastEdit").toString(),
                r.getString("title"),
                getTreeFactualURL(id, c),
                getTreeCommentaryURL(id,c),
                getTreeReactions(id, c),
                r.getInt("exp"),
                r.getInt("XCoordinate"),
                r.getInt("YCoordinate"));
    }


    /* ID INT AUTO_INCREMENT,
  username VARCHAR(50) NOT NULL,
  title VARCHAR(80) NOT NULL,
  content TEXT NOT NULL,
  likes INT,
  views INT,
  exp INT,
  stage INT,
  size INT,
  XCoordinate INT,
  YCoordinate INT,
  leaves INT,
  creationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  lastEdit TIMESTAMP DEFAULT CURRENT_TIMESTAMP,*/



    public static List<T_URL> getTreeFactualURL(int parentID, Connection c) throws SQLException {

        List<T_URL> facturalURLs = new ArrayList<>();
        PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_Tree_Factual_URL WHERE parent_ID = ?");
        p.setInt(1, parentID);
        ResultSet r = p.executeQuery();
        while (r.next()) {
            facturalURLs.add(URLFromResultSet(r, c));
        }
        return facturalURLs;
    }



    public static List<T_URL> getTreeCommentaryURL(int parentID, Connection c) throws SQLException {

        List<T_URL> commentaryURLs = new ArrayList<>();
        PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_Tree_Commentary_URL WHERE parent_ID = ?");
        p.setInt(1, parentID);
        ResultSet r = p.executeQuery();
        while (r.next()) {
            commentaryURLs.add(URLFromResultSet(r, c));
        }
        return commentaryURLs;
    }



    public static T_URL URLFromResultSet(ResultSet r,Connection c) throws SQLException {

        //int id, String author, String text,  int likes, int views, String dateCreated, String dateLastEdited, boolean supportForArgument,  String URL
        int id = r.getInt("ID");
        return new T_URL(
                id,
                r.getString("username"),
                r.getString("content"),
                r.getInt("likes"),
                r.getInt("views"),
                r.getTimestamp("creationDate").toString(),
                r.getTimestamp("lastEdit").toString(),
                r.getBoolean("support_for"),
                r.getString("URL"));
    }




    public static List<T_Reaction> getTreeReactions(int parentID, Connection c) throws SQLException {

        List<T_Reaction> reactions = new ArrayList<>();

        try (PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_Tree_Reactions WHERE parent_ID = ?")) {
            p.setInt(1, parentID);
            try (ResultSet r = p.executeQuery()) {
                while (r.next()) {
                    reactions.add(reactionFromResultSet(r, c));
                }
            }
        }
        return reactions;
    }


    //Reaction assemble

    public static T_Reaction reactionFromResultSet (ResultSet r, Connection c) throws SQLException {
        int id = r.getInt("ID");
//int id, String author, String text, List<Reply> replies, int likes, int views, String dateCreated, String dateLastEdited, boolean supportForArgument)
        return new T_Reaction(
                id,
                r.getString("username"),
                r.getString("content"),
                getReactionReplies(id, c),
                r.getInt("likes"),
                r.getInt("views"),
                r.getTimestamp("creationDate").toString(),
                r.getTimestamp("lastEdit").toString(),
                r.getBoolean("support_for"));
    }





    public static List<Reply> getReactionReplies(int reactionId, Connection c) throws SQLException {
        List<Reply> replies = new ArrayList<>();

        try (PreparedStatement p = c.prepareStatement("SELECT * FROM inFoJaxs_Tree_Reaction_Replies WHERE parent_ID = ?")) {
            p.setInt(1, reactionId);
            ResultSet r = p.executeQuery();
                while (r.next()) {
                    replies.add(replyFromResultSet(r, c));
                }
        }
        return replies;
    }

    //assemble replies
    private static Reply replyFromResultSet(ResultSet r, Connection c) throws SQLException {
        int replyId = r.getInt("ID");
//        (int id, String author, String text,  int likes, int views, String dateCreated, String dateLastEdited)
        return new Reply(
                replyId,
                r.getString("username"),
                r.getString("content"),
                r.getInt("likes"),
                r.getInt("views"),
                r.getString("creationDate"),
                r.getString("lastEdit"));
    }



}
