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

DELETE * FROM inFoJaxs_User;

ALTER TABLE table_name
ADD column_name datatype;

INSERT INTO inFoJaxs_Articles (username, title, content, likes, views, commentCount, shortIntro) VALUES
('qwer', 'Big Data', 'My big data brings all the users to the yard!
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
Now let me see you make dat web semantic like a 3.0!', 500, 500, 100, 'lalalalalalalallalaal');

INSERT INTO inFoJaxs_Comments (username, content, parent_ID) VALUES
('will', 'Hello world', 1);

INSERT INTO inFoJaxs_Replies (username, content, parent_ID) VALUES
('will', 'Hello universe', 1);

INSERT INTO inFoJaxs_ArticleLikes (ID, likes) VALUES
(1, 100);
INSERT INTO inFoJaxs_CommentLikes (ID, likes) VALUES
(1, 10);
INSERT INTO inFoJaxs_ReplyLikes (ID, likes) VALUES
(1, 1);

UPDATE inFoJaxs_Articles SET content = 'Hello! Wordl! Hope it will update' WHERE ID = 1;