package Article;

import User.User;

/**
 * Created by wasia on 3/06/2017.
 */
public class Reply extends Text {
    public Reply(int id, String author, String dateCreated, String dateLastEdited, int likes, String text) {
        super(id, author, dateCreated, dateLastEdited, likes, text);
    }
}
