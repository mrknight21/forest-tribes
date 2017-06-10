package Utility;

import org.jsoup.Jsoup;

import java.awt.*;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.File;

/**
 * Created by mche618 on 5/06/2017.
 */
public class MicellaneousUntility {


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

    public static BufferedImage getCompatibleImage(int w, int h) {
        GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
        GraphicsDevice gd = ge.getDefaultScreenDevice();
        GraphicsConfiguration gc = gd.getDefaultConfiguration();
        BufferedImage image = gc.createCompatibleImage(w, h);
        return image;
    }



    public static boolean DirCeation (File theDir){
        boolean result = false;
        if (!theDir.exists()) {
            System.out.println("creating directory: " + theDir.getName());

            try{
                theDir.mkdir();
                result = true;
            }
            catch(SecurityException se){
                System.out.println(se.getMessage());
            }
            if(result) {
                System.out.println("DIR created");
            }
        }
        return result;
    }
    public static String htmlToStringParser (String html) {
        return Jsoup.parse(html).text();
    }




}
