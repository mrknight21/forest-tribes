package Tree;

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
/*public class TreeDAO {

//infoTressDAO

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






    //////////////////////////////////////////////////////////////////////////////assemblers

    //infoTrees
    private static InfoTree TreesSummaryFromResultSet (ResultSet r) throws SQLException {


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











}*/
