package Article;

import User.User;
import Utility.MicellaneousUntility;
import com.sun.xml.internal.fastinfoset.util.CharArray;

import java.io.Serializable;
import java.security.Timestamp;
import java.sql.Time;
import java.util.List;

/**
 * Created by wasia on 3/06/2017.
 *
 * Article and inner classes Comment and Reply extend abstract Text class and will be used as Java beans
 *
 */
public class Article extends Text {
    private String title;
    private List<Comment> comments;
    private int commentCount;
    private String shortIntro;

    public Article() {}

    public Article(String author, String title, String text) {
        //creation time and last edit time will be automatically made in database.
        super(author, text);
        this.title = title;
        comments = null;
        commentCount = 0;
        likes = 0;
        views = 0;
        this.shortIntro = extractShortIntro(this.text);
    }

    //author, created time,
    public Article(int id, String text, String dateLastEdited, String title) {
        super( id, text, dateLastEdited);
        this.title = title;
        this.shortIntro = extractShortIntro(this.text);

    }

    //retrieve a complete article including comment and replies.
    public Article(int id, String author, String title, String text, String shortIntro, List<Comment> comments,  int likes, int view, String dateCreated, String dateLastEdited) {
        super( id,  author,  text, dateCreated,dateLastEdited,likes, view);
        this.title = title;
        this.comments = comments;
        this.shortIntro = shortIntro;

        int count = 0;
        count += comments.size();
        for (Comment comment: comments) count += comment.getReplyCount();
        this.commentCount = count;
    }


    //retrieve articles brief info
    public Article(int id, String author, String title, String text,int likes, int view, int commentsCount,  String shortIntro, String dateCreated, String dateLastEdited) {
        super( id,  author,  text, dateCreated,dateLastEdited,likes, view);
        this.title = title;
        this.shortIntro = shortIntro;
        this.commentCount = commentsCount;
    }

    private String extractShortIntro(String text){
        int indexNum = 100;
        String shortIntro ="";
        String pureText = MicellaneousUntility.htmlToStringParser(this.text);
        while( true){
            if(this.text.length() < 100)
            {
                shortIntro = this.text;
                break;
            }
            if(indexNum >=110){
                shortIntro = this.text.substring(0,indexNum)+"......";
                    break;
                }
            if(pureText.charAt(indexNum)!= ' '){
                indexNum++;
            }
            else {
                shortIntro = this.text.substring(0,indexNum)+"......";
                break;
            }
        }
        return shortIntro;

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

    public void setShortIntro (String intro ){
        this.shortIntro = intro;
    }

    public String getShortIntro(){
        return this.shortIntro;
    }


}
