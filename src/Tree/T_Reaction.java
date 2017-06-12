package Tree;

import Article.Comment;
import Article.Reply;

import java.util.List;

/**
 * Created by mche618 on 12/06/2017.
 */
public class T_Reaction extends Comment implements TreeComponents {

    boolean supportForArgument;





    public T_Reaction(){}


    //creating comment tree component
    public T_Reaction(String author, String text, int parentID, boolean supportForArgument ){
        super(author, text, parentID);
        this.supportForArgument = supportForArgument;
    }


    //updating comment tree components
    public T_Reaction(int id, String text, boolean supportForArgument){
        super(id, text);
        this.supportForArgument = supportForArgument;
    }


    //retrieving comment tree components
    public T_Reaction(int id, String author, String text, List<Reply> replies, int likes, int views, String dateCreated, String dateLastEdited, boolean supportForArgument){
        super( id, author,  text,  replies, likes,  views, dateCreated, dateLastEdited);
        this.supportForArgument =supportForArgument;
    }


    @Override
    public void setSupportForArgument(boolean supportForArgument) {
        this.supportForArgument = supportForArgument;

    }

    @Override
    public boolean isSupportForArgument() {
        return false;
    }
}
