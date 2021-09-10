USE `Testing_System` ;

-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT A.* , D.DepartmentName 
FROM `Account` A
JOIN  Department D
ON A.DepartmentID = D.DepartmentID; 
-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
SELECT *
FROM `Account` 
Where DATE(CreateDate) > '2010/12/20'; 
-- Question 3: Viết lệnh để lấy ra tất cả các developer
SELECT A.* 
FROM Account A
JOIN Position P ON A.PositionID =P.PositionID 
WHERE P.PositionName LIKE 'Developer';
-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT D.*,  COUNT(A.DepartmentID) as 'so nhan vien'
FROM Department D
JOIN `Account` A on A.DepartmentID = D.DepartmentID
GROUP BY A.DepartmentID 
HAVING `so nhan vien` >=3 ;

-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT *
FROM Question 
Where QuestionID = 
(SELECT QuestionID
FROM ExamQuestion 
GROUP BY QuestionID
HAVING Count(QuestionID) =(SELECT Count(QuestionID) FROM ExamQuestion GROUP BY QuestionID ORDER BY QuestionID DESC LIMIT 1 )); 
-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
SELECT C.*
FROM CategoryQuestion C 
RIGHT JOIN Question Q ON Q.CategoryID =C.CategoryID;
-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT Q.Content, Count(E.QuestionID) as 'soluong'
FROM Question Q 
RIGHT JOIN ExamQuestion E ON E.QuestionID =Q.QuestionID 
GROUP BY E.QuestionID;

-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
SELECT Q.*, COUNT(A.QuestionID) as 'so cau tra loi' 
FROM Question Q 
JOIN Answer A On A.questionID = Q.QuestionID 
GROUP BY A.QuestionID
ORDER BY COUNT(A.QuestionID) DESC LIMIT 1;  

-- Question 9: Thống kê số lượng account trong mỗi group
SELECT G.*, COUNT(AccountID) as 'so luong'
From `Group` G
Right join GroupAccount GA ON GA.GroupID = G.GroupID 
Group BY G.GroupID ;

-- Question 10: Tìm chức vụ có ít người nhất
SELECT P.*, COUNT(A.PositionID) as 'so luong'
FROM Position P 
RIGHT JOIN `Account` A ON A.PositionID = P.PositionID
GROUP BY P.PositionID  
ORDER BY COUNT(A.PositionID) ASC LIMIT 1 ; 
-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT D.DepartmentID , D.DepartmentName , P.PositionID, P.PositionName, COUNT(*) as 'so luong' 
FROM `Account` A
JOIN Department D ON D.DepartmentID = A.DepartmentID 
JOIN Position P ON P.PositionID = A.PositionID 
GROUP BY D.DepartmentID,P.PositionID;
-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...
SELECT Q.* , T.*, A.*
FROM Question Q 
JOIN TypeQuestion T ON Q.TypeID = T.TypeID 
JOIN Answer A on A.QuestionID = Q.QuestionID ;
-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT T.* , COUNT(Q.TypeID) as 'so luong' 
FROM TypeQuestion T 
RIGHT JOIN  Question Q ON Q.TypeID = T.TypeID 
GRoup by TypeID ;
-- Question 14:Lấy ra group không có account nào
select G.GroupID, GroupName
from `Group` G
         left join GroupAccount GA on G.GroupID = GA.GroupID
where G.GroupID not in (select G1.GroupID
                        from `Group` G1
                                 join GroupAccount A on G1.GroupID = A.GroupID)
group by G.GroupID;
-- Question 15: Lấy ra group không có account nào
-- Question 16: Lấy ra question không có answer nào
SELECT Q.*
From Question Q 
left join Answer A ON A.QuestionId= Q.QuestionID
WHERE Q.QuestionID nOT IN (select q1.questionid from question q1 join answer a on a.questionid= q.questionid);


-- Question 17:
-- a) Lấy các account thuộc nhóm thứ 1
SELECT 
    A.*
FROM
    `Account` A
        JOIN
    GroupAccount GA ON GA.accountid = a.accountid
WHERE
    ga.groupid = 1;
-- b) Lấy các account thuộc nhóm thứ 2
SELECT 
    A.*
FROM
    `Account` A
        JOIN
    GroupAccount GA ON GA.accountid = a.accountid
WHERE
    ga.groupid = 2;
-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT 
    A.*
FROM
    `Account` A
        JOIN
    GroupAccount GA ON GA.accountid = a.accountid
WHERE
    ga.groupid = 1;
UNION
SELECT 
    A.*
FROM
    `Account` A
        JOIN
    GroupAccount GA ON GA.accountid = a.accountid
WHERE
    ga.groupid = 2;
-- Question 18:
-- a) Lấy các group có lớn hơn 5 thành viên
select G.GroupID, GroupName, count(AccountID) as 'so luong'
from `Group` G
         join GroupAccount GA on G.GroupID = GA.GroupID
group by G.GroupID
having count(AccountID) > 5;
-- b) Lấy các group có nhỏ hơn 7 thành viên
select G.GroupID, GroupName, count(AccountID) as 'so luong'
from `Group` G
         join GroupAccount GA on G.GroupID = GA.GroupID
group by G.GroupID
having count(AccountID) <7;
-- c) Ghép 2 kết quả từ câu a) và câu b)
select G.GroupID, GroupName, count(AccountID) as 'so luong'
from `Group` G
         join GroupAccount GA on G.GroupID = GA.GroupID
group by G.GroupID
having count(AccountID) > 5;
union 
select G.GroupID, GroupName, count(AccountID) as 'so luong'
from `Group` G
         join GroupAccount GA on G.GroupID = GA.GroupID
group by G.GroupID
having count(AccountID) <7;