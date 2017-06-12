package User;

import java.io.Serializable;
import java.util.List;

/**
 * Created by mche618 on 5/06/2017.
 */
public class Profile implements Serializable {

    String username;
    String gender;
    String occupation;
    String education;
    String political;
    String issues;

    public Profile() {

    }

    public Profile(String username,
                   String gender,
                   String occupation,
                   String education,
                   String political,
                   String issues) {

        this.username = username;
        this.gender = gender;
        this.occupation = occupation;
        this.education = education;
        this.political = political;
        this.issues = issues;
    }

    public String getUsername() {
        return this.username;
    }

    public String getGender() {
        return this.gender;
    }

    public String getOccupation() {
        return this.occupation;
    }

    public String getEducation() {
        return this.education;
    }

    public String getPolitical() {
        return this.political;
    }

    public String getIssues() {
        return this.issues;
    }
}
