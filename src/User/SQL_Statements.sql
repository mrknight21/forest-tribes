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

ALTER TABLE inFoJaxs_User
ADD UserFolderPath VARCHAR (400) NULL ;
Update inFoJaxs_User set ProfileImagePath = NULL


DROP TABLE IF EXISTS inFoJaxs_ReplyLikes;
DROP TABLE IF EXISTS inFoJaxs_CommentLikes;
DROP TABLE IF EXISTS inFoJaxs_ArticleLikes;
DROP TABLE IF EXISTS inFoJaxs_Replies;
DROP TABLE IF EXISTS inFoJaxs_Comments;
DROP TABLE IF EXISTS inFoJaxs_Articles;


CREATE TABLE IF NOT EXISTS inFoJaxs_Articles (
  ID INT AUTO_INCREMENT,
  username VARCHAR(50) NOT NULL,
  title VARCHAR(80) NOT NULL,
  content TEXT NOT NULL,
  likes INT,
  views INT,
  commentCount INT,
  shortIntro VARCHAR(120),
  creationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  lastEdit TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ID),
  FOREIGN KEY (username) REFERENCES inFoJaxs_User(username)
);

CREATE TABLE IF NOT EXISTS inFoJaxs_Comments (
  ID INT AUTO_INCREMENT,
  parent_ID INT NOT NULL,
  username VARCHAR(50) NOT NULL ,
  content VARCHAR (8000) NOT NULL,
  likes INT,
  views INT,
  repliesCount INT,
  creationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  lastEdit TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ID),
  FOREIGN KEY (username) REFERENCES inFoJaxs_User(username),
  FOREIGN KEY (parent_ID) REFERENCES inFoJaxs_Articles(ID)
);

CREATE TABLE IF NOT EXISTS inFoJaxs_Replies (
  ID INT AUTO_INCREMENT,
  parent_ID INT NOT NULL ,
  username VARCHAR(50) NOT NULL,
  content VARCHAR (8000) NOT NULL,
  likes INT,
  views INT,
  creationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  lastEdit TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ID),
  FOREIGN KEY (username) REFERENCES inFoJaxs_User(username),
  FOREIGN KEY (parent_ID) REFERENCES inFoJaxs_Comments(ID)
);
/*CREATE TABLE IF NOT EXISTS inFoJaxs_ArticleLikes (
  ID INT,
  likes INT DEFAULT 0,
  PRIMARY KEY (ID),
  FOREIGN KEY (ID) REFERENCES inFoJaxs_Articles(ID)
);

CREATE TABLE IF NOT EXISTS inFoJaxs_CommentLikes (
  ID INT,
  likes INT DEFAULT 0,
  PRIMARY KEY (ID),
  FOREIGN KEY (ID) REFERENCES inFoJaxs_Comments(ID)
);

CREATE TABLE IF NOT EXISTS inFoJaxs_ReplyLikes (
  ID INT,
  likes INT DEFAULT 0,
  PRIMARY KEY (ID),
  FOREIGN KEY (ID) REFERENCES inFoJaxs_Replies(ID)
);*/


INSERT INTO inFoJaxs_Articles (username, title, content, ) VALUES
  ('will', 'Big Data', 'My big data brings all the users to the yard!
Dam right. It''s better than yours. Dam right. It''s better than yours.
You could have some, but I''d have to charge.
A freemium plan.
Wake up in the morning feeling like PHP.
Poppin code in the box, like a wizard.
When we revolt we do it right social data getting slizzard.
Now n-n-n-n-now I''m feeling so fly like a GGG thing. Like a GGG thing, like a GGG thing.
Yeah oh yeah make you put your hands up make you put your hands up pu-put your put your hands up.
Now make dat web semantic like a 3.0!
Break some, shake some, work some, tweak some.
Break some, shake some, work some, tweak some.
Break it shake it work it tweak it.
Break it shake it work it tweak it.
Bounce bounce bounce bounce bounce bounce bounce!
Now drop it drop it to the floor.
Spin it like some stop and go.
Drop it drop it to the floor.
Spin it like some stop and go.
Now let me see you make dat web semantic like a 3.0!');