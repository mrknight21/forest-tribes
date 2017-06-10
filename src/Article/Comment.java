package Article;

import User.User;

import java.sql.Timestamp;
import java.util.List;

/**
 * Created by wasia on 3/06/2017.
 */
public class Comment extends Text {
    protected List<Reply> replies;
    private int replyCount;
    private int articleID;

    public Comment() {}

    public Comment(String author, String text, int articleID) {
        super(author, text);
        this.articleID = articleID;
    }

    public Comment(int id, String text,  String lasteditedTime) {
        super(id, text, lasteditedTime);
    }

    public Comment(int id, String author, String text, List<Reply> replies, int likes, int views,  String dateCreated, String dateLastEdited) {
        super(id,  author, text,  dateCreated,  dateLastEdited, likes, views);
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
