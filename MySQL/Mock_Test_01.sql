-- create db
drop database if exists `Mock_exam_1`  ;
create database `Mock_exam_1` ;
-- use db 
use `Mock_exam_1` ;

-- create table customer
drop table if exists CUSTOMER ; 
create table CUSTOMER (
	CustomerID int unsigned primary key auto_increment  , 
	`Name` varchar(50) not null ,
	Phone char(13) not null, 
	Email varchar(50) not null,
	Address varchar(100) not null ,
    Note varchar(500) not null 
);

-- create table car
drop table if exists CAR ;
create table CAR (
	CarID int unsigned primary key auto_increment ,
    Maker enum ('HONDA', 'TOYOTA','NISSAN') not null,
    Model char(13) not null ,
    `Year` smallint not null, 
    Color varchar(50) not null,
    Note varchar(500) not null 
);

-- create table car_order	
drop table if exists CAR_ORDER;
create table CAR_ORDER(
	OrderID int unsigned primary key auto_increment,
    CustomerID int unsigned not null,
    CarID int unsigned not null,
    Amount smallint default 1 not null ,
    SalePrice int unsigned not null,
    OrderDate date not null, 
    DeliveryDate date not null, 
    DeliveryAddress varchar(200) not null ,
    `Status` tinyint(2) default 0 not null,
    Note varchar(500) not null,
    constraint fk_carorder1 foreign key (customerid) references customer(customerid) on delete cascade , 
    constraint fk_carorder2 foreign key (carid) references car(carid) on delete cascade
);

-- insert 

INSERT INTO Customer	(`Name`					, Phone				,Email					,Address		,Note				)
VALUES 					('Hoang Trong Hieu'		,'0936538794'       ,'hoanghieu@gmail.com'	,'Thai Binh'	,'Khach hang tiem nang'),
						('Nguyen Cam Nhung'		,'0966538944'		,'camnhung1@gmail.com'	,'Nam Dinh'		,'Da tu van 1 lan'),
                        ('Hoang Thu Thao'		,'0363578444'		,'hoangthao@yahoo.com'	,'Ha Noi'		,'Giam doc cong ty VTI'),
                        ('Le Manh Hung'         ,'0996176855'       ,'Hung87@gmail.com'     ,'Ha Noi'       ,'Chu doanh nghiep Bat dong san'),
                        ('Tran Binh Minh'		,'0969735123'		,'KHONG CO MAIL'		,'Hung Yen'		,'Da dat coc');			
                                                                    
--  Add data Car
INSERT INTO Car	(CarID		, Maker		,Model			,`Year`			,Color			,Note				)
VALUES 			(012		,'HONDA'    ,'KIA Morning'	,'1996'			,'Blue'			,'Chuan hang nhap khau'),
				(034		,'TOYOTA'	,'Matda 2'		,'2005'			,'Blank'		,'New 99%'),
                (205        ,'HONDA'	,'KIA 3'		,'2010'			,'Blue'			,'Da co khach dat'),
                (222        ,'NISSAN'	,'Vession2'		,'2010'			,'RED'			,'Hang moi ve'),
                (201        ,'TOYOTA'	,'TOYOTA 2'		,'2012'			,'Blank'		,'Con thoi gian bao hanh');
                
--  Add data Car_Order
INSERT INTO Car_Order	(CustomerID	, CarID		,Amount			,SalePrice	 ,OrderDate		,DeliveryDate	, DeliveryAddress	,`Status` , Note	)
VALUES 					(1			,034    	,2				,'1200'		 ,'2019-10-09'  ,'2020-01-10'	,'Thai Binh'		,'1'	  ,'Xe chay tot'),
                        (2          ,201        ,2              ,'1500'      ,'2020-02-03'  ,'2020-02-15'   ,'Ha Noi'           ,'1'      ,'Moi qua bao hanh'),
                        (4          ,222        ,1              ,'2300'      ,'2020-07-13'  ,'2020-09-10'   ,'Ha Noi'           ,'0'      ,'da thanh toan 75%'),
                        (1          ,222        ,1              ,'2300'      ,'2020-06-15'  ,'2020-08-05'   ,'Thai Binh'        ,'0'      ,'thanh toan tra gop BIDV'),
                        (5          ,205        ,1              ,'3000'      ,'2018-10-15'  ,'2017-12-05'   		,'Ha Noi'           ,'2'      ,'xe van chay tot');

-- b, Viết lệnh lấy ra thông tin của khách hàng: tên, số lượng oto khách hàng đã mua và sắp sếp tăng dần theo số lượng oto đã mua.
select c.customerid,c.`name` , sum(amount) as 'so luong'
from customer c
right join car_order co on co.customerid =c.customerid
group by co.customerid 
order by sum(amount) ;

-- c,Viết hàm (không có parameter) trả về tên hãng sản xuất đã bán được nhiều oto nhất trong năm nay.
SET GLOBAL log_bin_trust_function_creators = 1;
drop function if exists highest_sale_brand ;
delimiter $$
	create function highest_sale_brand() returns varchar(50) 
	begin
		declare result varchar(50) ;
        select c.maker into result from car c join car_order co on co.carid= c.carid group by c.maker order by sum(amount) desc limit 1;
        return result;
    end $$
delimiter ; 

select highest_sale_brand() ;

-- d,Viết 1 thủ tục (không có parameter) để xóa các đơn hàng đã bị hủy của những năm trước. In ra số lượng bản ghi đã bị xóa.
drop procedure delete_cancel_order;

delimiter $$ 
	create procedure delete_cancel_order() 
	begin
		if exists (select * from car_order where `status` = 2 and year(orderdate) = (year(now()) -1))
        then
        select * from car_order where `status` = 2 and year(orderdate) = (year(now()) -1);
		delete from car_order where `status` = 2 and year(orderdate) = (year(now()) -1) ;
		end if ;
    end $$ 
delimiter 

call delete_cancel_order() ; 


