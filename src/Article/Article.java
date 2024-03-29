package Article;

import Utility.MiscellaneousUtility;

import java.util.List;

/**
 * Created by wasia on 3/06/2017.
 * <p>
 * Article and inner classes Comment and Reply extend abstract Text class and will be used as Java beans.
 * Article can contain comments.
 * beside the major text content, article also possess a short intro text property and a title.
 */
public class Article extends Text {
    private String title;
    private List<Comment> comments;
    private int responseCount;
    private String shortIntro;

    public Article() {
    }

    // Create new article
    public Article(String author, String title, String text, String shortIntro) {
        //creation time and last edit time will be automatically made in database.
        super(author, text);
        this.title = title;
        comments = null;
        responseCount = 0;
        likes = 0;
        views = 0;
        this.shortIntro = shortIntro;
//        this.shortIntro = extractShortIntro(text);
    }

    // Update article
    public Article(int id, String text, String title, String shortIntro) {
        super(id, text);
        this.title = title;
        this.shortIntro = shortIntro;
//        this.shortIntro = extractShortIntro(text);
    }

    //retrieve a complete article including comment and replies.
    public Article(int id, String author, String title, String text, String shortIntro, List<Comment> comments, int likes, int view, String dateCreated, String dateLastEdited) {
        super(id, author, text, dateCreated, dateLastEdited, likes, view);
        this.title = title;
        this.comments = comments;
        this.shortIntro = shortIntro;
        setResponseCount(comments);
    }

    //retrieve articles brief info for all article view.
    public Article(int id, String author, String title, String text, int likes, int view, int responseCount, String shortIntro, String dateCreated, String dateLastEdited) {
        super(id, author, text, dateCreated, dateLastEdited, likes, view);
        this.title = title;
        this.shortIntro = shortIntro;
        this.responseCount = responseCount;
    }

    public void setResponseCount(List<Comment> comments) {
        int count = 0;
        count += comments.size();
        for (Comment comment : comments) count += comment.getReplyCount();
        this.responseCount = count;
    }

    private String extractShortIntro(String text) {
        int indexNum = 100;

        String pureText = MiscellaneousUtility.htmlToStringParser(text);

        if (pureText.length() < indexNum) return pureText;

        while (true)
            if (pureText.charAt(indexNum) == ' ')
                return text.substring(0, indexNum) + "......";
            else if (indexNum >= 110)
                return text.substring(0, indexNum) + "......";
            else indexNum++;
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
    public int getResponseCount() {
        return responseCount;
    }
    public void setShortIntro(String intro) {
        this.shortIntro = intro;
    }
    public String getShortIntro() {
        return this.shortIntro;
    }
}