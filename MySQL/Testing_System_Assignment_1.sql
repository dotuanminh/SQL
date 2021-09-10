DROP DATABASE IF EXISTS  `Testing_System_1` ; 
CREATE DATABASE `Testing_System_1`; 
USE `Testing_System_1`; 

DROP TABLE IF EXISTS `Department`;
CREATE TABLE `Department`(
	DepartmentID TINYINT UNSIGNED PRIMARY KEY, 
    DepartmentName NVARCHAR(50) 
);

DROP TABLE IF EXISTS `Position`;
CREATE TABLE `Position`(
	PositionID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT ,
    PositionName NVARCHAR(50)
);

DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account`(
	AccountID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Email VARCHAR(50),
    Username VARCHAR(50),
    FullName VARCHAR(50),
    DepartmentID TINYINT UNSIGNED, 
    PositionID INT UNSIGNED, 
    CreateDate DATE,
    CONSTRAINT fk_account1 FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
    CONSTRAINT fk_account2 FOREIGN KEY (PositionID) REFERENCES `Position`(PositionID)
    );

DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group`(
	GroupID	INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
 	GroupName VARCHAR(50),
 	CreatorID INT UNSIGNED,
	CreateDate DATE,
    CONSTRAINT fk_group FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

DROP TABLE IF EXISTS `GroupAccount`;
CREATE TABLE `GroupAccount`(
	GroupID	INT UNSIGNED,
 	AccountID INT UNSIGNED,
    JoinDate DATE ,
    CONSTRAINT pk_groupaccount PRIMARY KEY(GroupID,AccountID) ,
    CONSTRAINT fk_groupaccount1 FOREIGN KEY (GroupID) REFERENCES `Group`(GroupID),
    CONSTRAINT fk_groupaccount2 FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID)
);

DROP TABLE IF EXISTS `TypeQuestion`;
CREATE TABLE `TypeQuestion`(
	TypeID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, 
    TypeName ENUM('Essay','Multiple-Choice')
);

DROP TABLE IF EXISTS `CategoryQuestion`;
CREATE TABLE `CategoryQuestion`(
	CategoryID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
 	CategoryName VARCHAR(50)
);

DROP TABLE IF EXISTS `Question`;
CREATE TABLE `Question`(
	QuestionID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	Content VARCHAR(50),
 	CategoryID INT UNSIGNED,
 	TypeID INT UNSIGNED,
 	CreatorID INT UNSIGNED,
	CreateDate DATE,
    CONSTRAINT fk_question1 FOREIGN KEY (CategoryID) REFERENCES `CategoryQuestion`(CategoryID),
    CONSTRAINT fk_question2 FOREIGN KEY (TypeID) REFERENCES `TypeQuestion`(TypeID),
    CONSTRAINT fk_question3 FOREIGN KEY (CreatorID) REFERENCES `Group`(CreatorID)
);

DROP TABLE IF EXISTS `Answer`;
CREATE TABLE `Answer`(
	AnswerID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT ,
	Content VARCHAR(50),
	QuestionID INT UNSIGNED,
	isCorrect BIT,
    CONSTRAINT fk_answer1 FOREIGN KEY (QuestionID) REFERENCES `Question`(QuestionID)
);

DROP TABLE IF EXISTS `Exam`;
CREATE TABLE `Exam`(
	ExamID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	Code VARCHAR(50),
	Title VARCHAR(50),
	CategoryID INT UNSIGNED,
	Duration INT UNSIGNED,
	CreatorID INT UNSIGNED,
	CreateDate DATE,
    CONSTRAINT fk_exam1 FOREIGN KEY (CategoryID) REFERENCES `CategoryQuestion`(CategoryID),
    CONSTRAINT fk_exam2 FOREIGN KEY (CreatorID) REFERENCES `Group`(CreatorID)
);

DROP TABLE IF EXISTS `ExamQuestion`;
CREATE TABLE `ExamQuestion`(
	ExamID INT UNSIGNED, 
	QuestionID INT UNSIGNED,
    CONSTRAINT pk_examquestion PRIMARY KEY(ExamID),
    CONSTRAINT fk_examquestion1 FOREIGN KEY (ExamID) REFERENCES Exam(ExamID),
    CONSTRAINT fk_examquestion2 FOREIGN KEY (QuestionID) REFERENCES `Question`(QuestionID)
);














