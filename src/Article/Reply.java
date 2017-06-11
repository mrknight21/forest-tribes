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
    public Reply(String author, String text, int commentId) {
        super(author, text);
        this.commentId = commentId;
    }

    //update
    public Reply(int id, String text) {
        super(id, text);
    }
    //retrieve
    public Reply(int id, String author, String text,  int likes, int views, String dateCreated, String dateLastEdited) {
        super(id, author, text, dateCreated, dateLastEdited, likes, views);
    }

    public int getCommentId(){
        return this.commentId;
    }

    public void setCommentId(int commentId){
        this.commentId = commentId;
    }
}
