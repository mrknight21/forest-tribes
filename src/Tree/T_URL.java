package Tree;

import Article.Reply;

/**
 * Created by mche618 on 12/06/2017.
 */
public class T_URL extends Reply implements TreeComponents {


    boolean supportForArgument;
    boolean isfactual;
    String URL;




    public T_URL(){}


//create
    public T_URL(String author, String introText, int parentID, String URL,boolean supportForArgument, boolean isfactual){
        super(author, introText, parentID);
        this.URL = URL;
        this.supportForArgument = supportForArgument;
        this.isfactual = isfactual;
    }


    //update
    public T_URL(int id, String introText, String URL, boolean supportForArgument ){
        super(id, introText);
        this.URL = URL;
        this.supportForArgument = supportForArgument;
    }

    //retrieving data
    public T_URL(int id, String author, String text,  int likes, int views, String dateCreated, String dateLastEdited, boolean supportForArgument, boolean isfactual, String URL) {
        super(id, author, text,   likes, views, dateCreated, dateLastEdited);
        this.URL = URL;
        this.supportForArgument = supportForArgument;
        this.isfactual = isfactual;
    }

    public boolean isFactual(){return this.isfactual;};

    public void setIsfactual(boolean isfactual){this.isfactual = isfactual;}

    @Override
    public void setSupportForArgument(boolean supportForArgument) {
        this.supportForArgument =supportForArgument;

    }

    @Override
    public boolean isSupportForArgument() {
        return this.supportForArgument;
    }



}
