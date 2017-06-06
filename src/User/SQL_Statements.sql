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


DROP TABLE IF EXISTS inFoJaxs_Profile;
CREATE TABLE IF NOT EXISTS inFoJaxs_Profile (
  username VARCHAR(50) NOT NULL,
  date_Of_Birth CHAR(10),
  gender VARCHAR(6),
  occupation VARCHAR (20),
  education_level VARCHAR (30),
  political_Orientation VARCHAR (30),
  things_Loved VARCHAR (100),
  short_intro TEXT,
  CHECK (date_Of_Birth Like '__/__/____' ),
  PRIMARY KEY (username),
  FOREIGN KEY (username) REFERENCES inFoJaxs_User(username)
);

DROP TABLE IF EXISTS inFoJaxs_IssuesCared;
CREATE TABLE IF NOT EXISTS inFoJaxs_IssuesCared (
  ID INT AUTO_INCREMENT,
  username VARCHAR(50) NOT NULL,
  issues_Cared VARCHAR (50) NOT NULL ,
  PRIMARY KEY (ID),
  FOREIGN KEY (username) REFERENCES inFoJaxs_User(username)
);

DROP TABLE IF EXISTS inFoJaxs_Articles;
CREATE TABLE IF NOT EXISTS inFoJaxs_Articles (
  ID INT AUTO_INCREMENT,
  username VARCHAR(50) NOT NULL,
  title VARCHAR(80) NOT NULL,
  article VARCHAR (8000) NOT NULL,
#   created TIMESTAMP,
#   lastEdit TIMESTAMP,
  PRIMARY KEY (ID),
  FOREIGN KEY (username) REFERENCES inFoJaxs_User(username)
);

DROP TABLE IF EXISTS inFoJaxs_Comments;
CREATE TABLE IF NOT EXISTS inFoJaxs_Comments (
  ID INT AUTO_INCREMENT,
  article_ID INT,
  username VARCHAR(50),
  comment VARCHAR (8000) NOT NULL,
#   created TIMESTAMP,
#   lastEdit TIMESTAMP,
  PRIMARY KEY (ID),
  FOREIGN KEY (username) REFERENCES inFoJaxs_User(username),
  FOREIGN KEY (article_ID) REFERENCES inFoJaxs_Articles(ID)
);

DROP TABLE IF EXISTS inFoJaxs_Replies;
CREATE TABLE IF NOT EXISTS inFoJaxs_Replies (
  ID INT AUTO_INCREMENT,
  comment_ID INT,
  username VARCHAR(50) NOT NULL,
  reply VARCHAR (8000) NOT NULL,
#   created TIMESTAMP,
#   lastEdit TIMESTAMP,
  PRIMARY KEY (ID),
  FOREIGN KEY (username) REFERENCES inFoJaxs_User(username),
  FOREIGN KEY (comment_ID) REFERENCES inFoJaxs_Comments(ID)
);

DROP TABLE IF EXISTS inFoJaxs_Likes;
CREATE TABLE IF NOT EXISTS inFoJaxs_Likes (
  ID VARCHAR(8000) NOT NULL,
  likes INT,
  PRIMARY KEY (ID)
);

DELETE FROM inFoJaxs_User
WHERE username = 'BarnsNZ';