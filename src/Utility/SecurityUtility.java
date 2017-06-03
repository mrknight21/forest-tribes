package Utility;

import User.UserSecurity;
import User.UserSecurityDAO;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.util.Arrays;
import java.util.Base64;
import java.util.List;
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

/**
 * @author Cameron Grout
 *
 * A utility class to hash passwords and check passwords vs hashed values. Based on code from
 * <a href="http://stackoverflow.com/a/18143616">this StackOverflow post</a>, modified to be
 * inline with OWASP recommendations for algorithm and salt length. Overloads and base64 helpers
 * have been added for ease-of-use.
 */
public class SecurityUtility {

    private static final MySQL DB = new MySQL();
    private static final Random RANDOM = new SecureRandom();
    private static final int MIN_ITERATIONS = 50_000;
    private static final int MAX_ITERATIONS = 100_000;
    private static final int KEY_LENGTH = 512;
    private static final int DEFAULT_SALT_LENGTH = 32;

    /**
     * static utility class
     */
    private SecurityUtility() { }

    /**
     * Returns a random salt to be used to hash a password. DEFAULT_SALT_LENGTH is used as
     * the default salt length.
     *
     * @return a DEFAULT_SALT_LENGTH bytes random salt
     */
    public static byte[] getNextSalt() {
        return getNextSalt(DEFAULT_SALT_LENGTH);
    }

    /**
     * Returns a random salt to be used to hash a password.
     *
     * @param saltLength Size of salt in bytes
     *
     * @return A saltLength bytes random salt
     */
    public static byte[] getNextSalt(int saltLength) {
        byte[] salt = new byte[saltLength];
        RANDOM.nextBytes(salt);
        return salt;
    }

    /**
     * Returns a SHA-512 hashed password, with no salting or iterating. <br>
     * Note - Do not use this as a password hashing approach! This is here so that you
     * can experiment with doing things the wrong way.
     *
     * @param password The password to hash
     *
     * @return SHA-512 hashed version of password
     */
    public static byte[] insecureHash(String password) {
        try {
            MessageDigest mda = MessageDigest.getInstance("SHA-512");
            return mda.digest(password.getBytes());
        } catch (NoSuchAlgorithmException e) {
            throw new AssertionError("Error while hashing a password: " + e.getMessage(), e);
        }
    }
    /**
     * Returns true if the given password matches the hashed value, false otherwise.<br>
     *
     * Note - Do not use this as a password hashing approach! This is here so that you
     * can experiment with doing things the wrong way.
     *
     * @param password     the password to check
     * @param expectedHash the expected hashed value of the password
     *
     * @return true if the given password matches the hashed value, false otherwise
     */
    public static boolean isInsecureHashMatch(String password, byte[] expectedHash) {
        byte[] pwdHash = insecureHash(password);

        if (pwdHash.length != expectedHash.length) {
            return false;
        }

        for (int i = 0; i < pwdHash.length; i++) {
            if (pwdHash[i] != expectedHash[i]) {
                return false;
            }
        }

        return true;
    }

    /**
     * Returns a salted and hashed password using the provided hash. MAX_ITERATIONS
     * is used for the iteration count in the hashing process.<br>
     * Note - side effect: the password is destroyed (the char[] is filled with zeros)
     *
     * @param password the password to be hashed
     * @param salt     a 16 bytes salt, ideally obtained with the getNextSalt method
     *
     * @return the hashed password with a pinch of salt
     */
    public static byte[] hash(char[] password, byte[] salt) {
        return hash(password, salt, MAX_ITERATIONS);
    }

    /**
     * Returns a salted and hashed password using the provided hash.<br>
     * Note - side effect: the password is destroyed (the char[] is filled with zeros)
     *
     * @param password   the password to be hashed
     * @param salt       a 16 bytes salt, ideally obtained with the getNextSalt method
     * @param iterations the number of iterations to use in the hashing process
     *
     * @return the hashed password with a pinch of salt
     */
    public static byte[] hash(char[] password, byte[] salt, int iterations) {
        PBEKeySpec spec = new PBEKeySpec(password, salt, iterations, KEY_LENGTH);

        // Blank out the provided password array - prevents accidental leakage of this information
        Arrays.fill(password, Character.MIN_VALUE);

        try {
            SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA512");
            return skf.generateSecret(spec).getEncoded();
        } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
            throw new AssertionError("Error while hashing a password: " + e.getMessage(), e);
        } finally {
            spec.clearPassword();
        }
    }

    /**
     * Returns true if the given password and salt match the hashed value, false otherwise.
     * MAX_ITERATIONS is used for the iteration count in the hashing process.<br>
     * Note - side effect: the password is destroyed (the char[] is filled with zeros)
     *
     * @param password     the password to check
     * @param salt         the salt used to hash the password
     * @param expectedHash the expected hashed value of the password
     *
     * @return true if the given password and salt match the hashed value, false otherwise
     */
    public static boolean isExpectedPassword(char[] password, byte[] salt, byte[] expectedHash) {
        return isExpectedPassword(password, salt, MAX_ITERATIONS, expectedHash);
    }

    /**
     * Returns true if the given password and salt match the hashed value, false otherwise.<br>
     * Note - side effect: the password is destroyed (the char[] is filled with zeros)
     *
     * @param password     the password to check
     * @param salt         the salt used to hash the password
     * @param iterations   the number of iterations to use in the hashing process
     * @param expectedHash the expected hashed value of the password
     *
     * @return true if the given password and salt match the hashed value, false otherwise
     */
    public static boolean isExpectedPassword(char[] password, byte[] salt, int iterations, byte[] expectedHash) {
        byte[] pwdHash = hash(password, salt, iterations);

        // Blank out the provided password array - prevents accidental leakage of this information
        Arrays.fill(password, Character.MIN_VALUE);

        if (pwdHash.length != expectedHash.length) {
            return false;
        }

        for (int i = 0; i < pwdHash.length; i++) {
            if (pwdHash[i] != expectedHash[i]) {
                return false;
            }
        }

        return true;
    }

    /**
     * Decodes a base64 encoded string into its byte array equivalent
     *
     * @param b64 A base64 encoded String
     *
     * @return A byte array representing the data encoded in the b64 argument string
     * @throws IllegalArgumentException Thrown if the argument b64 is not a valid base64 string
     */
    public static byte[] base64Decode(String b64) throws IllegalArgumentException {
        return Base64.getDecoder().decode(b64);
    }

    /**
     * Convert a byte array into a base64 string representation for ease of printing and storage
     *
     * @param array Byte data to encode in base64
     *
     * @return A base64 encoded String representing the data contained in the array
     */
    public static String base64Encode(byte[] array) {
        return Base64.getEncoder().encodeToString(array);
    }

    public static int getNextIteration() {
        return ThreadLocalRandom.current().nextInt(MIN_ITERATIONS, MAX_ITERATIONS + 1);
    }

    public static boolean loggingStatusChecker(HttpServletRequest request) throws IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("loggingStatus") == null) return false;

        String username = (String) session.getAttribute("username");

        if (username != null) {
            List<UserSecurity> users = UserSecurityDAO.getAllUsers(DB);
            for (UserSecurity user : users) if ((user.getUsername()).equals(username)) return true;
        }
        return false;
    }

    public static boolean passwordAuthentication(String username, String password) {

        char[] passwordArray = password.toCharArray();

        // Get the user relating to the parsed-in username from the database.
        UserSecurity user = UserSecurityDAO.getUser(DB, username);

        // Get the salt byte array assigned to the user.
        byte[] salt = user.getSalt();

        // Get the hash byte array assigned to the user.
        byte[] hash = user.getHash();

        // Get the iterations, assigned to the user.
        int iterations = user.getIterations();

        // Call SecurityUtility method, isExpectedPassword to determine whether the user-parsed password matches the password stored in the database. The the result is returned.
        return SecurityUtility.isExpectedPassword(passwordArray, salt, iterations, hash);
    }
}
