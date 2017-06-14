package User;

import Utility.MiscellaneousUtility;
import Utility.MySQL;
import Utility.SecurityUtility;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.imageio.ImageIO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.*;

/**
 * Created by mche618 on 6/06/2017.
 */
public class Serve_UpdateProfilePicture extends HttpServlet {


    MySQL DB = new MySQL();
    private int maxFileSize = 5 * 1024 * 1024;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        if (!SecurityUtility.loggingStatusChecker(request)) {
            response.sendRedirect("login_interface/Login.jsp");
            return;
        }

        String newProfileImagePath = request.getParameter("DP_option");
        if (newProfileImagePath == null) {
            response.sendRedirect("user_interface/ProfilePictureUpdate.jsp");
            return;
        }

        String username = (String) request.getSession().getAttribute("username");
        User user = UserDAO.getUserByUserName(DB, username);

        updateDP(getServletContext().getRealPath(newProfileImagePath), username, user);

        response.sendRedirect("user_interface/ProfilePictureUpdate.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {

        String username = (String) request.getSession().getAttribute("username");
        User user = UserDAO.getUserByUserName(DB, username);

        String pathToUserFolder = getServletContext().getRealPath(user.getUserFolderPath());

        // Ensure user folder exists
        MiscellaneousUtility.createUserDir(getServletContext(),username);

        Boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        try {
            if (!isMultipart) {
                request.setAttribute("message", "No file uploaded or invalid file format. Please try again.");
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/user_interface/ProfilePictureUpdate.jsp");
                dispatcher.forward(request, response);
                return;
            }

            DiskFileItemFactory factory = new DiskFileItemFactory();
            // maximum size that will be stored in memory
            factory.setSizeThreshold(maxFileSize);
            // Location to save data that is larger than maxMemSize.
            factory.setRepository(new File("c:\\temp"));

            // Create a new file upload handler
            ServletFileUpload upload = new ServletFileUpload(factory);
            // maximum file size to be uploaded.
            upload.setSizeMax(maxFileSize);

            // Parse the request to get file items.
            java.util.List fileItems = upload.parseRequest(request);

            // Process the uploaded file items
            Iterator i = fileItems.iterator();


            while (i.hasNext()) {
                FileItem fi = (FileItem) i.next();
                if (!fi.isFormField()) {
                    // Get the uploaded file parameters

                    String fileName = fi.getName();
                    long sizeInBytes = fi.getSize();
                    if (createDP(request, response, username, user, pathToUserFolder, fi, fileName)) return;


                    response.sendRedirect("user_interface/ProfilePictureUpdate.jsp");
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (FileUploadException e) {
            e.printStackTrace();
        }
    }

    private boolean createDP(HttpServletRequest request, HttpServletResponse response, String username, User user, String pathToUserFolder, FileItem fi, String fileName) throws ServletException, IOException {
        //getting extention of the new image file
        String extension = "";
        int a = fileName.lastIndexOf('.');
        int p = Math.max(fileName.lastIndexOf('/'), fileName.lastIndexOf('\\'));
        if (a > p) {
            extension = fileName.substring(a + 1);
        }
        String newImageFilePath = user.getUserFolderPath() + "/User_profile_picture." + extension;
        UserDAO.updateProfileImagePath(DB, newImageFilePath, username);


        // Write the file
        File outputfile = new File(pathToUserFolder + "/User_profile_picture." + extension);
        try {
            fi.write(outputfile);

            //create thumnnail
            BufferedImage img = new BufferedImage(100, 100, BufferedImage.TYPE_INT_RGB);
            img.createGraphics().drawImage(ImageIO.read(new File(pathToUserFolder + "/User_profile_picture." + extension)).getScaledInstance(100, 100, Image.SCALE_SMOOTH), 0, 0, null);
            ImageIO.write(img, "jpg", new File(pathToUserFolder + "/User_profile_picture_thumb.jpg"));
        } catch (Exception e) {
            request.setAttribute("message", "No file uploaded or invalid file format. Please try again.");
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/user_interface/ProfilePictureUpdate.jsp");
            dispatcher.forward(request, response);
            return true;
        }
        return false;
    }

    private void updateDP(String newImagePath, String username, User user) throws IOException {
        // Get image extension
        String extension = "";
        int i = newImagePath.lastIndexOf('.');
        int p = Math.max(newImagePath.lastIndexOf('/'), newImagePath.lastIndexOf('\\'));
        if (i > p) {
            extension = newImagePath.substring(i + 1);
        }

        // Ensure user folders exist
        String userDirPath = getServletContext().getRealPath("/User/" + username);
        MiscellaneousUtility.DirCeation(new File(userDirPath));

        BufferedImage sourceImage = ImageIO.read(new File(newImagePath));

        String newImageFilePath = "";
        try {
            // retrieve image
            ImageIO.write(sourceImage, extension, new File(userDirPath + "/User_profile_picture." + extension));
            newImageFilePath = user.getUserFolderPath() + "/User_profile_picture." + extension;
            UserDAO.updateProfileImagePath(DB, newImageFilePath, username);

            //generate thumbnail for new profile picture image//
            BufferedImage img = new BufferedImage(100, 100, BufferedImage.TYPE_INT_RGB);
            img.createGraphics().drawImage(ImageIO.read(new File(userDirPath + "/User_profile_picture." + extension)).getScaledInstance(100, 100, Image.SCALE_SMOOTH), 0, 0, null);
            ImageIO.write(img, "jpg", new File(userDirPath + "/User_profile_picture_thumb.jpg"));
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }
}





