drop database if exists `Testing_2`;
create database `Testing_2`;
use `Testing_2`;


-- Question 1: Tạo table với các ràng buộc và kiểu dữ liệu
drop table if exists Department ; 
create table Department(
	Department_Number int unsigned primary key auto_increment , 
    Department_Name varchar(50) 
);

drop table if exists Employee_Table ; 
create table Employee_Table (
	Employee_Number int unsigned primary key auto_increment , 
	Employee_Name varchar(50),
	Department_Number int unsigned 
	-- constraint fk_employee foreign key (Department_Name) references Department(Department_Name)
);

drop table if exists Employee_Skill_Table ; 
create table Employee_Skill_Table(
	Employee_Number int unsigned primary key auto_increment ,
    Skill_Code varchar(50) , 
    Date_Registered date 
);

-- Question 2: Thêm ít nhất 10 bản ghi vào table

INSERT INTO `testing_2`.`employee_table` (`Employee_Number`, `Employee_Name`, `Department_Number`) VALUES ('1', 'Đõ Tuấn Minh', '1');
INSERT INTO `testing_2`.`employee_table` (`Employee_Number`, `Employee_Name`, `Department_Number`) VALUES ('2', 'Phạm Diệu Linh', '3');
INSERT INTO `testing_2`.`employee_table` (`Employee_Number`, `Employee_Name`, `Department_Number`) VALUES ('3', 'Hoàng Quốc Cường', '2');
INSERT INTO `testing_2`.`employee_table` (`Employee_Number`, `Employee_Name`, `Department_Number`) VALUES ('4', 'Trần Đức Thịnh', '1');
INSERT INTO `testing_2`.`employee_table` (`Employee_Number`, `Employee_Name`, `Department_Number`) VALUES ('5', 'Đoàn Mạnh Cường', '4');
INSERT INTO `testing_2`.`employee_table` (`Employee_Number`, `Employee_Name`, `Department_Number`) VALUES ('6', 'Khuất Nguyên Cương', '5');
INSERT INTO `testing_2`.`employee_table` (`Employee_Number`, `Employee_Name`, `Department_Number`) VALUES ('7', 'Đỗ Dũng', '3');
INSERT INTO `testing_2`.`employee_table` (`Employee_Number`, `Employee_Name`, `Department_Number`) VALUES ('8', 'Ngô Văn Kha', '5');
INSERT INTO `testing_2`.`employee_table` (`Employee_Number`, `Employee_Name`, `Department_Number`) VALUES ('9', 'Lê Tuấn Linh', '9');
INSERT INTO `testing_2`.`employee_table` (`Employee_Number`, `Employee_Name`, `Department_Number`) VALUES ('10', 'Phan Việt Linh', '10');


-- Question 3: Viết lệnh để lấy ra danh sách nhân viên (name) có skill Java
-- Hướng dẫn: sử dụng UNION
select et.employee_name 
from employee_table et 
join employee_skill_table est on est.employee_number = et.employee_number 
where est.Skill_Code like 'Java' ;  

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
select d.* , count(Employee_Number) as 'so luong'
from department d
join employee_table et on et.department_number = d.Department_Number 
group by Department_Number
having count(Employee_Number) > 3; 
-- Question 5: Viết lệnh để lấy ra danh sách nhân viên của mỗi văn phòng ban.
-- Hướng dẫn: sử dụng GROUP BY
select et.employee_name , d.department_name 
from employee_table et 
join department d on d.department_number = et.department_number
order by d.department_number ;
-- Question 6: Viết lệnh để lấy ra danh sách nhân viên có > 1 skills.

-- Hướng dẫn: sử dụng DISTINCT
