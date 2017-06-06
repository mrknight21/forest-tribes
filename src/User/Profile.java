package User;

import java.io.Serializable;

/**
 * Created by mche618 on 5/06/2017.
 */
public class Profile implements Serializable {

    String username;
    String dateOfBirth;
    String gender;
    String occupation;
    String education_level;
    String politicalOri;
    String thingsLoves;
    String short_intro;
    String[] issues;


    public Profile(){

    }


    public Profile(String username,
            String dateOfBirth,
            String gender,
            String occupation,
            String education_level,
            String politicalOri,
            String thingsLoves,
            String short_intro,
            String[] issues){

        this.username = username;
        this.dateOfBirth = dateOfBirth;
        this.gender =gender;
        this.occupation =occupation;
        this.education_level = education_level;
        this.politicalOri = politicalOri;
        this.thingsLoves = thingsLoves;
        this.short_intro = short_intro;
        this.issues = issues;
    }


    public String getUsername(){
        return this.username;
    }

    public String getDateOfBirth(){
        return this.dateOfBirth;
    }

    public String getGender(){
        return this.gender;
    }

    public String getOccupation(){
        return this.occupation;
    }
    public String getEducation_level(){
        return this.education_level;
    }

    public String getPoliticalOri(){
        return this.politicalOri;
    }
    public String getThingsLoves(){
        return this.thingsLoves;
    }

    public String getShort_intro(){
        return this.short_intro;
    }

    public String[] getIssues(){
        return this.issues;
    }

}
