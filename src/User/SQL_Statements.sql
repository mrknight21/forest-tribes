-- SQL file to create the tables necessary for the final project

/* All tables created for the final project will start with
 the suffix, inFoJaxs. */

-- Statements to create the table which will store the User information.
DROP TABLE IF EXISTS inFoJaxs_User;

CREATE TABLE IF NOT EXISTS inFoJaxs_User (
  username      VARCHAR(50) NOT NULL UNIQUE,
  first_name    VARCHAR(25) NOT NULL,
  last_name     VARCHAR(25) NOT NULL,
  email         VARCHAR(50) NOT NULL,
  date_of_birth DATE,
  PRIMARY KEY (username)
);

-- Statements to create the table which will the UserSecurity information.
DROP TABLE IF EXISTS inFoJaxs_UserSecurity;

CREATE TABLE IF NOT EXISTS inFoJaxs_UserSecurity (
  userID     INT AUTO_INCREMENT,
  userGoogleID INT UNIQUE,
  userFacebookID INT UNIQUE,
  username   VARCHAR(50),
  salt       BLOB NOT NULL,
  iterations INT  NOT NULL,
  hash       BLOB NOT NULL,
  PRIMARY KEY (userID),
  FOREIGN KEY (username) REFERENCES inFoJaxs_User (username)
);

DROP TABLE IF EXISTS inFoJaxs_UserSSO;

CREATE TABLE IF NOT EXISTS inFoJaxs_UserSSO (
  userGoogleID INT,
  userFacebookID INT UNIQUE,
  username   VARCHAR(50),
  PRIMARY KEY (userGoogleID),
  FOREIGN KEY (username) REFERENCES inFoJaxs_User (username)
);

DROP TABLE IF EXISTS inFoJaxs_Profile;
CREATE TABLE IF NOT EXISTS inFoJaxs_Profile (
  username   VARCHAR(50) NOT NULL,
  gender     VARCHAR(6),
  occupation VARCHAR(50),
  education  VARCHAR(30),
  political  VARCHAR(30),
  issues     VARCHAR(500),
  PRIMARY KEY (username),
  FOREIGN KEY (username) REFERENCES inFoJaxs_User (username)
);

DROP TABLE IF EXISTS inFoJaxs_IssuesCared;
CREATE TABLE IF NOT EXISTS inFoJaxs_IssuesCared (
  ID           INT AUTO_INCREMENT,
  username     VARCHAR(50) NOT NULL,
  issues_Cared VARCHAR(50) NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (username) REFERENCES inFoJaxs_User (username)
);

ALTER TABLE inFoJaxs_User
  ADD UserFolderPath VARCHAR(400) NULL;
UPDATE inFoJaxs_User
SET ProfileImagePath = NULL


DROP TABLE IF EXISTS inFoJaxs_ReplyLikes;
DROP TABLE IF EXISTS inFoJaxs_CommentLikes;
DROP TABLE IF EXISTS inFoJaxs_ArticleLikes;
DROP TABLE IF EXISTS inFoJaxs_Replies;
DROP TABLE IF EXISTS inFoJaxs_Comments;
DROP TABLE IF EXISTS inFoJaxs_Articles;


CREATE TABLE IF NOT EXISTS inFoJaxs_Articles (
  ID           INT       AUTO_INCREMENT,
  username     VARCHAR(50) NOT NULL,
  title        VARCHAR(80) NOT NULL,
  content      TEXT        NOT NULL,
  likes        INT,
  views        INT,
  commentCount INT,
  shortIntro   VARCHAR(120),
  creationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  lastEdit     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ID),
  FOREIGN KEY (username) REFERENCES inFoJaxs_User (username)
    ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS inFoJaxs_Comments (
  ID           INT       AUTO_INCREMENT,
  parent_ID    INT           NOT NULL,
  username     VARCHAR(50)   NOT NULL,
  content      VARCHAR(8000) NOT NULL,
  likes        INT,
  views        INT,
  repliesCount INT,
  creationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  lastEdit     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ID),
  FOREIGN KEY (username) REFERENCES inFoJaxs_User (username)
    ON DELETE CASCADE,
  FOREIGN KEY (parent_ID) REFERENCES inFoJaxs_Articles (ID)
    ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS inFoJaxs_Replies (
  ID           INT       AUTO_INCREMENT,
  parent_ID    INT           NOT NULL,
  username     VARCHAR(50)   NOT NULL,
  content      VARCHAR(8000) NOT NULL,
  likes        INT,
  views        INT,
  creationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  lastEdit     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ID),
  FOREIGN KEY (username) REFERENCES inFoJaxs_User (username)
    ON DELETE CASCADE,
  FOREIGN KEY (parent_ID) REFERENCES inFoJaxs_Comments (ID)
    ON DELETE CASCADE
);


/*

    private String title;
    private List<T_URL> factual;
    private List<T_URL> commentary;
    private List<T_Reaction> reactoin;
    private int stage;
    private int size;
    private int exp;
    private int coordinX;
    private int coordinY;
    private int leaves;


    /* protected int id;
    protected String author;
    protected String dateCreated;
    protected String dateLastEdited;
    protected int likes;
    protected String text;
    protected int views;*/
DROP TABLE IF EXISTS inFoJaxs_Tree_Commentary_URL;
DROP TABLE IF EXISTS inFoJaxs_Tree_Factual_URL;
DROP TABLE IF EXISTS inFoJaxs_Tree_Reaction_Replies;
DROP TABLE IF EXISTS inFoJaxs_Tree_Reactions;
DROP TABLE IF EXISTS inFoJaxs_Tree_Trees;


CREATE TABLE IF NOT EXISTS inFoJaxs_Tree_Trees (
  ID           INT       AUTO_INCREMENT,
  username     VARCHAR(50)  NOT NULL,
  title        VARCHAR(200) NOT NULL,
  content      TEXT         NOT NULL,
  likes        INT,
  views        INT,
  exp          INT,
  stage        INT,
  size         INT,
  XCoordinate  INT,
  YCoordinate  INT,
  leaves       INT,
  creationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  lastEdit     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ID),
  FOREIGN KEY (username) REFERENCES inFoJaxs_User (username)
    ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS inFoJaxs_Tree_Reactions (
  ID           INT       AUTO_INCREMENT,
  parent_ID    INT           NOT NULL,
  username     VARCHAR(50)   NOT NULL,
  content      VARCHAR(8000) NOT NULL,
  likes        INT,
  views        INT,
  repliesCount INT,
  support_for  BOOLEAN,
  creationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  lastEdit     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ID),
  FOREIGN KEY (username) REFERENCES inFoJaxs_User (username)
    ON DELETE CASCADE,
  FOREIGN KEY (parent_ID) REFERENCES inFoJaxs_Tree_Trees (ID)
    ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS inFoJaxs_Tree_Reaction_Replies (
  ID           INT       AUTO_INCREMENT,
  parent_ID    INT           NOT NULL,
  username     VARCHAR(50)   NOT NULL,
  content      VARCHAR(8000) NOT NULL,
  likes        INT,
  views        INT,
  creationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  lastEdit     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ID),
  FOREIGN KEY (username) REFERENCES inFoJaxs_User (username)
    ON DELETE CASCADE,
  FOREIGN KEY (parent_ID) REFERENCES inFoJaxs_Tree_Reactions (ID)
    ON DELETE CASCADE
);


/*
boolean supportForArgument;
    boolean isfactual;
    String URL;
 */


CREATE TABLE IF NOT EXISTS inFoJaxs_Tree_Factual_URL (
  ID           INT       AUTO_INCREMENT,
  parent_ID    INT           NOT NULL,
  username     VARCHAR(50)   NOT NULL,
  title        VARCHAR(200)  NOT NULL,
  URL          VARCHAR(8000) NOT NULL,
  content      VARCHAR(8000) NOT NULL,
  likes        INT,
  views        INT,
  support_for  BOOLEAN,
  creationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  lastEdit     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ID),
  FOREIGN KEY (username) REFERENCES inFoJaxs_User (username)
    ON DELETE CASCADE,
  FOREIGN KEY (parent_ID) REFERENCES inFoJaxs_Tree_Trees (ID)
    ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS inFoJaxs_Tree_Commentary_URL (
  ID           INT       AUTO_INCREMENT,
  parent_ID    INT           NOT NULL,
  username     VARCHAR(50)   NOT NULL,
  title        VARCHAR(200)  NOT NULL,
  URL          VARCHAR(8000) NOT NULL,
  content      VARCHAR(8000) NOT NULL,
  likes        INT,
  views        INT,
  support_for  BOOLEAN,
  creationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  lastEdit     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ID),
  FOREIGN KEY (username) REFERENCES inFoJaxs_User (username)
    ON DELETE CASCADE,
  FOREIGN KEY (parent_ID) REFERENCES inFoJaxs_Tree_Trees (ID)
    ON DELETE CASCADE
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


INSERT INTO inFoJaxs_Tree_Factual_URL (parent_ID, username, title, URL,  content, likes, views, bcar289.inFoJaxs_Tree_Factual_URL.support_for) VALUES
  (152, 'zxcv', 'yo! yo! yo! yo! yo! yo!', 'yahoo.com.tw', 'alalalalalaalalalallaalalalalaalala', 0, 0, FALSE  );

INSERT INTO inFoJaxs_Replies (parent_ID, username, content, likes, views) VALUES
  (2, 'zxcv', 'aahahhahahhahahahahahahahahahahahhahaahahahah!', 1000, 1000);


SELECT ID FROM inFoJaxs_Tree_Trees WHERE id=(SELECT MAX(id) FROM inFoJaxs_Tree_Trees)