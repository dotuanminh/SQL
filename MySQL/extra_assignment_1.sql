drop database if exists `Practice_Exercise`;
create database `Practice_Exercise`;
use `Practice_Exercise`;

drop table if exists `Trainee`;
create table `Trainee` (
	TraineeID int unsigned primary key auto_increment ,
	Full_Name varchar(50) ,
	Birth_Date date ,
	Gender enum('male', 'female','unknown'), 
	ET_IQ int check(ET_IQ > 0 and ET_IQ <20 ), 
 	ET_Gmath int check(ET_Gmath > 0 and ET_Gmath <20 )  , 
	ET_English int,
	Training_Class varchar(50) ,
	Evaluation_Notes text
);

alter table `Trainee` add column `VTI_Account` int not null unique ;

