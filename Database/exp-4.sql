-- 1. 查询每个学生选课情况(包括没有选秀课程的学生)

SELECT S.xm,C.km
FROM S,E,C
WHERE S.xh=E.xh AND E.kh=C.kh

-- 2. 检索所有课程都选修的学生的学号和姓名

SELECT S.xh,S.xm
FROM S
GROUP by S.xh
HAVING count(*)=(SELECT count(*) FROM C)

-- 3. 检索选修课程包括1106同学所学全部课程的学生学号和姓名

-- 4. 查询每门课程中分数最高的学生学号和学生姓名

SELECT S.xh,S.xm,E.kh
FROM S,E,
(SELECT MAX(cj) AS m_cj,kh
FROM E
GROUP BY kh) AS E2 
WHERE E.xh=S.xh AND E.kh=E2.kh AND E.cj=E2.m_cj

-- 5. 查询年龄小于本学院平均年龄，所有课程成绩都高于所选课程平均成绩的学生学号，姓名，平均总评成绩，按年龄排序

SELECT temp1.xh,temp1.xm
FROM
-- temp1存各学生总评成绩>平均成绩的课程的个数
(SELECT S.xh,S.xm,count(*) AS cnt
FROM S,E
WHERE S.xh=E.xh AND E.cj>(SELECT AVG(E1.cj) FROM E as E1 GROUP BY E1.kh HAVING E1.kh=E.kh)
GROUP BY S.xh) AS temp1,
-- temp2存各年龄小于平均年龄的学生的选课个数
(SELECT S.xh,S.xm,count(*) AS cnt
FROM S,E
WHERE S.xh=E.xh AND Year(NOW())-Year(S.csrq)<(SELECT AVG(Year(NOW())-Year(S.csrq)) FROM S)
GROUP BY S.xh) AS temp2
-- 二者根据cnt取交集，cnt相等说明所有课的成绩大于平均成绩
WHERE temp1.cnt=temp2.cnt AND temp1.xh=temp2.xh;

-- 研讨：

-- 1. 

-- 2.

-- 3.

SELECT temp1.xh,temp1.xm
FROM
-- temp1存各学生总评成绩>平均成绩的课程的个数
(SELECT S.xh,S.xm,count(*) AS cnt
FROM S,E
WHERE S.xh=E.xh AND E.cj<(SELECT AVG(E1.cj) FROM E as E1 GROUP BY E1.kh HAVING E1.kh=E.kh)
                AND Year(NOW())-Year(S.csrq)<(SELECT AVG(Year(NOW())-Year(S.csrq)) FROM S)
GROUP BY S.xh) AS temp1,
-- temp2存各学生的选课个数
(SELECT S.xh,S.xm,count(*) AS cnt
FROM S,E
WHERE S.xh=E.xh
GROUP BY S.xh) AS temp2
-- 二者根据cnt取交集，cnt相等说明所有课的成绩大于平均成绩
WHERE temp1.cnt=temp2.cnt AND temp1.xh=temp2.xh;


SELECT temp1.xh,temp1.xm
FROM
-- temp1存各学生总评成绩>平均成绩的课程的个数
(SELECT S.xh,S.xm,count(*) AS cnt
FROM S,E,
    (SELECT kh,AVG(E.cj) AS avg_cj
    FROM E
    GROUP BY E.kh) AS E1
WHERE S.xh=E.xh AND E.kh=E1.kh AND E.cj<E1.avg_cj
GROUP BY S.xh) AS temp1,
-- temp2存各年龄小于平均年龄的学生的选课个数
(SELECT S.xh,S.xm,count(*) AS cnt
FROM S,E
WHERE S.xh=E.xh AND Year(NOW())-Year(S.csrq)<(SELECT AVG(Year(NOW())-Year(S.csrq)) FROM S)
GROUP BY S.xh) AS temp2
-- 二者根据cnt取交集，cnt相等说明所有课的成绩大于平均成绩
WHERE temp1.cnt=temp2.cnt AND temp1.xh=temp2.xh;


-- 4.
