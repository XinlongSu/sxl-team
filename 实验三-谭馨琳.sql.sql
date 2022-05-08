use studentsdb;


SELECT 学号,姓名,出生日期 from student_info;


SELECT 姓名,家庭住址 FROM student_info
where 学号=0002;


SELECT 姓名,出生日期 from student_info
where 出生日期>'1995-01-01'AND 性别='女';
		

SELECT 学号,课程编号,分数 FROM grade
WHERE 分数 BETWEEN 70 AND 80;


SELECT avg(分数) FROM grade
where 学号=0002;


SELECT COUNT(学号) FROM grade
WHERE 课程编号=0003;
SELECT COUNT(学号) FROM grade
WHERE 课程编号=0003 and 分数 is not null;


SELECT 姓名,出生日期 FROM student_info
ORDER BY 出生日期;


SELECT 学号,姓名 FROM student_info
WHERE 姓名 like '张%';


SELECT 学号,姓名,性别,出生日期,家庭住址 FROM student_info
ORDER BY 性别,学号;


SELECT AVG(分数) FROM grade
GROUP BY 学号;


SELECT 学号,姓名 FROM student_info
WHERE 姓名 like '刘%'
UNION
SELECT 学号,姓名 FROM student_info
WHERE 姓名 like '张%';


SELECT 姓名,出生日期 FROM student_info
WHERE 性别=(SELECT 性别 FROM student_info
            WHERE 姓名= '刘东阳');


SELECT 学号,姓名,性别 FROM student_info
WHERE 学号 in (SELECT 学号 FROM grade
               WHERE 课程编号=0002 or 课程编号=0005);


SELECT 课程编号,分数 FROM grade
WHERE 分数>any(SELECT min(分数) FROM grade WHERE 学号=0002)and 学号=0001;



SELECT 课程编号,分数 FROM grade
WHERE 分数>all(SELECT max(分数) FROM grade WHERE 学号=0002)and 学号=0001;


SELECT s.学号,姓名,分数 FROM grade g,student_info s
WHERE g.学号=s.学号 and g.分数 BETWEEN 80 AND 90;


SELECT s.学号,姓名,分数 FROM grade g INNER JOIN student_info s on g.学号=s.学号
WHERE g.`课程编号` = (SELECT 课程编号 FROM curriculum WHERE 课程编号 = '数据库原理及应用');


SELECT s.学号,姓名,max(分数)FROM grade g INNER JOIN student_info s on g.学号=s.学号
GROUP BY s.学号;


SELECT s.学号,姓名,sum(分数)FROM grade g left OUTER JOIN student_info s on g.学号=s.学号
GROUP BY s.学号;


INSERT INTO `grade` VALUES ('0004', '0006', 76);
SELECT g.`课程编号`, c.`课程名称`, COUNT(g.`课程编号`)选修人数 FROM `curriculum` c RIGHT OUTER JOIN`grade` g
ON c.`课程编号`=g.`课程编号`
GROUP BY c.`课程编号`
ORDER BY g.`课程编号`;


SELECT 学号, 姓名 FROM student_info
WHERE 学号 NOT IN (SELECT 学号 FROM grade);


SELECT COUNT(*) '选修课程的人数' FROM (SELECT COUNT(g.学号) FROM grade g
GROUP BY 学号) b;


SELECT 课程编号, 课程名称, 选修人数 FROM (
SELECT c.课程编号, c.课程名称, COUNT(g.课程编号) '选修人数' FROM curriculum c RIGHT OUTER JOIN grade g
ON c.课程编号=g.课程编号
GROUP BY c.课程编号
ORDER BY g.课程编号) a
WHERE 选修人数 >= 3;



























