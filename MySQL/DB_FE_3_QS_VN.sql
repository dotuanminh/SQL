drop database if exists `test_exam_3`;
create database `test_exam_3`;
use `test_exam_3` ; 

drop table if exists Country;
create table Country(
	country_id int unsigned primary key auto_increment ,
    country_name varchar(50)
);


drop table if exists Location ; 
create table Location(
	location_id int unsigned primary key auto_increment , 
    street_address varchar(100), 
    postal_code varchar(10), 
	country_id int unsigned 
);


drop table if exists Employee ; 
create table Employee(
	employee_id int unsigned primary key auto_increment , 
    full_name varchar(50),
    email varchar(50),
    location_id int unsigned 
);

-- insert data for country 
INSERT INTO `test_exam_3`.`country` (`country_id`, `country_name`) VALUES ('1', 'Việt Nam');
INSERT INTO `test_exam_3`.`country` (`country_id`, `country_name`) VALUES ('2', 'Thái Lan');
INSERT INTO `test_exam_3`.`country` (`country_id`, `country_name`) VALUES ('3', 'Campuchia');
-- insert data for Location 
INSERT INTO `test_exam_3`.`location` (`location_id`, `street_address`, `postal_code`, `country_id`) VALUES ('1', '12/23 Nguyễn Đức Cảnh', '12', '1');
INSERT INTO `test_exam_3`.`location` (`location_id`, `street_address`, `postal_code`, `country_id`) VALUES ('2', '27 Nguyễn Huệ ', '13', '1');
INSERT INTO `test_exam_3`.`location` (`location_id`, `street_address`, `postal_code`, `country_id`) VALUES ('3', '64 Cam', '200', '2');
-- insert data from employee 
INSERT INTO `test_exam_3`.`employee` (`employee_id`, `full_name`, `email`, `location_id`) VALUES ('1', 'Đỗ Tuấn Minh', 'minhdo@gmail.com', '1');
INSERT INTO `test_exam_3`.`employee` (`employee_id`, `full_name`, `email`, `location_id`) VALUES ('2', 'Phạm Diệu Lnh', 'pdl@gmail.com', '3');
INSERT INTO `test_exam_3`.`employee` (`employee_id`, `full_name`, `email`, `location_id`) VALUES ('3', 'Nguyễn Đức Cường', 'ndc@gmail.com', '2');
INSERT INTO `test_exam_3`.`employee` (`employee_id`, `full_name`, `email`, `location_id`) VALUES ('4', 'Nguyễn', 'nn03@gmail.com', '1');

-- 2, 
-- a, 
select * from employee where location_id  IN
(select location_id from location where country_id = (select country_id from country where country_name like 'Việt Nam')) ; 
-- b, 
select c.country_name 
from country c
join location l on l.country_id = c.country_id 
where location_id in (select location_id from employee where email like 'nn03@gmail.com') ;
-- c, 
select c.* , l.location_id , count(employee_id) as'So Luong' 
from location  l 
join country c on c.country_id = l.country_id 
join employee e on e.location_id = l.location_id 
group by location_id;

-- 3, 
drop trigger if exists max_10_insert_employee ;

delimiter $$
create trigger max_10_insert_employee  
before insert on `employee`
for each row
begin 
	declare bien int ;
	select count(employee_id) into bien
    from location l
    join employee e on l.location_id = e.location_id
    join country c on c.country_id= l.country_id
	where c.country_id =(select country_id from location where location_id = new.location_id)
	group by country_name ;
   
    if (bien >= 3) then 
		signal sqlstate '12345' 
		set message_text = 'cannot insert';
	end if; 
end $$ 
delimiter ; 

-- 4, 
drop trigger if exists null_employee 
delimiter $$
	create trigger null_employee 
    after delete on `location`
    for each row 
    begin 
		update employee set location_id = NULL where location_id = old.location_id ;
    end $$
delimiter ;

delete from location where location_id = 3 ; 
select * from employee ;

