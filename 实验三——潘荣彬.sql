# 1.在studentsdb数据库中使用SELECT语句进行基本查询。
#（1）在student_info表中，查询每个学生的学号、姓名、出生日期信息。
SELECT `学号`,`姓名`,`出生日期`
FROM student_info;

#（2）查询student_info表学号为0002的学生的姓名和家庭住址。
SELECT `姓名`,`家庭住址`
FROM student_info
WHERE `学号` = 0002;

#（3）查询student_info表所有出生日期在95年以后的女同学的姓名和出生日期。
SELECT `姓名`,`出生日期`
FROM student_info 
WHERE `性别` = "女" AND `出生日期` >= 1995

#  2. 使用select语句进行条件查询。
#（1）在grade表中查询分数在70-80范围内的学生的学号、课程编号和成绩。
SELECT `学号`,`课程编号`,`分数`
FROM grade 
WHERE `分数` BETWEEN 70 AND 80

#（2）在grade表中查询课程编号为0002的学生的平均成绩。
SELECT ROUND(AVG(`分数`),1) AS 平均成绩 
from grade 
where `课程编号`= 0002;

#（3）在grade表中查询选修课程编号为0003的人数和该课程有成绩的人数。
SELECT `学号`,`课程编号`,`分数`
FROM grade
WHERE `课程编号` = 0003 
AND `分数` IS NOT NULL

#（4）查询student_info的姓名和出生日期，查询结果按出生日期从大到小排序。
SELECT `姓名`,`出生日期`
FROM student_info 
ORDER BY `出生日期` DESC

#（5）查询所有姓名“张”的学生的学号和姓名。
SELECT `姓名`,`学号`
FROM student_info 
WHERE `姓名` LIKE "张%"

#3.对student_info表，查询学生的学号、姓名、性别、出生日期及家庭住址，查询结果先按照性别的由小到大排序，性别相同的再按学号由大到小排序。
SELECT `学号`,`性别`,`姓名`,`出生日期`,`家庭住址`
FROM student_info
ORDER BY `性别` ASC,`学号` DESC

#4. 使用GROUP BY子句查询grade表中各个学生的平均成绩。
SELECT `学号`,ROUND(AVG(`分数`),1) AS 平均成绩 
FROM grade
GROUP BY `学号`

#5.使用UNION运算符针student_info表中姓“刘”的学生的学号、姓名与姓“张”的学生的学号、姓名返回在一个表中。
SELECT `学号`,`姓名`
FROM student_info
WHERE `姓名` LIKE "刘%"
UNION
SELECT `学号`,`姓名`
FROM student_info
WHERE `姓名` LIKE "张%"

# 6. 嵌套查询
#（1）在student_info表中查找与“刘东阳”性别相同的所有学生的姓名、出生日期。
SELECT `姓名`,`出生日期` 
FROM student_info 
WHERE `性别` IN(
SELECT `性别` 
FROM  student_info 
WHERE `姓名`='刘东阳');

#（2）使用IN子查询查找所修课程编号为0002、0005的学生学号、姓名、性别。
Select `学号`,`姓名`,`性别` 
from student_info
where `学号` in (
SELECT (`学号`) 
FROM grade
WHERE `课程编号` = '0002' OR 
`课程编号` = '0005');

#（3）使用ANY子查询查找学号为0001的学生的分数比0002号的学生的最低分数高的课程编号和分数。
SELECT `课程编号`,`分数` 
FROM grade
WHERE `学号`='0001' AND `分数` > ANY
(SELECT MIN(`分数`)
FROM grade 
WHERE `学号`='0002');

#（4）使用ALL子查询查找学号为0001的学生的分数比学号为0002的学生的最高成绩还要高的课程编号和分数。

SELECT `课程编号`,`分数` 
FROM grade  
WHERE `学号`='0001'AND `分数`>ALL
(SELECT MAX(`分数`)
FROM grade 
WHERE `学号`='0002');

#  7. 连接查询
#（1）查询分数在80-90范围内的学生的学号、姓名、分数。
SELECT s.`学号`,s.`姓名`,g.`分数`
FROM student_info s
JOIN grade g
ON s.`学号` = g.`学号`
WHERE g.`分数` BETWEEN 80 AND 90

#（2）使用INNER JOIN 连接方式查询学习“数据库原理及应用”课程的学生学号、姓名、分数。
SELECT s.`学号`,s.`姓名`,g.`分数`
FROM student_info s 
INNER JOIN grade g INNER JOIN curriculum c
ON s.`学号` = g.`学号` and g.`课程编号` = c.`课程编号`
WHERE c.`课程名称` = "数据库原理及应用";

#(3)查询每个学生所选课程的最高成绩，要求列出学号、姓名、最高成绩。
SELECT s.`学号`,s.`姓名`,MAX(`分数`) AS 最高分数
FROM student_info s, grade g
WHERE s.`学号` = g.`学号`
GROUP BY s.`学号`

#(4)使用左外连接查询每个学生的总成绩，要求列出学号、姓名、总成绩，没有选修课程的学生的总成绩为空。

SELECT s.`学号` ,s.`姓名`,sum(g.`分数`) 总成绩 
from student_info s left join grade g
on s.`学号`=g.`学号` group by s.`学号`;

#(5)为grade表添加数据行：学号为0004、课程编号为0006、分数为76。

Insert into grade (`学号`,`课程编号` ,`分数`) values ("0004","0006",76);

#使用右外连接查询所有课程的选修情况，要求列出课程编号、课程名称、选修人数，curriculum表中没有的课程列值为空。

Select c.`课程编号`,count(*) 选修人数
from grade g right join curriculum c 
on g.`课程编号`=c.`课程编号` 
group by g.`课程编号`;

#四、实验思考
#1. 查询所有没有选修课程的学生的学号、姓名。
Select g.`学号`,s.`姓名`
from student_info s,grade g 
where s.`学号`=g.`学号` and `课程编号` is null;

#2.查询选修课程的人数。
select `课程编号` ,count(*) 选修人数
from grade GROUP BY `课程编号`;

#3.查询选课人数大于等于3人的课程编号、课程名称、人数。
Select g.`课程编号`,c.`课程名称`,count(*) 人数
from grade g,curriculum c 
where g.`课程编号`=c.`课程编号` group by g.`课程编号` having count(*) >= 3;

