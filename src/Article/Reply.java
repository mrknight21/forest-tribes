package Article;

import User.User;

import java.sql.Timestamp;

/**
 * Created by wasia on 3/06/2017.
 */
public class Reply extends Text {

    private int commentId;

    public Reply() {}

    //initial
    public Reply(String text, String author, int commentId) {
        super(author, text);
        this.commentId = commentId;
    }

    //update
    public Reply(int id, String text, String dateLastEdited) {
        super(id, text, dateLastEdited);
    }
    //retrieve
    public Reply(int id, String author, String text, String dateCreated, String dateLastEdited, int likes, int views) {
        super(id, author, text, dateCreated, dateLastEdited, likes, views);
    }
}
