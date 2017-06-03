package User;

import java.awt.*;
import java.io.File;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Created by Barns on 3/06/17.
 */
public class User implements Serializable {

    private String username;
    private String first_name;
    private String last_name;
    private String email;
    private Date date_of_birth;
    private List<File> collectionList;
    private Image profileImage;

    public User() {

    }

    public User(String username, String first_name, String last_name, String email, Date date_of_birth, List<File> collectionList, Image profileImage) {
        this.username = username;
        this.first_name = first_name;
        this.last_name = last_name;
        this.email = email;
        this.date_of_birth = date_of_birth;
        this.collectionList = collectionList;
        this.profileImage = profileImage;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getDate_of_birth() {
        return date_of_birth;
    }

    public void setDate_of_birth(Date date_of_birth) {
        this.date_of_birth = date_of_birth;
    }

    public List<File> getCollectionList() {
        return collectionList;
    }

    public void setCollectionList(List<File> collectionList) {
        this.collectionList = collectionList;
    }

    public Image getProfileImage() {
        return profileImage;
    }

    public void setProfileImage(Image profileImage) {
        this.profileImage = profileImage;
    }
}
