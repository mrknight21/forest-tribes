package User;

import java.io.Serializable;

// this class store the password in salt, hash, iteration forms.

public class UserSecurity implements Serializable {

    private String username;
    private byte[] salt;
    private int iterations;
    private byte[] hash;

    public UserSecurity() {

    }

    public UserSecurity(String username, byte[] salt, int iterations, byte[] hash) {
        this.username = username;
        this.salt = salt;
        this.iterations = iterations;
        this.hash = hash;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public byte[] getSalt() {
        return salt;
    }

    public void setSalt(byte[] salt) {
        this.salt = salt;
    }

    public int getIterations() {
        return iterations;
    }

    public void setIterations(int iterations) {
        this.iterations = iterations;
    }

    public byte[] getHash() {
        return hash;
    }

    public void setHash(byte[] hash) {
        this.hash = hash;
    }
}
