CREATE TABLE S
(
    xh int(4) zerofill,
    xm varchar(50),
    xb  varchar(5),
    csrq date,
    jg varchar(50),
    sjhm varchar(50),
    yxh int(2) zerofill REFERENCES D(yxh),
    zt char(50), 
    PRIMARY KEY(xh)
);

CREATE TABLE D
(
    yxh int(2) zerofill,
    mc varchar(50),
    dz varchar(50),
    lxdh varchar(50),
    PRIMARY KEY(yxh)
);

CREATE TABLE T
(
    gh int(4) zerofill,
    xm varchar(50),
    xb varchar(5),
    csry date,
    zc varchar(50),
    yxh int(2) zerofill REFERENCES D(yxh),
    PRIMARY KEY(gh)
);

CREATE TABLE C
(
    kh int(8) zerofill,
    km varchar(50),
    xf int,
    xs int,
    yxh int(2) zerofill REFERENCES D(yxh),
    PRIMARY KEY(kh)
);

CREATE TABLE O
(
    xq varchar(50), 
    kh int(8) zerofill REFERENCES C(kh),
    gh int(4) zerofill REFERENCES T(gh),
    sksj varchar(50),
    PRIMARY KEY(kh,gh)
);

CREATE TABLE E
(
    xh int(4) zerofill  REFERENCES S(xh),
    sksj varchar(50) REFERENCES O(sksj),
    kh int(8) zerofill REFERENCES C(kh),
    gh int(4) zerofill REFERENCES T(gh),
    cj int,
    PRIMARY KEY(xh,kh,gh),
    CONSTRAINT C_cj CHECK(cj BETWEEN 0 AND 100)
);


INSERT D VALUES(01,'计算机学院','上大东校区三号楼','65347567');
INSERT D VALUES(02,'通信学院','上大东校区二号楼','65341234');
INSERT D VALUES(03,'材料学院','上大东校区四号楼','65347890');

INSERT S VALUES(1101,'李明','男','1993-03-06','上海','13613005486',02,null);
INSERT S VALUES(1102,'刘晓明','男','1992-12-08','安徽','18913457890',01,null);
INSERT S VALUES(1103,'张颖','女','1993-01-05','江苏','18826490423',01,null);
INSERT S VALUES(1104,'刘晶晶','女','1994-11-06','上海','13331934111',01,null);
INSERT S VALUES(1105,'刘成刚','男','1991-06-07','上海','18015872567',01,null);
INSERT S VALUES(1106,'李二丽','女','1993-05-04','江苏','18107620945',01,null);
INSERT S VALUES(1107,'张晓峰','男','1992-08-16','浙江','13912341078',01,null);

INSERT T VALUES(0101,'陈迪茂','男','1973/3/6','副教授',01);
INSERT T VALUES(0102,'马小红','女','1972/12/8','讲师',01);
INSERT T VALUES(0201,'张心颖','女','1960/1/5','教授',02);
INSERT T VALUES(0103,'吴宝钢','男','1980/11/6','讲师',01);

INSERT C VALUES(08305001,'离散数学',4,40,01);
INSERT C VALUES(08305002,'数据库原理',4,50,01);
INSERT C VALUES(08305003,'数据结构',4,50,01);
INSERT C VALUES(08305004,'系统结构',6,60,01);
INSERT C VALUES(08301001,'分子物理学',4,40,03);
INSERT C VALUES(08302001,'通信学',3,30,02);

INSERT O VALUES('2020-01',08305001,0103,'星期三5-8');
INSERT O VALUES('2020-02',08305002,0101,'星期三1-4');
INSERT O VALUES('2020-02',08305002,0102,'星期三1-4');
INSERT O VALUES('2020-02',08305002,0103,'星期三1-4');
INSERT O VALUES('2020-02',08305003,0102,'星期五5-8');
INSERT O VALUES('2021-01',08305004,0101,'星期二1-4');
INSERT O VALUES('2021-01',08305001,0102,'星期一5-8');
INSERT O VALUES('2021-02',08302001,0201,'星期一5-8');

INSERT E VALUES (1101,'2020-01',08305001,0103,60);
INSERT E VALUES (1102,'2020-01',08305001,0103,87);
INSERT E VALUES (1102,'2020-02',08305002,0101,82);
INSERT E VALUES (1102,'2021-01',08305004,0101,null);
INSERT E VALUES (1103,'2020-01',08305001,0103,56);
INSERT E VALUES (1103,'2020-02',08305002,0102,75);
INSERT E VALUES (1103,'2020-02',08305003,0102,84);
INSERT E VALUES (1103,'2021-01',08305001,0102,null);
INSERT E VALUES (1103,'2021-01',08305004,0101,78);
INSERT E VALUES (1104,'2020-01',08305001,0103,74);
INSERT E VALUES (1104,'2021-02',08302001,0201,null);
INSERT E VALUES (1106,'2020-01',08305001,0103,85);
INSERT E VALUES (1106,'2020-02',08305002,0103,66);
INSERT E VALUES (1107,'2020-01',08305001,0103,90);
INSERT E VALUES (1107,'2020-02',08305003,0102,79);
INSERT E VALUES (1107,'2021-01',08305004,0101,null);

-- source ~/github/workspace/Database/create.sql