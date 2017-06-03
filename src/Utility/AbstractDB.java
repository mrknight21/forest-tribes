package Utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public abstract class AbstractDB {

    protected final String driver;
    protected final String jdbcName;
    protected final String host;
    protected final String database;
    protected final int port;
    protected final String username;
    protected final String password;

    public AbstractDB(String driver, String jdbcName, String host, String database, int port, String username, String password) {
        this.driver = driver;
        this.jdbcName = jdbcName;
        this.host = host;
        this.database = database;
        this.port = port;
        this.username = username;
        this.password = password;
    }

    public String connectionString() {
        return "jdbc:" + this.jdbcName + "://" + this.host + ":" + this.port + "/" + this.database;
    }

    private Properties getProperties() {
        Properties properties = new Properties();
        properties.setProperty("user", this.username);
        properties.setProperty("password", this.password);
        properties.setProperty("useSSL", "true");

        return properties;
    }

    public Connection connection() throws ClassNotFoundException, SQLException {
        Connection c = null;

        Class.forName("com.mysql.jdbc.Driver");
        c = DriverManager.getConnection(connectionString(), getProperties());

        return c;
    }
}
