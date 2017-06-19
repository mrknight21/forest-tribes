package Tree;

import Article.Comment;
import Article.Reply;

import java.util.List;

/**
 * Created by mche618 on 12/06/2017.
 *
 * The reaction class is an extention from comment class, which means it can also contain replies, although the replie function hasn't been fully implemented yet.
 * In addition to the properties of Comment class, Reaction object has properties that ditinguish its position regarding to the parent tree's statement or topic.
 *--Bryan
 */
public class T_Reaction extends Comment implements TreeComponents {

    private boolean supportForArgument;






    public T_Reaction(){}


    //creating comment tree component
    public T_Reaction(String author, String text, int parentID, boolean supportForArgument ){
        super(author, text, parentID);
        this.supportForArgument = supportForArgument;
        this.replyCount = 0;
    }


    //updating comment tree components
    public T_Reaction(int id, String text, boolean supportForArgument , int repliesCount){
        super(id, text);
        this.supportForArgument = supportForArgument;
        this.replyCount = repliesCount;
    }


    //retrieving comment tree components
    public T_Reaction(int id, String author, String text, List<Reply> replies, int likes, int views, String dateCreated, String dateLastEdited, boolean supportForArgument){
        super( id, author,  text,  replies, likes,  views, dateCreated, dateLastEdited);
        this.supportForArgument =supportForArgument;
        this.replyCount = replies.size();
    }



    @Override
    public void setSupportForArgument(boolean supportForArgument) {
        this.supportForArgument = supportForArgument;

    }

    @Override
    public boolean isSupportForArgument() {
        return this.supportForArgument;
    }
}
