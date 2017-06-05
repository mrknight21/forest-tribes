package TIRAL;

import User.Profile;
import User.UserDAO;
import Utility.MySQL;

/**
 * Created by mche618 on 5/06/2017.
 */
public class trial {
    public static void main(String[] args) {



        String[] issues = new String[]{"Peace", "Justice"};
        String email = "mrknight21@hotmail.com"

        ;


        MySQL DB = new MySQL();
        Profile trialPRO  = new Profile("programmer1", "05/22/1993", "male","student", "posgrad", "liberal","writing", "hello! World",issues);

        UserDAO.updateProfile(DB, "programmer1", trialPRO);
        UserDAO.updateEmail(DB,  email, "programmer1");


    }
}
