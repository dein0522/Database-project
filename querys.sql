-- Akash Patel 01235057 
-- Ting-Li Shen 01741134

-- Query 1
select name
from student
where ID = '113';

-- Query 2
select distinct title
from course
where title like 'G%';

-- Query 3
select ID
from instructor
minus 
(select ID
from instructor natural join teaches
where semester = 'Fall' and year = '2016');

-- Query 4
select dept_name, count(name) as numStudents
from student
group by dept_name
order by dept_name;

-- Query 5
select name
from instructor, teaches, takes
where instructor.ID = teaches.ID and
	teaches.course_id = takes.course_id and
	teaches.sec_id = takes.sec_id and
	teaches.semester = takes.semester and
	teaches.year = takes.year
group by name
having count(takes.ID) >= all(select count(takes.ID)
						from instructor, teaches, takes
						where instructor.ID = teaches.ID and
						teaches.course_id = takes.course_id and
						teaches.sec_id = takes.sec_id and
						teaches.semester = takes.semester and
						teaches.year = takes.year
						group by name);

-- Query 6
select I.name
from instructor I
where not exists((select distinct year
				from instructor natural join teaches
				where name = 'McKinnon')
				minus
				(select distinct year
				from teaches T
				where T.ID = I.ID and
				I.name <> 'McKinnon'));

-- Query 7
select name, salary
from instructor
where dept_name = (select dept_name
				from instructor
				group by dept_name
				having avg(salary) >= all(select avg(salary)
									from instructor
									group by dept_name))
		and salary >= all(select max(salary)
						from instructor
						where dept_name = (select dept_name
										from instructor
										group by dept_name
										having avg(salary) >= all(select avg(salary)
																from instructor
																group by dept_name)))
		and rownum <= 2;


-- Query 8
select name, title, year, semester, credits, grade
from course, takes, student
where name in (select name from student where dept_name = 'Comp. Sci.') and
course.course_id = takes.course_id and
student.ID = takes.ID and
rownum <= 5
group by name, title, year, semester, credits, grade
order by name, year, semester desc;


-- Query 9
update instructor
set salary = salary + 10000
where salary <= 50000;

-- Query 10
delete from takes 
where ID in (select ID 
		  from student
		  where name = 'Tomason');