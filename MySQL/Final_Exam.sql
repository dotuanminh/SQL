-- create db 
drop database if exists `Final_Exam`;
create database `Final_Exam` ; 
use `Final_Exam`  ;

-- cau 1: Tạo table với các ràng buộc và kiểu dữ liệu
 -- creat table Student 
 
 drop table if exists `Student`;
 create table `Student`(
	ID int unsigned primary key auto_increment  ,
	`Name` varchar(50) not null , 
    Age int unsigned not null,
    Gender bit
 );
 
 drop table if exists `Subject` ; 
 create table `Subject`(
	ID int unsigned primary key auto_increment, 
    `Name` varchar(50) not null
 );
 
drop table if exists `StudentSubject` ; 
 create table `StudentSubject` (
	StudentID int unsigned auto_increment , 
    SubjectID int unsigned ,
    Mark double unsigned not null, 
    `Date` date not null,
     constraint pk_studentptoject primary key(`StudentID`,`SubjectID`)
);

-- insert data 
-- insert data to Student
INSERT INTO `final_exam`.`student` (`ID`, `Name`, `Age`, `Gender`) VALUES ('1', 'Đỗ Tuấn Minh', '18', b'1');
INSERT INTO `final_exam`.`student` (`ID`, `Name`, `Age`, `Gender`) VALUES ('2', 'Phạm Diệu Linh', '19', b'0');
INSERT INTO `final_exam`.`student` (`ID`, `Name`, `Age`) VALUES ('3', 'Nuyễn Quốc Tuấn', '17');
INSERT INTO `final_exam`.`student` (`ID`, `Name`, `Age`) VALUES ('4', 'Phạm Tiến Đạt', '20');
INSERT INTO `final_exam`.`student` (`ID`, `Name`, `Age`, `Gender`) VALUES ('5','Nguyễn Công Trứ', '29', b'1');
INSERT INTO `final_exam`.`student` (`ID`, `Name`, `Age`, `Gender`) VALUES ('6', 'Lê Chân', '13', b'0');
INSERT INTO `final_exam`.`student` (`ID`, `Name`, `Age`, `Gender`) VALUES ('7', 'Bùi Công', '19', b'1');

-- insert data to Subject 
INSERT INTO `final_exam`.`subject` (`ID`, `Name`) VALUES ('1', 'Biology');
INSERT INTO `final_exam`.`subject` (`ID`, `Name`) VALUES ('2', 'Math');
INSERT INTO `final_exam`.`subject` (`Name`) VALUES ('Literature');
INSERT INTO `final_exam`.`subject` (`Name`) VALUES ('English');
INSERT INTO `final_exam`.`subject` (`Name`) VALUES ('Physics');
INSERT INTO `final_exam`.`subject` (`Name`) VALUES ('Chemistry ');
INSERT INTO `final_exam`.`subject` (`Name`) VALUES ('Japanese');

-- insert data to StudentSubject 
INSERT INTO `final_exam`.`studentsubject` (`StudentID`, `SubjectID`, `Mark`, `Date`) VALUES ('1', '1', '10', '2020/07/12');
INSERT INTO `final_exam`.`studentsubject` (`StudentID`, `SubjectID`, `Mark`, `Date`) VALUES ('2', '2', '9.5', '2021/06/05');
INSERT INTO `final_exam`.`studentsubject` (`StudentID`, `SubjectID`, `Mark`, `Date`) VALUES ('3', '3', '4', '2019/07/12');
INSERT INTO `final_exam`.`studentsubject` (`StudentID`, `SubjectID`, `Mark`, `Date`) VALUES ('4', '3', '6', '2020/06/23');
INSERT INTO `final_exam`.`studentsubject` (`StudentID`, `SubjectID`, `Mark`, `Date`) VALUES ('6', '5', '3', '2019/04/12');
INSERT INTO `final_exam`.`studentsubject` (`StudentID`, `SubjectID`, `Mark`, `Date`) VALUES ('7', '1', '7', '2020/03/21');
INSERT INTO `final_exam`.`studentsubject` (`StudentID`, `SubjectID`, `Mark`, `Date`) VALUES ('8', '6', '2', '2020/05/12');
INSERT INTO `final_exam`.`studentsubject` (`StudentID`, `SubjectID`, `Mark`, `Date`) VALUES ('1', '3', '5', '2021/07/22');
INSERT INTO `final_exam`.`studentsubject` (`StudentID`, `SubjectID`, `Mark`, `Date`) VALUES ('2', '5', '2', '2010/10/12');
INSERT INTO `final_exam`.`studentsubject` (`StudentID`, `SubjectID`, `Mark`, `Date`) VALUES ('5', '4', '5', '2020/03/02');

-- 2, Viết lệnh để
-- a, Lấy tất cả các môn học không có bất kì điểm nào 
select s.* 
from `subject` s
where id not in(select subjectid from studentsubject) ; 

-- b, Lấy danh sách các môn học có ít nhất 2 điểm
select s.* 
from `subject` s 
join `studentsubject` ss on ss.subjectid = s.id 
group by ss.subjectid
having count(*) >=2 ; 

-- 3,Tạo view có tên là "StudentInfo" lấy các thông tin về học sinh bao gồm:
-- Student ID,Subject ID, Student Name, Student Age, Student Gender, Subject Name, Mark, Date
-- (Với cột Gender show 'Male' để thay thế cho 0, 'Female' thay thế cho 1 và 'Unknow' thay thế cho null)

drop view if exists student_info; 
create view student_info as
select ss.studentid as 'Student ID', ss.subjectid as `Subject ID`, st.`name` as `Student Name`, st.Age, 
Case st.Gender when 1 then 'Female' when 0 then 'Male' else 'Unknown' end as 'Gender'  , 
sj.`name` as 'Subject Name' ,ss.Mark, ss.`Date`
from `studentsubject` ss 
join `student` st on st.id= ss.studentid 
join `subject` sj on sj.id= ss.subjectid ;

select * from student_info ; 

-- 4, Không sử dụng On Update Cascade & On Delete Cascade
-- a, 
drop trigger if exists SubjectUpdateID ; 
delimiter $$
create trigger SubjectUpdateID 
before update on `Subject`
for each row 
begin 
	update `StudentSubject`
    set subjectid = new.id 
    where subjectid = old.id ;
end $$
delimiter ;

-- Test thử câu lệnh SubjectUpdateID
begin work ; 
update `subject`set ID = 8 where ID = 1 ; 
select * from `subject`;
select * from `studentsubject`; 
rollback; 



-- b, 

drop trigger if exists StudentDeleteID; 
delimiter $$
create trigger StudentDeleteID
after delete on `Student`
for each row 
begin 
	delete 
    from `studentsubject`
    where studentid = old.id;
end $$
delimiter ;

-- test thử câu lệnh StudentDeleteID
begin work ; 
delete from `student` where id = 3 ; 
select * from student; 
select * from studentsubject ;
rollback ;

-- 5, 
drop procedure if exists student_delete ; 
delimiter $$
create procedure  student_delete (in student_name varchar(50)) 
begin 
	if (student_name like '*')
    then delete from `student` ;
    else delete from `student` where `name` like student_name ;
    end if;
    if (student_name like '*')
    then delete from `studentsubject` ;
    else delete from `studentsubject` where studentID in (select id from `student` where name like student_name);
    end if;
end $$
delimiter ;

-- test
begin work ; 
call student_delete('Đỗ Tuấn Minh');
call student_delete('*') ; 
select * from `student`;
select * from `studentsubject`;
rollback ; 

