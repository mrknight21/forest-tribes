package Article;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created by wasia on 3/06/2017.
 */
public abstract class Text implements Serializable {
    protected int id;
    protected String author;
    protected String dateCreated;
    protected String dateLastEdited;
    protected int likes;
    protected String text;
    protected int views;
//    protected File image;
//    protected String filePath;

    public Text() {}

    //initialised
    public Text(String author, String text) {
        this.author = author;
        this.text = text;
        likes = 0;
        views = 0;
    }

    //update
    public Text(int id, String text) {
        this.id = id;
        this.text = text;
    }

    //retrieve
    public Text(int id, String author, String text, String dateCreated, String dateLastEdited, int likes, int views) {
        this.id = id;
        this.author = author;
        this.text = text;
        this.dateCreated = dateCreated;
        this.dateLastEdited = dateLastEdited;
        this.likes = likes;
        this.views = views;
//        this.image = image;
//        this.filePath = filePath;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(String dateCreated) {
        this.dateCreated = dateCreated;
    }

    public String getDateLastEdited() {
        return dateLastEdited;
    }

    public void setDateLastEdited(String dateLastEdited) {
        this.dateLastEdited = dateLastEdited;
    }

    public int getLikes() {
        return likes;
    }

    public void setLikes(int likes) {
        this.likes = likes;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }


    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.likes = views;
    }

//    public File getImage() {
//        return image;
//    }

//    public void setImage(File image) {
//        this.image = image;
//    }

//    public String getFilePath() {
//        return filePath;
//    }

//    public void setFilePath(String filePath) {
//        this.filePath = filePath;
//    }
}