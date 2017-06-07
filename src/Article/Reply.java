package Article;

import User.User;

/**
 * Created by wasia on 3/06/2017.
 */
public class Reply extends Text {
    public Reply() {}

    public Reply(String author, String text) {
        super(author, text);
    }

    public Reply(int id, String author, String text) {
        super(id, author, text);
    }

    public Reply(int id, String author, String text, String dateCreated, String dateLastEdited, int likes) {
        super(id, author, text, dateCreated, dateLastEdited, likes);
    }
}
