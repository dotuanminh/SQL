use `Practice_Exercise`;

-- Question 1: Thêm ít nhất 10 bản ghi vào table
-- Question 2: Viết lệnh để lấy ra tất cả các thực tập sinh đã vượt qua bài test đầu vào, nhóm chúng thành các tháng sinh khác nhau
select * from trainee where (ET_IQ + ET_Gmath>=20) and (ET_IQ>=8) and (ET_Gmath>=8) and (ET_English>=18)  order by month(birth_date) ;
-- Question 3: Viết lệnh để lấy ra thực tập sinh có tên dài nhất, lấy ra các thông tin sau: tên, tuổi, các thông tin cơ bản (như đã được định nghĩa trong table)
select * from trainee where character_length(full_name) = (select character_length(full_name) from trainee order by character_length(full_name) desc limit 1) ;
-- Question 4: Viết lệnh để lấy ra tất cả các thực tập sinh là ET, 1 ET thực tập sinh là những người đã vượt qua bài test đầu vào và thỏa mãn số điểm như sau:
-- ET_IQ + ET_Gmath>=20
-- ET_IQ>=8
-- ET_Gmath>=8
-- ET_English>=18
select * from trainee where (ET_IQ + ET_Gmath>=20) and (ET_IQ>=8) and (ET_Gmath>=8) and (ET_English>=18) ;
-- Question 5: xóa thực tập sinh có TraineeID = 3
delete from trainee where traineeid =3 ; 
-- Question 6: Thực tập sinh có TraineeID = 5 được chuyển sang lớp "2". Hãy cập nhật thông tin vào database
update trainee set Training_Class = 'Fresher- 2' where traineeid =5; 
