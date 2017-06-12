package Tree;

import Article.Text;

import java.util.List;

/**
 * Created by mche618 on 12/06/2017.
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



    //Update should go for DAO




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
        if (exp > 4000){
            this.exp =4000;
            return;
        }
        this.exp =exp;

    }




// stage
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
       else if(this.exp >2000){
           this.stage = 4;
       }
    }

    //calculate size
    private void calculateSize(){
        switch (this.stage){
            case 1: this.size = 150*(this.exp/500)+50;
                break;
            case 2: this.size =150*((this.exp-500)/500)+50;
                break;
            case 3:this.size =150*((this.exp-1000)/1000)+50;
                break;
            case 4: this.size =150*((this.exp-2000)/2000)+50;
                break;
        }

    }

    //calculate leaves
    private void calculateLeaves(){
        this.leaves = this.reactoin.size();
    }



    /* private String title;
    private List<T_URL> Factorial;
    private List<T_URL> Commentary;
    private List<T_Reaction> Reactoin;
    private int stage;
    private int size;
    private int coordinX;
    private int coordinY;
    private int leaves;
    private int flowers;*/
}
