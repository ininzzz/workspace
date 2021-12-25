-- 1 验证在1000万个以上记录时在索引和不索引时的查询时间区别

-- 2 查询2011年进校年龄大于20岁的男学生的学号与姓名
SELECT xh, xm
FROM S
WHERE (xh div 100) = 11 AND (2021-Year(csrq)) > 20;

-- 3 检索刘晓明不学的课程的课程号
SELECT DISTINCT kh
FROM E
WHERE xh NOT IN (SELECT xh 
                 FROM S
                 WHERE xm = '刘晓明');

-- 4 检索马小红老师所授课程的学年，学期，课程号，上课时间
SELECT left(xq,4) as xn, right(xq,2) as xq, kh, sksj
FROM O
WHERE gh IN (SELECT gh
             FROM T
             WHERE xm = '马小红');

-- 5 查询计算机学院男生总评成绩及格，教授开设的课程的课程号，课名，开课教师姓名，按开课教师升序，课程号降序排列
SELECT DISTINCT E.kh,C.km,T.xm
FROM E,C,T,S
WHERE ((E.gh=T.gh) AND (E.kh=C.kh) AND (E.xh=S.xh))
        AND (E.cj>=60)
        AND (T.zc='教授')
        AND (S.xb='男')
ORDER BY T.xm,E.kh DESC;

-- 6 检索学号比张颖同学大，年龄比张颖同学小的同学的学号，姓名
SELECT xh,xm
FROM S
WHERE xh>(SELECT xh FROM S WHERE xm='张颖')
        AND DATEDIFF(NOW(),csrq)<(SELECT DATEDIFF(NOW(),csrq) FROM S WHERE xm='张颖');

-- 7 检索同时选修了“08305001”和“08305002”的学生学号和姓名

SELECT xh,xm
FROM
(SELECT S.xh,S.xm,count(*) as cnt
FROM S,E
WHERE S.xh=E.xh AND (E.kh=08305001 OR E.kh=08305002) AND E.cj IS NOT NULL
GROUP BY S.xh) AS E2
WHERE E2.cnt=2;

-- 研讨：
-- 1. 
CONSTRAINT T_xb CHECK(xb IN ('男','女'))
CONSTRAINT T_xs CHECK(xs > 2500)

-- 2.

-- 3. 
SELECT left(xq,4) as xn, right(xq,2) as xq, kh, sksj
FROM O
WHERE gh IN (SELECT gh
             FROM T
             WHERE xm = '马小红');

SELECT left(O.xq,4) as xn, right(O.xq,2) as xq, O.kh, O.sksj
FROM O,T
WHERE O.gh=T.gh AND T.xm='马小红';

-- 4 .


