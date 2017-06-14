package Tree;

import Article.Reply;

/**
 * Created by mche618 on 12/06/2017.
 */
public class T_URL extends Reply implements TreeComponents {


    private boolean supportForArgument;
    private boolean isfactual;
    private String URL;
    private String title;




    public T_URL(){}


//create
    public T_URL(String author, String title, String introText, int parentID, String URL,boolean supportForArgument, boolean isfactual){
        super(author, introText, parentID);
        this.URL = URL;
        this.title = title;
        this.supportForArgument = supportForArgument;
        this.isfactual = isfactual;
    }


    //update
    public T_URL(int id,String title, String introText, String URL, boolean supportForArgument, boolean isfactual ){
        super(id, introText);
        this.title = title;
        this.URL = URL;
        this.supportForArgument = supportForArgument;
        this.isfactual = isfactual;
    }

    //retrieving data
    public T_URL(int id, String author,String title,  String text,  int likes, int views, String dateCreated, String dateLastEdited, boolean supportForArgument,  String URL) {
        super(id, author, text,   likes, views, dateCreated, dateLastEdited);
        this.title = title;
        this.URL = URL;
        this.supportForArgument = supportForArgument;

    }

    public boolean isFactual(){return this.isfactual;};

    public void setIsfactual(boolean isfactual){this.isfactual = isfactual;}

    public String getTitle() {
        return this.title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getURL(){return this.URL;}

    public void setURL(String URL){this.URL =URL;}

    @Override
    public void setSupportForArgument(boolean supportForArgument) {
        this.supportForArgument =supportForArgument;

    }

    @Override
    public boolean isSupportForArgument() {
        return this.supportForArgument;
    }



}
