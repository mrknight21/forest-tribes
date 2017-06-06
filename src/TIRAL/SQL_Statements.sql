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
  profileImage VARCHAR(300) NOT NULL,
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

INSERT INTO inFoJaxs_User (username, first_name, last_name, email) VALUES
('programmer1', 'Bill', 'Gates','bill@microsoft.com'),
('programmer2', 'Mark', 'Zuckerburg', 'mark@facebook.com');

INSERT INTO inFoJaxs_Profile (username) VALUES
('programmer1');

DELETE FROM inFoJaxs_UserSecurity WHERE username=bryanchen

ALTER TABLE table_name
ADD column_name datatype;