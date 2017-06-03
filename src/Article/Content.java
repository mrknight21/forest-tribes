package Article;

import User.User;

import java.io.File;
import java.util.List;

/**
 * Created by wasia on 3/06/2017.
 */
public class Content {
    protected int id;
    protected User author;
    protected String dateCreated;
    protected String dateLastEdited;
    protected int views;
    protected String text;
    protected File image;
    protected String filePath;
    protected List<Comment> comments;
}
