
-- Drop database if exists
DROP DATABASE IF EXISTS nhanvien;
CREATE DATABASE IF NOT EXISTS nhanvien;
USE nhanvien;

-- Question 1: Create table with constraint and datatype 
DROP TABLE IF EXISTS Department;
CREATE TABLE 		Department 
(
		Department_Number  		TINYINT AUTO_INCREMENT PRIMARY KEY ,
		Department_Name			NVARCHAR(30) NOT NULL 
);

DROP TABLE IF EXISTS Employee_Table;
CREATE TABLE  Employee_Table
(
		Employee_Number			SMALLINT AUTO_INCREMENT PRIMARY KEY ,
        Employee_Name 			NVARCHAR(30) NOT NULL,
        Department_Number		TINYINT NOT NULL,
        FOREIGN KEY (Department_Number) REFERENCES Department(Department_Number)
);
	
DROP TABLE IF EXISTS Employee_Skill_Table;
CREATE TABLE   Employee_Skill_Table 
(
		Employee_Number		SMALLINT AUTO_INCREMENT PRIMARY KEY, 
		Skill_Code			CHAR(10) NOT NULL, 
		Date_Registered		DATE NOT NULL
); 
    

-- Question 2: Insert at least 10 record to table 
INSERT INTO		Department (Department_Name)
VALUES 	
								('GH1'),
								('GH2'),
								('GH3'),
								('GH4'),
								('GH5'),
								('GH6'),
								('GH7'),
								('GH8'),
								('GH9'),
								('GH10');
			
INSERT INTO		Employee_Table(Employee_Name,	Department_Number)
VALUES 	
							('nguyễn văn abc',			1		),
							('vũ văn bắc', 				2		),
							('vũ văn hung', 			1		),
							('vũ thị linh', 			4		),
							('trần thi trang', 			1		),
							('vũ thi duyên', 			1		),
							('nguyễn văn nam', 			4		),
							('vũ thi phương2', 			10		),
							('vũ thi phương4', 			10		),
							('vũ thi phương5', 			10		);
            
INSERT INTO		Employee_Skill_Table(Skill_Code, 		Date_Registered)
VALUES 	
									('JAVA',			'1996-01-04'),
									('AHK',				'1998-09-09'),
									('JAVA',			'2000-01-05'),
									('ABC',				'1999-05-08'),
									('DHC',				'1999-02-06'),
									('JAVA',			'1999-04-02'),
									('ABC',				'1999-03-03'),
									('DHC',				'1999-05-06'),
									('ABC',				'1999-06-03'),
									('DHC',				'1999-03-05');
		
