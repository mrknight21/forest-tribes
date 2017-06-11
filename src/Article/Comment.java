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
        likes = 0;
        views = 0;
        this.replies =null;
        this.replyCount =0;
    }

    public Comment(int id, String text) {
        super(id, text);
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



    public int getArticleID(){
        return articleID;
    }

    public void setArticleID(int parent_id){
        this.articleID = parent_id;
    }

}
