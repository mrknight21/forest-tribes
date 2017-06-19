package Utility;

import Tree.TreeDAO;
import User.User;
import User.UserDAO;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by mche618 on 14/06/2017.
 *
 * this class generate random tree for all users.
 *
 * --Bryan
 */
public class RandomTreeGenerator {
    public void start() {


        List<User> users = new ArrayList<>();
        MySQL DB = new MySQL();

        users = UserDAO.getAllUsers(DB);
        List<String> userNames = new ArrayList<>();

        for (User user: users){
            userNames.add(user.getUsername());
        }

        TreeDAO.random_trees_generator(DB, userNames);


    }
    public static void main(String[] args) {
        new RandomTreeGenerator().start();
    }
}
