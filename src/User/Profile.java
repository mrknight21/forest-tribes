package User;

import java.io.Serializable;
import java.util.List;

/**
 * Created by mche618 on 5/06/2017.
 *
 * Profile is a class that can contain additional, but not essential, user information.
 * essential user information are defined as the information that are required during the registration, and stored in the same table with User object in the database.
 * Profile information are all optional to be filled in by users.
 *--Bryan
 */
public class Profile implements Serializable {

    private String username;
    private String gender;
    private String occupation;
    private String education;
    private String political;
    private String issues;

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
