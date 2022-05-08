-- 1. 使用SQL语句ALTER TABLE分别删除studentsdb数据库的student_info表、grade表、curriculum表的主键索引。
USE studentsdb;
ALTER TABLE student_info
	DROP PRIMARY KEY;
ALTER TABLE grade
	DROP PRIMARY KEY;
ALTER TABLE curriculum
	DROP PRIMARY KEY;
	
-- 2. 使用SQL语句为curriculum表的课程编号创建唯一性索引，命名为cno_idx。
CREATE UNIQUE INDEX cno_idx
	ON curriculum(课程编号);

-- 3. 使用SQL语句为grade表的“分数”字段创建一个普通索引，命名为grade_idx。
CREATE INDEX grade_idx
	ON grade(分数);

-- 4. 使用SQL语句为grade表的“学号”和“课程编号”字段创建一个复合唯一索引，命名为grade_sid_cid_idx。
CREATE INDEX grade_sid_cid_idx
	ON grade(学号,课程编号);

-- 5. 查看grade表上的索引信息。
SHOW INDEX FROM grade;

-- 6. 使用SQL语句删除索引grade_idx。再次查看grade表上的索引信息。
DROP INDEX grade_idx ON grade;
SHOW INDEX FROM grade;

-- 7. 使用SQL语句CREATE VIEW建立一个名为v_stu_c的视图，显示学生的学号、姓名、所学课程的课程编号，并利用视图查询学号为0003的学生情况。
CREATE VIEW v_stu_c
	AS
	SELECT S.学号,姓名,课程编号 FROM 			student_info S,grade G
	WHERE S.学号 = G.学号;
SELECT *FROM v_stu_c
	WHERE 学号 = '0003';

-- 8. 基于student_info表、curriculum表和grade表，建立一个名为v_stu_g的视图，视图包括所有学生的学号、姓名、课程名称、分数。使用视图v_stu_g查询学号为0001的学生的课程平均分。
CREATE VIEW v_stu_g
	AS
	SELECT S.学号,姓名,课程名称,分数 
	FROM student_info S,grade G,curriculum C
	WHERE S.学号 = G.学号 AND G.课程编号 = C.课程编号;	
SELECT AVG(分数) FROM v_stu_g
	WHERE 学号 = '0001';
-- DROP VIEW v_stu_g

-- 9. 使用SQL语句修改视图v_stu_g，显示学生的学号、姓名、性别。
ALTER VIEW v_stu_g
	AS
	SELECT 学号,姓名,性别 FROM student_info;

-- 10.利用视图v_stu_g为student_info表添加一行数据：学号为0010、姓名为陈婷婷、性别为女。
INSERT INTO v_stu_g(学号,姓名,性别)
	VALUES('0010','陈婷婷','女');

-- 11.利用视图v_stu_g删除学号为0010的学生记录。
DELETE FROM v_stu_g
	WHERE 学号 = '0010';

-- 12.利用视图v_stu_g修改姓名为张青平的学生的高等数学的分数为87。
UPDATE grade SET 分数 = 87 
	WHERE 学号 = (SELECT 学号 FROM v_stu_g WHERE 姓名 = '张青平') 
				AND
				课程编号 = (SELECT 课程编号 FROM curriculum WHERE 课程名称  = '高等数学');
	

-- 13.使用SQL语句删除视图v_stu_c和v_stu_g。
DROP VIEW v_stu_c,v_stu_g;
