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

INSERT INTO `Department`(DepartmentID,DepartmentName)
VALUES	(1,'Dev');
INSERT INTO `Department`(DepartmentID,DepartmentName)
VALUES	(2,'PM');
INSERT INTO `Department`(DepartmentID,DepartmentName)
VALUES	(3,'Director');
INSERT INTO `Department`(DepartmentID,DepartmentName)
VALUES	(4,'Accoutant');
INSERT INTO `Department`(DepartmentID,DepartmentName)
VALUES	(5,'Sale');

INSERT INTO Position (PositionID, PositionName)
VALUES
						(1, 		'Dev'          ),
						(2, 		'Test'         ),
						(3, 		'Scrum Master' ),
						(4, 		'PM'           ),
                        (5, 		'CEO'			);
-- Thêm dữ liệu vào bảng Account
INSERT INTO `Account` 	(AccountID, 	Email, 					UserName, 			FullName, 				DepartmentID, 			PositionID,			 CreateDate)
VALUES
						(1, 			'minh@gmail.com', 		'Minh2207', 		'Do Tuan Minh', 		2, 						1, 					'2021/01/02'),
						(2, 			'linh@gmail.com', 		'Linh1207', 		'Pham Dieu Linh', 		1, 						1, 					'2021/02/03'),
						(3, 			'giang@gmail.com', 		'giang 123', 		'Nguyen Hau Giang', 	3, 						4, 					'2021/03/04'),
						(4, 			'binh@gmail.com', 		'Binh1234', 		'Nguyen Hai Binh', 		4, 						2, 					'2021/04/05'),
						(5, 			'van@gmail.com', 		'vantholailang', 	'Hua Vi Van',		 	5, 						2, 					'2021/05/06');
-- Thêm dữ liệu vào bảng Group
INSERT INTO `Group`		(GroupID, 		GroupName, 			CreatorID, 			CreateDate)
VALUES
						(1, 			'Group_A', 			1, 				'2021/07/02'),
						(2, 			'Group_B',			2, 				'2021/07/12'),
						(3, 			'Group_C', 			3,				'2021/02/13'),
						(4, 			'Group_D', 			4, 				'2021/07/12'),
						(5, 			'Group_E', 			5, 				'2021/06/16');

INSERT INTO GroupAccount(GroupID, 			AccountID, 		JoinDate)
VALUES
							(1, 			2, 				'2021/06/29'),
							(2, 			1, 				'2021/04/04'),
							(3, 			3, 				'2021/06/07'),
							(4, 			5, 				'2021/04/03'),
							(5, 			4, 				'2021/05/04');
                            
INSERT INTO TypeQuestion	(TypeID, 	TypeName)
VALUES
							(1, 'Essay'),
							(2, 'Multiple-Choice'),
							(3, 'Essay'),
							(4, 'Multiple-Choice'),
							(5, 'Essay');
-- Thêm dữ liệu vào bảng Category Question
INSERT INTO CategoryQuestion(CategoryID, CategoryName)
VALUES
							(12, 'Category1'),
							(13, 'Category2'),
							(14, 'Category3'),
							(15, 'Category4'),
							(16, 'Category5');
-- Thêm dữ liệu vào bảng Question
INSERT INTO Question(QuestionID, Content, CategoryID, TypeID, CreatorID, CreateDate)
VALUES
(1, 'Q1', 12,1, 1, '2021/05/04'),
(2, 'Q2', 13,2, 2, '2021/03/02'),
(3, 'Q3', 14,3, 3, '2021/01/07'),
(4, 'Q4', 15,4, 4, '2021/07/22'),
(5, 'Q5', 16,5,5, '2021/07/12');
-- Thêm dữ liệu vào bảng Answer
INSERT INTO Answer(AnswerID, Content, QuestionID, isCorrect)
VALUES
(1, 'A1', 1, 1),
(2, 'A2', 2, 0),
(3, 'A3', 3, 1),
(4, 'A4', 4, 1),
(5, 'A5', 5, 0);
-- Thêm dữ liệu vào bảng Exam
INSERT INTO Exam(ExamID, `Code`, Title, CategoryID, Duration, CreatorID, CreateDate)
VALUES
(1, 39210, 'Title1', 12, 3600, 1, '2021/06/20'),
(2, 12312, 'Title2', 16, 3600, 2, '2021/07/20'),
(3, 23443, 'Title3', 13, 3600, 3, '2021/05/20'),
(4, 65673, 'Title4', 15, 3600, 4, '2021/09/20'),
(5, 74543, 'Title5', 14, 3600, 5, '2021/02/20');
-- Thêm dữ liệu vào bảng Exam Question
INSERT INTO ExamQuestion(ExamID, QuestionID)
VALUES
(01, 1),
(02, 2),
(03, 3),
(04, 4),
(05, 5);




