USE `Testing_System` ; 

-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
drop view if exists Sale_department ;

create view Sale_department as 
select *
from `account`
where departmentid =(select departmentid  from department where departmentname in('Phòng Sale'));

select *
from Sale_department ; 



-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
drop view if exists most_join_person ; 

create view most_join_person as 
select *
from `account`
where accountid = any
(select accountid
from groupaccount
group by accountid
having count(groupid) =(select count(groupid) from groupaccount group by accountid order by count(groupid) desc limit 1 ));

select *
from most_join_person  ; 

-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi
drop view if exists long_content ;

create view long_content as
select content
from question 
where character_length(content) > 10 ; 

select *
from long_content ; 


-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
drop view if exists most_people_department ;

create view most_people_department as
select d.DepartmentName
from department d
right join `account` a on a.departmentid = d.departmentid
group by a.departmentid 
having count(accountid) = (select count(accountid) from `account` a1 group by departmentid order by count(accountid) desc limit 1);

select *
from most_people_department ; 
 
-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
drop view if exists nguyen_creator ;

create view nguyen_creator as 
select content
from question 
where creatorid = ANY (select accountid from `account` where fullname LIKE 'Nguyễn%') ;

select *
from nguyen_creator ; 


-- begin work 
-- roll back