-- SQL file to create the tables necessary for the final project

/* All tables created for the final project will start with
 the suffix, inFoJaxs. */

-- Statements to create the table which will store the User information.
DROP TABLE IF EXISTS inFoJaxs_User;

CREATE TABLE IF NOT EXISTS inFoJaxs_User (
  username VARCHAR(50) NOT NULL UNIQUE,
  first_name VARCHAR(25) NOT NULL,
  last_name VARCHAR(25) NOT NULL,
  email VARCHAR(50) NOT NULL,
  date_of_birth DATE,
  PRIMARY KEY (username)
);

-- Statements to create the table which will the UserSecurity information.
DROP TABLE IF EXISTS inFoJaxs_UserSecurity;

CREATE TABLE IF NOT EXISTS inFoJaxs_UserSecurity (
  userID INT AUTO_INCREMENT,
  username VARCHAR(50),
  salt BLOB NOT NULL,
  iterations INT NOT NULL,
  hash BLOB NOT NULL,
  PRIMARY KEY (userID),
  FOREIGN KEY (username) REFERENCES inFoJaxs_User(username)
);