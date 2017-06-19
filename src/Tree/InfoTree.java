package Tree;

import Article.Text;

import java.util.List;

/**
 * Created by mche618 on 12/06/2017.
 *
 * An introduction of InfoTree class:
 * infoTree class is also an extention of Text abstract class, as it is also an edible type.
 * The class object will be displayed on the iframe map in ForestTribes.jsp.
 * Generally, beside the basic property inherited from Text parent class InfoTree consist of two groups of properties, which are text content groups and visual display control group.
 * The text content group consists of a title, a list of factual context URL, a list commentary context URL, and a list of other user's reactions.
 * The visual display control group consist of stage, size, coordinate X&Y, which respectively control the tree display types, zooming percentages and its coordinates on the iframe map.
 * leaves is the number of reaction the tree received.
 * The exp property is the ket property that links between text content group and visual display control group, as size & stage are calculated based on exp, and exp is built up by number of URLs, likes, views and reactions.
 *However, now the exp calculation based on article has not been fully implemented yet, as the exp updating DAO not ready.
 *
 *  NOTE: the "text" property that is inherited from the parent class, and usually act as the major content for articles etc, is acting as short introduction text for the tree.
 * ---Bryan
 *
 */
public class InfoTree extends Text{


    private String title;
    private List<T_URL> factual;
    private List<T_URL> commentary;
    private List<T_Reaction> reactoin;
    private int stage;
    private int size;
    private int exp;
    private int coordinX;
    private int coordinY;
    private int leaves;


    /* protected int id;
    protected String author;
    protected String dateCreated;
    protected String dateLastEdited;
    protected int likes;
    protected String text;
    protected int views;*/







    public InfoTree(){

    }


    //Create a new tree
    public InfoTree(String username, String title, String intoText, int coordinX, int coordinY){
        super(username, intoText);
        this.title =title;
        this.factual = null;
        this.commentary = null;
        this.reactoin = null;
        this.stage = 1;
        this.size = 50;
        this.exp = 0;
        this.leaves = 0;
        this.coordinX =coordinX;
        this.coordinY = coordinY;
    }



    //Update info tree brief info should go for DAO
    public InfoTree(int id, String username, String introText, int likes, int views, String dateCreated, String dateLastEdited, String title, int exp){
        super(id, username, introText, dateCreated, dateLastEdited, likes, views);
        this.title =title;
        this.exp =exp;
        calculateStage();
        calculateSize();
        calculateLeaves();

    }


//Retrieve an info tree brief info
public InfoTree(int id, String username, String title,String introText, int likes, int views, String dateCreated, String dateLastEdited,  int exp, int leaves, int coordinX, int coordinY ){
    super( id, username,  introText, dateCreated, dateLastEdited, likes, views);
    this.title =title;
    this.exp =exp;
    calculateStage();
    calculateSize();
    this.leaves = leaves;
    this.coordinX =coordinX;
    this.coordinY = coordinY;
}




    //Retreive a full tree from database
    public InfoTree(int id, String username, String introText, int likes, int views, String dateCreated, String dateLastEdited, String title, List<T_URL> factual, List<T_URL> commentary, List<T_Reaction> reactoin, int exp, int coordinX, int coordinY ){
       super( id, username,  introText, dateCreated, dateLastEdited, likes, views);
        this.title =title;
        this.factual = factual;
        this.commentary = commentary;
        this.reactoin = reactoin;
        this.exp =exp;
        calculateStage();
        calculateSize();
        calculateLeaves();
        this.coordinX =coordinX;
        this.coordinY = coordinY;
    }





    // setters and getters
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public  List<T_URL> getFactual(){return this.factual;}

    public void setFactual(List<T_URL> factual){this.factual = factual;}

    public  List<T_URL> getCommentary(){return this.commentary;}

    public void setCommentary( List<T_URL> commentary){this.commentary = commentary;}

    public List<T_Reaction> getReactoin() {return this.reactoin;}

    public void setReactoin(List<T_Reaction> reactoin) {
        this.reactoin = reactoin;
    }

    public int getStage(){return this.stage;};

    public void setStage(int stage){this.stage = stage;}

    public int getSize(){return this.size;};

    public void setSize(int size){this.size = size;}

    public int getExp(){return this.exp;};

    public void setExp(int exp){this.exp = exp;}

    public int getCoordinX(){return this.coordinX;};

    public void setCoordinX(int coordinX){this.coordinX = coordinX;}

    public int getCoordinY(){return this.coordinY;};

    public void setCoordinY(int coordinY){this.coordinY = coordinY;}

    public int getLeaves(){return this.leaves;};

    public void setLeaves(int leaves){this.leaves = leaves;}





//calculate exp
    private void calculateExp(){
        int exp = this.factual.size()*100 + this.commentary.size()*100+this.reactoin.size()*20;
        if (exp > 6000){
            this.exp =6000;
            return;
        }
        this.exp =exp;

    }




// calculate stage base on exp
    private void calculateStage(){
       if (this.exp <500){
           this.stage =1;
           return;
       }
       if (this.exp <1000){
           this.stage=2;
           return;
       }
       if (this.exp>1000 & this.exp <2000){
           this.stage =3;
           return;
       }
       if(this.exp >2000 & this.exp<3000){
           this.stage = 4;
           return;
       }
        if(this.exp >3000 & this.exp<4500){
            this.stage = 5;
            return;
        }
        if(this.exp >4500 ){
            this.stage = 6;
            return;
        }
    }

    //calculate size base on exp and stages
    private void calculateSize(){
        switch (this.stage){
            case 1: this.size = (int)(100.0*(this.exp/500.0)+50.0);
            return;
            case 2: this.size =(int)(120.0*((this.exp-500.0)/500.0)+50.0);
                return;
            case 3:this.size =(int)(130.0*((this.exp-1000.0)/1000.0)+50.0);
                return;
            case 4: this.size =(int)(130.0*((double)(this.exp-2000.0)/1000.0)+50.0);
                return;
            case 5: this.size =(int)(130.0*((double)(this.exp-3000.0)/1000.0)+50.0);
                return;
            case 6:this.size =(int)(130.0*((double)(this.exp-4000.0)/1000.0)+50.0);
                return;
        }

    }

    //calculate leaves
    private void calculateLeaves(){
        this.leaves = this.reactoin.size();
    }




}
