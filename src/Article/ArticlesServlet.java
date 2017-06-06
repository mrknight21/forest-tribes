package Article;

import Utility.MySQL;
import org.json.simple.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Enumeration;

public class ArticlesServlet extends HttpServlet {

    private static final MySQL DB = new MySQL();

    protected String articlesRoot;

    @Override
    public void init( ){
        // Directory location of articles.
        articlesRoot = getServletContext().getRealPath("/WEB-INF/articles") + "/";
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {

        Enumeration<String> params = request.getParameterNames();

        if (params.hasMoreElements()) {
            // This is the result of either a submit form, or clear form
            int numFieldsFilledIn = storeUserArticleDataToJSON(request);

            if (numFieldsFilledIn == 0);
                // "<p>No information entered.</p><p>To return to the registration page, click <a href='Register'>here</a>.</p>"
        }
    }

    protected int storeUserArticleDataToJSON(HttpServletRequest request) {

        HttpSession session = request.getSession();

        String userName = (String) session.getAttribute("username");

        String articleTitle = request.getParameter("article-title");
        String articleContent = request.getParameter("article-content");

        File jsonFile = new File(articlesRoot + userName,articleTitle + ".json");

        System.out.println("storing data");

        JSONObject articleJSON = new JSONObject();
        JSONObject commentJSON = new JSONObject();


        articleJSON.put("article-title",articleTitle);
        articleJSON.put("article-content",articleContent);
        articleJSON.put("comments", commentJSON);

//        for (String key: keys) {
//            String value = request.getParameterValues(key)[0];
//            if (!value.isEmpty()) {
//                articleJSON.put(key, value);
//                count++;
//            }
//        }

        if (saveJSONObject(jsonFile, articleJSON)); // "<p>JSON file successfully saved to location = " + jsonFile + "</p>"
        // "<p><a href=\"Register\">Try again</a></p>"

        return 0;
    }

    private boolean saveJSONObject(File file, JSONObject jsonRecord) {
        boolean statusOK = true;

        String json_string = JSONObject.toJSONString(jsonRecord);

        BufferedWriter writer = null;

        try {
            writer = new BufferedWriter(new FileWriter(file));
            writer.write(json_string);
        }
        catch (IOException e) {
            statusOK = false;
            // "<p>Write error.</p>"
        }
        finally {
            try {if (writer != null) writer.close();}
            catch (IOException e) {
                // "<p>Write error.</p>"
                statusOK = false;}
        }
        return statusOK;
    }
}


/*
* doPost:
*
* Articles || Comments || replies
*
*
* Receive new articles in servlet request.
* Receive new comments in servlet request.
* Save to JSON
*
* doGet:
* For contents page - get user articles list from servlet and send to JSP.
* For article page - get article and comments from servlet and send to JSP.
*
* Same for comments, but load comments asynchronously with AJAX?
*
* */