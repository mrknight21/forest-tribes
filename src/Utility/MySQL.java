package Utility;

public class MySQL extends AbstractDB {

    public MySQL() {
        super("com.mysql.jdbc.Driver", "mysql",
                Configuration.MYSQL_HOSTNAME,
                Configuration.MYSQL_DBNAME,
                Configuration.MYSQL_PORT,
                Configuration.MYSQL_USERNAME,
                Configuration.MYSQL_PASSWORD);
    }
}
