package Article;

/**
 * Created by wasia on 3/06/2017.
 */
public class Reply extends Text {

    private int parentID;

    public Reply() {}

    //initial
    public Reply(String author, String text, int parentID) {
        super(author, text);
        this.parentID = parentID;
    }

    //update
    public Reply(int id, String text) {
        super(id, text);
    }
    //retrieve
    public Reply(int id, String author, String text,  int likes, int views, String dateCreated, String dateLastEdited) {
        super(id, author, text, dateCreated, dateLastEdited, likes, views);
    }

    public int getParentID(){
        return this.parentID;
    }

    public void setParentID(int parentID){
        this.parentID = parentID;
    }
}
