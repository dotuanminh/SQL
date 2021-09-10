drop database if exists `test_exam_2` ; 
create database `test_exam_2` ; 
use `test_exam_2`   ; 

drop table if exists GiangVien ; 
create table GiangVien (
	magv int unsigned primary key auto_increment , 
    hoten varchar(50) , 
    luong double
);

drop table if exists SinhVien ; 
create table SinhVien(
	masv int unsigned primary key auto_increment,
    hoten varchar(50),
	namsinh int unsigned , 
    quequan varchar(50)
); 

drop table if exists DeTai ; 
create table DeTai(
	madt int unsigned primary key auto_increment,
    tendt varchar(100),
    kinhphi double , 
    NoiThucTap varchar(50)
);


drop table if exists HuongDan ;
create table HuongDan(
	id int unsigned primary key auto_increment ,
    masv int unsigned,
    madt int unsigned,
    magv int unsigned,
    ketqua varchar(50)
);

-- insert data to giangvien
INSERT INTO `test_exam_2`.`giangvien` (`magv`, `hoten`, `luong`) VALUES ('1', 'Phạm Thu Hà ', '1000');
INSERT INTO `test_exam_2`.`giangvien` (`magv`, `hoten`, `luong`) VALUES ('2', 'Phạm Thịu Liễu ', '2300');
INSERT INTO `test_exam_2`.`giangvien` (`magv`, `hoten`, `luong`) VALUES ('3', 'Đỗ Văn Thuận ', '3400');

-- insert data to sinhvien
INSERT INTO `test_exam_2`.`sinhvien` (`masv`, `hoten`, `namsinh`, `quequan`) VALUES ('1', 'Đỗ Tuấn Minh', '2002', 'Hải Phòng');
INSERT INTO `test_exam_2`.`sinhvien` (`masv`, `hoten`, `namsinh`, `quequan`) VALUES ('2', 'Phạm Diệu Linh', '2001', 'Bắc Giang ');
INSERT INTO `test_exam_2`.`sinhvien` (`masv`, `hoten`, `namsinh`, `quequan`) VALUES ('3', 'Đỗ Tuấn Anh', '1998', 'Hà Nội');
INSERT INTO `test_exam_2`.`sinhvien` (`masv`, `hoten`, `namsinh`, `quequan`) VALUES ('4', 'Đỗ Tuấn Luong', '1899', 'Hà Nội');

-- insert data to huong dan 
INSERT INTO `test_exam_2`.`huongdan` (`id`, `masv`, `madt`, `magv`, `ketqua`) VALUES ('1', '1', '1', '2', 'Quá thiếu dữ liệu');
INSERT INTO `test_exam_2`.`huongdan` (`id`, `masv`, `madt`, `magv`, `ketqua`) VALUES ('2', '1', '3', '1', 'Không thực tế');
INSERT INTO `test_exam_2`.`huongdan` (`id`, `masv`, `madt`, `magv`, `ketqua`) VALUES ('3', '2', '2', '3', 'Hơi lan man');
INSERT INTO `test_exam_2`.`huongdan` (`id`, `masv`, `madt`, `magv`, `ketqua`) VALUES ('4', '3', '1', '2', 'Gian Lận');
INSERT INTO `test_exam_2`.`huongdan` (`id`, `masv`, `madt`, `magv`, `ketqua`) VALUES ('5', '3', '4', '1', 'Không hiểu');

-- insert data to de tai 
INSERT INTO `test_exam_2`.`detai` (`madt`, `tendt`, `kinhphi`, `NoiThucTap`) VALUES ('1', 'bảo vệ môi trường', '1200', 'Hải Phòng');
INSERT INTO `test_exam_2`.`detai` (`madt`, `tendt`, `kinhphi`, `NoiThucTap`) VALUES ('2', 'Tiết kiệm điện', '2300', 'Hà Nội');
INSERT INTO `test_exam_2`.`detai` (`madt`, `tendt`, `kinhphi`, `NoiThucTap`) VALUES ('3', 'Sử dụng túi nilon', '1000', 'Bắc Giang');
INSERT INTO `test_exam_2`.`detai` (`madt`, `tendt`, `kinhphi`, `NoiThucTap`) VALUES ('4', 'CONG NGHE SINH HOC', '1200', 'Hà Nội');


-- 2, 
-- a,
select * 
from sinhvien 
where masv not in(select masv from huongdan) ;

-- b, 
select count(*) as 'So luong'
from sinhvien s 
join huongdan hd on hd.masv= s.masv
join detai d on d.madt = hd.madt 
where d.tendt= 'CONG NGHE SINH HOC' ;

-- 3, 
drop view if exists thong_tin_sv;
 
create view thong_tin_sv as
select s.masv,s.hoten, COALESCE (d.tendt, 'Chua co') as 'Ten De Tai'
from sinhvien s
left join huongdan hd on hd.masv= s.masv 
left join detai d on d.madt = hd.madt  ;

select * from thong_tin_sv ;

-- 4, 
drop trigger if exists nam_sinh ; 
delimiter $$
create trigger nam_sinh 
before insert on sinhvien 
for each row
begin
	if(new.namsinh <=1900) then 
		signal sqlstate '12345' 
		set message_text = 'năm sinh phải > 1900';
	end if ; 
end $$
delimiter ;

INSERT INTO `test_exam_2`.`sinhvien` (`masv`, `hoten`, `namsinh`, `quequan`) VALUES ('5', 'Đỗ Tuấn ', '1899', 'Hà Nội');
 
 -- 5, 
 drop trigger if exists xoa_thong_tin_sv;

delimiter $$
create trigger xoa_thong_tin_sv 
after delete on sinhvien 
for each row 
begin 
	delete 
    from huongdan
    where masv= old.masv ; 
end $$
delimiter ;

begin work; 
INSERT INTO `test_exam_2`.`sinhvien` (`masv`, `hoten`, `namsinh`, `quequan`) VALUES ('5', 'Đỗ Tuấn ', '1899', 'Hà Nội');
INSERT INTO `test_exam_2`.`huongdan` (`id`, `masv`, `madt`, `magv`, `ketqua`) VALUES ('6', '5', '4', '1', 'Không');
delete from sinhvien where masv = 5;
select * from sinhvien ;
select * from huongdan ; 
rollback ;



