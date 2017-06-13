package Tree;

import Article.Reply;
import Utility.AbstractDB;
import Utility.MiscellaneousUtility;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by mche618 on 12/06/2017.
 */
public class TreeDAO {

//infoTressDAO


    //get summary of all
    public static List<InfoTree> geAllInfoTrees(AbstractDB db) {

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

    public static List<InfoTree> getUserAllInfoTrees(AbstractDB db, String username) {

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


    /*
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
     */


    ///////////////create////////////////////////////////////////////

    public static boolean createNewTree( AbstractDB db, InfoTree tree){
        boolean success;

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("INSERT INTO inFoJaxs_Tree_Trees (username, title, content, likes, views, exp, stage, size, leaves, XCoordinate, YCoordinate) VALUE (?, ?, ?, ?, ?, ?, ?,?, ?, ?, ?)")) {
                p.setString(1, tree.getAuthor());
                p.setString(2, tree.getTitle());
                p.setString(3, tree.getText());
                p.setInt(4, tree.getLikes());
                p.setInt(5, tree.getViews());
                p.setInt(6, tree.getExp());
                p.setInt(7, tree.getStage());
                p.setInt(8, tree.getSize());
                p.setInt(9, tree.getLeaves());
                p.setInt(10, tree.getCoordinX());
                p.setInt(11, tree.getCoordinY());
                p.executeUpdate();
                success = true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            success = false;
        }
        return success;

    }


    public static boolean random_trees_generator (AbstractDB db, List<String> usernames){
        boolean success;

        try (Connection c = db.connection()) {
            for (String username: usernames){
                for ( int i =0; i <=3; i++){
                    PreparedStatement p = c.prepareStatement("INSERT INTO inFoJaxs_Tree_Trees (username, title, content, likes, views, exp, stage, size, leaves, XCoordinate, YCoordinate) VALUE (?, ?, ?, ?, ?, ?, ?,?, ?, ?, ?)");
                        p.setString(1, username);
                        p.setString(2, MiscellaneousUtility.randomString(40));
                        p.setString(3, MiscellaneousUtility.randomString(100));
                        p.setInt(4, 100);
                        p.setInt(5, 50);
                        p.setInt(6, (int)(Math.random()*3200));
                        p.setInt(7, 1 );
                        p.setInt(8, 100);
                        p.setInt(9, 30);
                        p.setInt(10, (int)(Math.random()*8100+900));
                        p.setInt(11, (int)(Math.random()*8100+900));
                        p.executeUpdate();
                        success = true;
                }
            }
            success = true;
        }catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            success = false;
        }

        return success;

    }


    /*
ID INT AUTO_INCREMENT,
  parent_ID INT NOT NULL ,
  username VARCHAR(50) NOT NULL,
  title
  URL VARCHAR (8000) NOT NULL,
  content VARCHAR (8000) NOT NULL,
  likes INT,
  views INT,
  support_for BOOLEAN,
  creationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  lastEdit TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
     */




    public static boolean AddNewURL( AbstractDB db, T_URL URL){
        boolean success;

        try (Connection c = db.connection()) {
            PreparedStatement p = null;
            if(URL.isFactual()){
               p = c.prepareStatement("INSERT INTO inFoJaxs_Tree_Factual_URL (parent_ID, username, title, URL, content, likes, views, support_for) VALUE (?, ?, ?, ?, ?, ?, ?, ?)");
            }
            else {
            p = c.prepareStatement("INSERT INTO inFoJaxs_Tree_Commentary_URL (parent_ID, username, title, URL, content, likes, views, support_for) VALUE (?, ?, ?, ?, ?, ?, ?, ?)"); }
                p.setInt(1, URL.getParentID());
                p.setString(2, URL.getAuthor());
                p.setString(3, URL.getTitle());
                p.setString(4, URL.getURL());
                p.setString(5, URL.getText());
                p.setInt(6, URL.getLikes());
                p.setInt(7, URL.getViews());
                p.setBoolean(8, URL.isFactual());
            p.executeUpdate();
                success = true;
            }
         catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            success = false;
        }
        return success;
    }



    /*ID INT AUTO_INCREMENT,
  parent_ID INT NOT NULL,
  username VARCHAR(50) NOT NULL ,
  content VARCHAR (8000) NOT NULL,
  likes INT,
  views INT,
  repliesCount INT,
  support_for BOOLEAN,
  creationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  lastEdit TIMESTAMP DEFAULT CURRENT_TIMESTAMP,*/



    public static boolean AddNewReaction( AbstractDB db, T_Reaction reaction){
        boolean success;

        try (Connection c = db.connection()) {
            PreparedStatement p = c.prepareStatement("INSERT INTO inFoJaxs_Tree_Reactions (parent_ID, username, content, likes, views, repliesCount,support_for) VALUE (?, ?, ?, ?, ?, ?, ?, ?)");
            p.setInt(1, reaction.getParentID());
            p.setString(2, reaction.getAuthor());
            p.setString(3, reaction.getText());
            p.setInt(4, reaction.getLikes());
            p.setInt(5, reaction.getViews());
            p.setInt(6, reaction.getRepliesCount());
            p.setBoolean(7, reaction.isSupportForArgument());
            p.executeUpdate();
            success = true;

        }catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            success = false;
        }
        return success;
    }

    public static boolean createNewReply( AbstractDB db, Reply reply){
        boolean success;
        //Comment(String author, String text, int parentID)//
        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("INSERT INTO inFoJaxs_Tree_Reaction_Replies (parent_ID, username,content, likes, views) VALUE (?, ?, ?, ?, ?)")) {
                p.setInt(1, reply.getParentID());
                p.setString(2, reply.getAuthor());
                p.setString(3, reply.getText());
                p.setInt(4, reply.getLikes());
                p.setInt(5, reply.getViews());
                p.executeUpdate();
                success = true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            success = false;
        }
        return success;

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
                r.getString("title"),
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



    ////////////////////////////////Delete//////////////////////////////////////////////////////////////


    public static boolean deleteInfoTree(AbstractDB db, int TreeID){
        boolean success = false;
        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("DELETE FROM inFoJaxs_Tree_Trees WHERE ID = ?;")) {
                //p.setString(1, colunm);
                p.setInt(1, TreeID);
                p.executeUpdate();
                success = true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            success = false;
        }
        return success;
    }


    public static boolean deleteURL(AbstractDB db, int URLID, boolean factual){
        boolean success = false;
        try (Connection c = db.connection()) {

            PreparedStatement p = null;
            if(factual) {
                 p = c.prepareStatement("DELETE FROM inFoJaxs_Tree_Factual_URL WHERE ID = ?;");
            }else {
                p = c.prepareStatement("DELETE FROM inFoJaxs_Tree_Commentary_URL WHERE ID = ?;");
            }
                //p.setString(1, colunm);
                p.setInt(1, URLID);
                p.executeUpdate();
                success = true;

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            success = false;
        }
        return success;
    }


    public static boolean deleteReaction(AbstractDB db, int ReactionID){
        boolean success = false;
        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("DELETE FROM inFoJaxs_Tree_Reactions WHERE ID = ?;")) {
                //p.setString(1, colunm);
                p.setInt(1, ReactionID);
                p.executeUpdate();
                success = true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            success = false;
        }
        return success;
    }


    public static boolean deleteReactionReply(AbstractDB db, int replyID){
        boolean success = false;
        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("DELETE FROM inFoJaxs_Tree_Reaction_Replies WHERE ID = ?;")) {
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
    }

    //////////////////////////////////////////////////Update///////////////////////////////////////////////////////////////////////////////////


    public static boolean updateTree(AbstractDB db, InfoTree tree){
        boolean status;

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("UPDATE inFoJaxs_Tree_Trees SET title = ?, content = ?, likes = ?, views = ?, exp = ?, stage = ?, size = ?, leaves = ?, lastEdit = ? WHERE ID = ?;")) {
                //p.setString(1, colunm);
                p.setString(1, tree.getTitle());
                p.setString(2, tree.getText());
                p.setInt(3, tree.getLikes());
                p.setInt(4, tree.getViews() );
                p.setInt(5, tree.getExp() );
                p.setInt(6, tree.getStage() );
                p.setInt(7, tree.getSize() );
                p.setInt(8, tree.getLeaves() );
                p.setString(9, new Timestamp(System.currentTimeMillis()).toString());
                p.setInt(10, tree.getId() );
                p.executeUpdate();
                status = true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            status = false;
        }
        return status;
    }

    public static boolean updateURL(AbstractDB db, T_URL URL) {

        boolean success = false;
        try (Connection c = db.connection()) {
//parent_ID, username, title, URL, content, likes, views, support_for
            PreparedStatement p = null;
            if (URL.isFactual()) {
                p = c.prepareStatement("UPDATE inFoJaxs_Tree_Factual_URL SET title = ?, content = ?, URL = ?, likes = ?, views = ?, support_for = ? lastEdit = ? WHERE ID = ?;");
            } else {
                p = c.prepareStatement("UPDATE inFoJaxs_Tree_Commentary_URL SET title = ?, content = ?, URL = ?, likes = ?, views = ?, support_for = ? lastEdit = ? WHERE ID = ?;");
            }
            p.setString(1, URL.getTitle());
            p.setString(2, URL.getText());
            p.setString(3, URL.getURL());
            p.setInt(4, URL.getLikes());
            p.setInt(5, URL.getViews() );
            p.setBoolean(6, URL.isSupportForArgument() );
            p.setString(7, new Timestamp(System.currentTimeMillis()).toString());
            p.setInt(8, URL.getId());
            p.executeUpdate();
            success = true;


        }catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            success = false;
        }
        return success;
    }



    public static boolean updateReaction(AbstractDB db, T_Reaction reaction){
        boolean status;

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("UPDATE inFoJaxs_Tree_Reactions SET  content = ?, likes = ?, views = ?, repliesCount = ?, support_for = ?, lastEdit = ? WHERE ID = ?;")) {
                //p.setString(1, colunm);
                p.setString(1, reaction.getText());
                p.setInt(2, reaction.getLikes());
                p.setInt(3, reaction.getViews() );
                p.setInt(4, reaction.getRepliesCount() );
                p.setBoolean(5, reaction.isSupportForArgument() );
                p.setString(6, new Timestamp(System.currentTimeMillis()).toString());
                p.setInt(7, reaction.getId() );
                p.executeUpdate();
                status = true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            status = false;
        }
        return status;
    }


    public static boolean updateReactionReply(AbstractDB db, Reply reply) {
        boolean status;

        try (Connection c = db.connection()) {
            try (PreparedStatement p = c.prepareStatement("UPDATE inFoJaxs_Tree_Reaction_Replies SET content = ?,lastEdit = ? WHERE ID = ?;")) {
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
    }



}
