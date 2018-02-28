-- Akash Patel 01235057 
-- Ting-Li Shen 01741134 
-- Create Table Statements

create table course (course_id char(2), 
	title char(21), 
	dept_name char(10), 
	credits int,
	primary key (course_id));

create table instructor (ID char(2), 
	name char(14), 
	dept_name char(10), 
	salary float(2),
	primary key (ID));

create table teaches (ID char(2), 
	course_id char(2), 
	sec_id char(1),
	semester char(6),
	year int, 
	primary key (ID, course_id, sec_id, semester, year),
	foreign key (ID) references instructor);

create table student (ID char(3), 
	name char(12), 
	dept_name char(10), 
	tot_cred int,
	primary key (ID));

create table takes (ID char(3), 
	course_id char(2), 
	sec_id char(1), 
	semester char(6),
	year int,
	grade char(2),
	primary key (ID, course_id, sec_id, semester, year),
	foreign key (ID) references student);