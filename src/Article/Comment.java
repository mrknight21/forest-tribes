package Article;

import java.util.List;

/**
 * Created by wasia on 3/06/2017.
 * comment can contain replies.
 */
public class Comment extends Text {
    protected List<Reply> replies;
    protected int replyCount;
    protected int parentID;

    public Comment() {}

    // Create
    public Comment(String author, String text, int parentID) {
        super(author, text);
        this.parentID = parentID;
        likes = 0;
        views = 0;
        this.replies = null;
        this.replyCount =0;
    }

    // Update
    public Comment(int id, String text) {
        super(id, text);
    }

    // Retrieve
    public Comment(int id, int parentID, String author, String text, List<Reply> replies, int likes, int views,  String dateCreated, String dateLastEdited) {
        super(id,  author, text,  dateCreated,  dateLastEdited, likes, views);
        this.parentID = parentID;
        this.replies = replies;
        setReplyCount(replies);
    }

    // Tree
    public Comment(int id, String author, String text, List<Reply> replies, int likes, int views,  String dateCreated, String dateLastEdited) {
        super(id,  author, text,  dateCreated,  dateLastEdited, likes, views);
        this.replies = replies;
        setReplyCount(replies);
    }

    public List<Reply> getReplies() {return replies;}
    public void setReplies(List<Reply> replies) {this.replies = replies;}
    public int getReplyCount() {return replyCount;}
    public void setReplyCount(List<Reply> replies) {this.replyCount = replies.size();}
    public int getParentID(){
        return parentID;
    }
    public void setParentID(int parent_id){
        this.parentID = parent_id;
    }

}
