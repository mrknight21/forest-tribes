package Article;

import User.User;

import java.util.List;

/**
 * Created by wasia on 3/06/2017.
 */
public class Comment extends Text {
    protected List<Reply> replies;
    private int replyCount;

    public Comment() {}

    public Comment(String author, String text) {
        super(author, text);
    }

    public Comment(int id, String author, String text) {
        super(id, author, text);
    }

    public Comment(int id, String author, String text, List<Reply> replies, String dateCreated, String dateLastEdited, int likes) {
        super(id, author, text, dateCreated, dateLastEdited, likes);
        this.replies = replies;
        this.replyCount = replies.size();
    }

    public List<Reply> getReplies() {
        return replies;
    }

    public int getReplyCount() {
        return replyCount;
    }
}
