package Utility;

import org.jsoup.Jsoup;

import javax.servlet.ServletContext;
import java.awt.*;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.File;
import java.security.SecureRandom;

/**
 * Created by mche618 on 5/06/2017.
 */
public class MiscellaneousUtility {

    //create scaled scaled buffered image
    public static BufferedImage scale(BufferedImage source, double ratio) {
        int w = (int) (source.getWidth() * ratio);
        int h = (int) (source.getHeight() * ratio);
        BufferedImage bi = getCompatibleImage(w, h);
        Graphics2D g2d = bi.createGraphics();
        double xScale = (double) w / source.getWidth();
        double yScale = (double) h / source.getHeight();
        AffineTransform at = AffineTransform.getScaleInstance(xScale,yScale);
        g2d.drawRenderedImage(source, at);
        g2d.dispose();
        return bi;
    }

    //create compatible
    public static BufferedImage getCompatibleImage(int w, int h) {
        GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
        GraphicsDevice gd = ge.getDefaultScreenDevice();
        GraphicsConfiguration gc = gd.getDefaultConfiguration();
        BufferedImage image = gc.createCompatibleImage(w, h);
        return image;
    }


    //check whether the user directory exist, if not create one.
    public static String createUserDir(ServletContext servletContext, String username) {
        String userDirPath = servletContext.getRealPath("/User/"+username);
        MiscellaneousUtility.DirCeation(new File(userDirPath));
        return userDirPath;
    }

    //check if a particular direcor exist, if not create one.
    public static boolean DirCeation (File theDir){
        if (!theDir.exists()) {
            System.out.println("creating directory: " + theDir.getName());

            try{
                theDir.mkdirs();
                System.out.println("DIR created");
                return true;
            }
            catch(SecurityException se){
                System.out.println(se.getMessage());
            }
        }
        return false;
    }

    //remove html tags in a string
    public static String htmlToStringParser (String html) {
        return Jsoup.parse(html).text();
    }

    static final String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    static SecureRandom rnd = new SecureRandom();


    //create random string for samples.
   public static String randomString( int len ){
        StringBuilder sb = new StringBuilder( len );
        for( int i = 0; i < len; i++ )
            sb.append( AB.charAt( rnd.nextInt(AB.length()) ) );
        return sb.toString();
    }
}