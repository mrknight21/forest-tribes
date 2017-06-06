package User;

import Article.Article;

import java.awt.*;
import java.io.File;
import java.io.Serializable;
import java.util.List;

public class User implements Serializable {

    private String username;
    private String first_name;
    private String last_name;
    private String email;
    private List<Article> collectionList;
    private String profileImagePath;
    private String userFolderPath;


    public User() {

    }

    public User(String username, String first_name, String last_name, String email) {
        this.username = username;
        this.first_name = first_name;
        this.last_name = last_name;
        this.email = email;
    }

    public User(String username, String first_name, String last_name, String email,  String profileImagePath, String userFolderPath) {
        this.username = username;
        this.first_name = first_name;
        this.last_name = last_name;
        this.email = email;
        this.profileImagePath = profileImagePath;
        this.userFolderPath = userFolderPath;
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

    public List<Article> getCollectionList() {
        return collectionList;
    }

    public void setCollectionList(List<Article> collectionList) {
        this.collectionList = collectionList;
    }

    public String getProfileImagePath() {
        return profileImagePath;
    }

    public void setProfileImagePath(String profileImagePath) {
        this.profileImagePath = profileImagePath;
    }

    public String getUserFolderPath() {
        return userFolderPath;
    }

    public void setUserFolderPath(String userFolderPath) {
        this.userFolderPath = userFolderPath;
    }
}
