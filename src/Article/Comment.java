package Article;

import User.User;

import java.util.List;

/**
 * Created by wasia on 3/06/2017.
 */
public class Comment extends Text {
    protected List<Reply> replies;

    public Comment(int id, String author, List<Reply> replies, String dateCreated, String dateLastEdited, int likes, String text) {
        super(id, author, dateCreated, dateLastEdited, likes, text);
    }

    public List<Reply> getReplies() {
        return replies;
    }

    public void setReplies(List<Reply> replies) {
        this.replies = replies;
    }
}
