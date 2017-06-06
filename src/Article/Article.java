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
    private String recap;
    private List<Comment> comments;
    private int commentCount;

    public Article() {}

    public Article(String title, List<Comment> comments, int id, String author, String dateCreated, String dateLastEdited, int likes, String text) {
        super(id, author, dateCreated, dateLastEdited, likes, text);

        this.title = title;
//        this.recap = recap;
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

    public String getRecap() {
        return recap;
    }

    public void setRecap(String recap) {
        this.recap = recap;
    }

    public List<Comment> getComments() {
        return comments;

    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public int getCommentCount() {
        return commentCount;
    }
}
