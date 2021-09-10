USE `Testing_System`; 

-- Question 1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo trước 1 năm trước

drop trigger if exists one_year_cannot_insert ; 
delimiter $$
	create trigger one_year_cannot_insert 
    before insert on `group` 
    for each row 
    begin
    if (year(new.createdate) < (year(now())-1)) then
		signal sqlstate '12345'
        set message_text = ' ';
	end if ; 
    end $$
delimiter ;

-- Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào department "Sale" nữa, khi thêm thì hiện ra thông báo "Department
-- "Sale" cannot add more user"
drop trigger if exists cannot_insert_sale ; 
delimiter $$ 
	create trigger cannot_insert_sale 
    before insert on `account`
    for each row
    begin 
		if (new.departmentid = (select * from department where departmentname like 'Phòng Sale')) then 
			signal sqlstate '12345'
			set message_text = 'Department "Sale" cannot add more user';
        end if;
    end $$
    
delimiter ;


-- Question 3: Cấu hình 1 group có nhiều nhất là 5 user
drop trigger if exists 5_user_per_group  ;
delimiter $$
	create trigger 5_user_per_group  
    before insert on `groupaccount`
    for each row
    begin 
		if ((select count(accountid) from groupaccount group by groupid) >=5) then 
			signal sqlstate '12345'
			set message_text = ' ';
		end if; 
    end $$
delimiter  ;
-- Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question
drop trigger if exists 10_question_per_exam ; 

delimiter $$
	create trigger 10_question_per_exam  
    before insert on examquestion
    for each row 
    begin 
		if ((select count(questionid) from examquestion group by examid) >=10) then 
			signal sqlstate '12345'
			set message_text = ' ';
		end if ; 
    end $$
delimiter ;

-- Question 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là admin@gmail.com (đây là tài khoản admin, không cho phép user xóa),
-- còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông tin liên quan tới user đó
 delete from `account` ; 
 drop trigger if exists delete_account;
 delimiter $$
	create trigger delete_account 
    before delete on `account`
    for each row 
    begin 
		if(old.email = 'admin@gmail.com') then 
			signal sqlstate '12345'
			set message_text = ' ';
		else 
			delete from groupaccount where accountid= old.accountid; 
            delete from `group` where creatorid = old.accountid;
            delete from `question` where creatorid = old.accountid;
        end if;
    end $$
    
 delimiter ;
 
-- Question 6: Không sử dụng cấu hình default cho field DepartmentID của table
-- Account, hãy tạo trigger cho phép người dùng khi tạo account không điền
-- vào departmentID thì sẽ được phân vào phòng ban "waiting Department"
drop trigger if exists changing_department ; 
delimiter $$
	create trigger changing_department  
    before insert on department 
    for each row 
    begin 
		if(new.departmentid is null) then
        set new.departmentid = (select departmentid from department where departmentname = 'waiting Department');
        end if ; 
    end $$
delimiter ;
-- Question 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi
-- question, trong đó có tối đa 2 đáp án đúng.
drop trigger if exists exam_restriction ; 
delimiter $$
	create trigger exam_restriction 
    before insert on answer
	for each row 
    begin 
		declare number_answer tinyint ;
        declare number_correct_answer tinyint ;
        select count(answerid) into number_answer from answer group by questionid ; 
        select sum(iscorrect) into number_correct_answer from answer group by questionid ;
        if(number_answer>=4 or number_correct_answer >=2 ) then 
			signal sqlstate '12345'
			set message_text = ' ';
		end if; 
        
    end $$
delimiter ;


-- Question 8: Viết trigger sửa lại dữ liệu cho đúng:
-- Nếu người dùng nhập vào gender của account là nam, nữ, chưa xác định
-- Thì sẽ đổi lại thành M, F, U cho giống với cấu hình ở database
drop trigger if exists change_profile_gender ; 

delimiter $$
create trigger change_profile_gender 
after insert on `account`
for eachrow 
if(new.gender = 'nam') then 
	set new.gender = 'M'
else if (new.gender = 'nu') then 
	set new.gender ='F' 
else 
	set new.gender = 'U' ;
end if ; 
delimiter ;

-- Question 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày\
drop trigger if exists cancel_delelete_from_2_days ;
delimiter $$
	create trigger cancel_delelete_from_2_days 
    before delete on exam 
    for each row
    begin 
		if(day(old.createdate) > (day(now())-2)) then 
			signal sqlstate '12345'
			set message_text = ' ';
		end if ; 
    end $$
delimiter ;
-- Question 10: Viết trigger chỉ cho phép người dùng chỉ được update, delete các
-- question khi question đó chưa nằm trong exam nào
drop trigger if exists only_del_up_non_exam_question;
delimiter $$
create trigger only_del_up_non_exam_question
    before delete
    on Question
    for each row
begin
    declare canEdit int default true;

    set canEdit = not exists(select *
                             from ExamQuestion
                             where QuestionID = OLD.QuestionID);

    if (not canEdit) then
        signal sqlstate '13458'
        set message_text = 'cannot edit';
    end if;

end;
-- Question 12: Lấy ra thông tin exam trong đó:
-- Duration <= 30 thì sẽ đổi thành giá trị "Short time"
-- 30 < Duration <= 60 thì sẽ đổi thành giá trị "Medium time"
-- Duration > 60 thì sẽ đổi thành giá trị "Long time"
select ExamID,
       Code,
       Title,
       Duration,
		Case 
        when Duration <=30 then 'Short Time'
        when duration>30 and duration <=60 then 'Medium time'
        else 'Long time'
        end as 'kind of exam'
from exam ;  
        
-- Question 13: Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên
-- là the_number_user_amount và mang giá trị được quy định như sau:


-- Nếu số lượng user trong group =< 5 thì sẽ có giá trị là few
-- Nếu số lượng user trong group <= 20 và > 5 thì sẽ có giá trị là normal
-- Nếu số lượng user trong group > 20 thì sẽ có giá trị là higher

select g.*, count(accountid) as 'So luong', if(count(accountid)<=5, 'few', if(count(accountid)<=20 and count(accountid)>5, 'normal', if(count(accountid)>20, 'higher',null))) as the_number_user_amount
from `group` g
left join groupaccount ga on ga.groupid= g.groupid 
group by groupid ;
-- Question 14: Thống kê số mỗi phòng ban có bao nhiêu user, nếu phòng ban nào
-- không có user thì sẽ thay đổi giá trị 0 thành "Không có User"
select d.*, case count(accountid) when 0 then 'không có user' else count(accountid) end as 'so luong'
from department d 
left join `account`a on a.departmentid= d.departmentid
group by departmentid ; 