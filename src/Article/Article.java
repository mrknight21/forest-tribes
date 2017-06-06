package Article;

import User.User;

import java.io.Serializable;
import java.util.List;

/**
 * Created by wasia on 3/06/2017.
 *
 * Article and inner classes Comment and Reply extend abstract Text class and will be used as Java beans
 *
 */
public class Article extends Text implements Serializable{
    private String title;
    private List<Comment> comments;
    private int commentCount;

    public Article() {}

    public Article(String author, String title, String text) {
        super(author, text);
        this.title = title;
    }

    public Article(int id, String author, String title, String text) {
        super(id, author, text);
        this.title = title;
    }

    public Article(int id, String author, String title, String text, List<Comment> comments, String dateCreated, String dateLastEdited, int likes) {
        super(id, author, text, dateCreated, dateLastEdited, likes);
        this.title = title;
        this.comments = comments;

        int count = 0;
        count += comments.size();
        for (Comment comment: comments) count += comment.getReplies().size();
        this.commentCount = count;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public List<Comment> getComments() {return comments;}

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public int getCommentCount() {
        return commentCount;
    }
}
