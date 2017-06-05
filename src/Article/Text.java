package Article;

import User.User;

import java.io.File;
import java.io.Serializable;
import java.util.List;

/**
 * Created by wasia on 3/06/2017.
 */
public abstract class Text implements Serializable {
    protected int id;
    protected User author;
    protected String dateCreated;
    protected String dateLastEdited;
    protected int views;
    protected String text;
    protected File image;
    protected String filePath;

    public Text() {
    }

    public Text(int id, User author, String dateCreated, String dateLastEdited, int views, String text, File image, String filePath) {
        this.id = id;
        this.author = author;
        this.dateCreated = dateCreated;
        this.dateLastEdited = dateLastEdited;
        this.views = views;
        this.text = text;
        this.image = image;
        this.filePath = filePath;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
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

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public File getImage() {
        return image;
    }

    public void setImage(File image) {
        this.image = image;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }
}