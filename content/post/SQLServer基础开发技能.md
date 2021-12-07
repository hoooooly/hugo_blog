---
title: "SQLServer基础开发技能"
subtitle: ""
description: ""
date: 2021-12-01T20:37:01+08:00
author: holy
image: ""
tags: ["tag1", "tag2"]
categories: ["Posts" ]
typora-root-url: ..\..\static\
---

# 创建数据库和数据表

## 数据库的创建

### 数据库分类

通过查看对象资源管理器来区分数据库类型

![image-20211127164211794](/images/image-20211127164211794.png)

- `master`：保存所有数据库的信息（系统登录、系统设置、已经连接的SERVER等）
- `model`：创建新用户数据库的模板数据库
- `msdb`：用来保存数据库备份，SQL Agent信息、DTS程序包、SQLSERVER任务等信息
- `tempdb`：存有临时对象，列如临时表格和存储过程

### 用户数据库文件组成

数据库物理文件的组成：数据库文件+日志文件

- `.mdf`（主数据文件）或`.ndf`（次要数据文件）
- `.ldf`日志文件

> 一个数据库必须且只能包含一个mdf，可以有多个ndf和ldf（至少一个）

### 创建数据库

- 创建一个主数据文件和一个日志文件

```sql
use master
go
create database StudentManageDB
on primary
(
	-- 数据库文件的逻辑名
	name='StudentManageDB_data',
	-- 数据库物理文件名（绝对路径）
	filename='D:\SQLserverDB\StudentManageDB_data.mdf',
	-- 数据库文件初始大小
	size=10MB,
	-- 数据文件增常量
	filegrowth=1MB
)
```

```sql
-- 创建日志文件
log on
(
	name='StudentManageDB_log',
	filename='D:\SQLserverDB\StudentManageDB_log.ldf',
	size=2MB,
	filegrowth=2MB
)
go
```

文件组类似于文件夹，主要用于管理磁盘文件，文件组分为主文件组和次文件组，日志文件不属于任何文件组

- 创建一个主数据文件和一个日志文件

```sql
use master
go
create database StudentManageDB
on primary
(
	-- 数据库文件的逻辑名
	name='StudentManageDB_data',
	-- 数据库物理文件名（绝对路径）
	filename='D:\SQLserverDB\StudentManageDB_data.mdf',
	-- 数据库文件初始大小
	size=10MB,
	-- 数据文件增常量
	filegrowth=1MB
),
(
	name='StudentManageDB_data1',
	-- 创建次要数据文件，不能和主数据文件同名
	filename='D:\SQLserverDB\StudentManageDB_data1.ndf',
	size=10MB,
	filegrowth=1MB
)
```

```sql
-- 创建日志文件
log on
(
	name='StudentManageDB_log',
	filename='D:\SQLserverDB\StudentManageDB_log.ldf',
	size=2MB,
	filegrowth=2MB
),
(
	name='StudentManageDB_log1',
	filename='D:\SQLserverDB\StudentManageDB_log1.ldf',
	size=2MB,
	filegrowth=2MB
)
go
```

### 删除数据库

- 删除方法

```sql
-- 判断当前数据是否存在
if exists (select * from sysdatabases where name='StudentManageDB')
drop database StudentManageDB		-- 删除数据库
go 
```

`drop`删除后数据库将不可恢复，谨慎使用

### 分离与附加数据库

- 分离数据库的必要性及语法

  - 当数据库运行中，通常无法直接移动和复制数据库文件
  - 所谓分离数据库就是将正在使用的数据库文件解除服务的限制

  ```sql
  exec sp_detach_db @name=数据库名称
  ```

- 附加数据库的必要性及语法

  - 附加数据库就是将指定位置的数据库文件加入到数据库服务中并运行
  - 数据库只有附加后，用户才能通过DBMS操作数据

  ```sql
  exec sp_attach_db @dbname=数据库名称，
  @filename1=数据库主文件物理文件路径
  @filename2=数据库日志文件物理文件路径
  ```

```sql
--分离数据库
exec sp_detach_db @dbname=StudentManageDB
--附加数据库方法1
exec sp_attach_db @dbname=StudentManageDB,
@filename1='D:\SQLserverDB\StudentManageDB_data.mdf',
@filename2='D:\SQLserverDB\StudentManageDB_log.ldf'
--附加数据库方法2
exec sp_attach_db StudentManageDB,
'D:\SQLserverDB\StudentManageDB_data.mdf',
'D:\SQLserverDB\StudentManageDB_log.ldf'
```

## 数据表的创建

### SQL Server数据类型

- 文本类型：字符数据包含任意字母、符号或数字字符的组合
  - `char`：固定长度的非Unicode字符数据，最大长度为8000个字符
  - `varchar`：可变长度的非Unicode数据，最大长度为8000个字符
  - `text`：存储长文本信息，最大长度为2<sup>31</sup>-1(2147483647)个字符
  - `nchar`：固定长度的Unicode数据，最大长度为4000个字符
  - `nvarchar`：可变长度的Unicode数据，最大长度为4000个字符
  - `ntext`：存储可变长度的长文本，2<sup>30</sup>-1(1073741823)个字符

- 整数类型
  - `bigint`：占用8个字节，可表示范围：-2<sup>63</sup>~2<sup>63</sup>-1之间的整数
  - `int`：占用4个字节，可表示范围：-2<sup>31</sup>~2<sup>31</sup>-1之间的整数
  - `smallint`：占用两个字节，可表示范围：-2<sup>15</sup>~2<sup>15</sup>-1之间的整数
  - `tinyint`：占用1个字节，可表示范围：0~255之间的整数
- 精确数字类型
  - `decimal`：-10<sup>38</sup>~10<sup>38</sup>-1之间的固定精度和小数的数字
  - `numeric`：功能等同于decimal
  - 写法：decimal（整数，小数）和numeric（整数，小数)
  - 默认：如果不指定位数，默认18位整数，0位小数
- 近似数据（浮点）类型
  - float[(n)]表示范围：-1.79E+308~1.79E+308（1.79乘以10的308次幂）
  - n表示精度，在1-53之间取值，当n在1-24之间时，精度为7位有效数字，占用4个字节；当n在25~53之间是，精度为15位有效数字，占用8个字节
  - real表示范围：-3.40E+38~3.40E+38占用4个字节存储空间，相当于float(24)
- 日期类型
  - `datetime`：允许的范围1753-1-1至9999-1-1
  - `smalldatetime`：允许的范围1900-1-1至2079-6-6
  - 时间精度不同：datetime精确到3/100秒；smalldatetime精确到1分钟
  - 格式说明：
    - 分隔数字方式：2013-08-20或08/20/2013
    - 纯数字方式：08202013
    - 英文数字方式：Aug 20,2013
  - 注意问题：日期在使用的时候需要使用单引号（'  ')括起来

- 货币类型
  - `money`：货币数值介于-2<sup>63</sup>与2<sup>63</sup>-1之间，精确到货币单位的千分之一
  - `smallmoney`：货币数据介于-214748.3648与-214748.3648之间，精确到货币单位的千分之十
- 位类型
  - `bit`：表示“是/否”类型的数据（0，1/true，false）
- 二进制类型
  - `binary`：固定长度的二进制数据，最大长度为8000个字节
  - `vbinary`：可变长度的二进制数据，其最大长度为8000个字节
  - `image`：可变长度的二进制数据，其最大长度为2<sup>31</sup>个字节
  - 应用场合：可存储图片

### 创建数据表

- 建表的语法

  ```sql
  create table 表名
  (
  	字段1	数据类型 列的特征,
  	字段2	数据类型 列的特征,
  	...
  )
  go
  ```

- 列的特征包含的内容

  - 是否为空（Null）：在输入数据时，数据库的列允许为空，可以不输入数据，否者必须输入。列表是否为空要根据数据库设计的具体要求决定，对于关键列必须禁止为空。
  - 是否是标识列（自动编号）
  - 是否有默认值：如果数据表的某列在用户不输入数据的时候，希望提供一个默认的内容
  - 是否为主键：主键是实体的唯一标识，保证实体不被重复。一个数据表必须有主键才有意义

 #### 标识符的特殊说明

- 标识列使用的意义
  - 一个数据表存储的实体，很难找到不重复的列作为主键
  - SQLServer提供一个“标识列”，也叫“自动增长列”或“自动编号”，它本身没有什么具体意义，但我们也可以让它表示特定意义。
- 标识列的使用方法
  - 该列必须是整数类型，或没有小数位数的精确类型
  - 标识种子：标识列的起始大小
  - 标识增量：标识列每次递增的（自动增加）值
- 注意问题
  - 有标识列的数据表被删除某一行时，数据库会将该行空缺，而不会填补
  - 标识列由系统自动维护，用户既不能自己输入数据，也不能修改数值
  - 标识列可以同时定义为主键，也可以不定义为主键，根据需要决定

```sql
use StudentManageDB
go
if exists(select * from sysobjects where name='Students')
drop table Students
go

create table Students
(
	StudentID int identity(100000,1), --学号
	StudentName varchar(20) not null, --姓名
	Gender char(2) not null, --性别
	Birthday datetime not null, --出生日期
	StudentIdNo numeric(18,0) not null, --身份证号
	Age int not null, --年龄
	PhoneNumber varchar(50), --手机号
	StudentAddress varchar(500), --地址
	ClassId int not null --班级外键
)
go

-- 创建班级表
if exists(select * from sysobjects where name='StudentClass')
drop table StudentClass
go

create table StudentClass
(
	ClassId int primary key, --班级编号
	ClassName varchar(20) not null
)
go

-- 创建成绩表
if exists(select * from sysobjects where name='ScoreList')
drop table ScoreList
go

create table ScoreList
(
	Id int identity(1,1) primary key,
	StudentID int not null, --学号外键
	CSharp int null,
	SQLServer int null,
	UpdateTime datetime not null --更新时间
)
go

-- 创建管理员表
if exists(select * from sysobjects where name='Admins')
drop table Admins
go

create table Admins
(
	LoginId int identity(1000,1) primary key,
	LoginPwd varchar(20) not null, --登录密码
	AdminName varchar(20) not null
)
go
```

## 数据的基本操作

### 插入实体

- 插入实体（数据行）语法

  ```sql
  insert [into] <表名> [列名] values <值列表>
  ```

- 插入实体的SQL语句示例

  ```sql
  insert into Students(StudentName,Gender,Birthday,StudentIdNo,Age,PhoneNumber,StudentAddress,ClassId)
  values('张三','男','1990-01-20',433302198730989090,26,'010-1231231','深圳海上世界',4)
  ```

- 注意事项

  - 列名个数=对应值的个数
  - 非值类型的数据，必须放在单引号内
  - 数据值的类型必须与定义的字段类型一致

### 查询实体

- 基本查询语法

  ```sql
  select <列名> from <源表名>[where<查询条件>]
  ```

- 查询实体的SQL语句示例

  ```sql
  select StudentId,StudentName from Students -- 查询两个字段
  select * from Students -- *表示查询所有字段
  ```

### T-SQL中的运算符

- 数据库常用运算符号

  | 运算符 | 含义       |
  | ------ | ---------- |
  | =      | 等于       |
  | >      | 大于       |
  | <      | 小于       |
  | >=     | 大于或等于 |
  | <=     | 小于或等于 |
  | <>     | 不等于     |
  | !      | 非         |

  ```sql
  -- 查询年龄大于22的学号，姓名，性别
  select StudentId,StudentName,Gender from Students where Age>=22
  ```

### 更新实体

- 更新实体语法

  ```sql
  update <表名> set <列名=更新值>[where <更新条件>] 
  ```

- 更新实体的SQL语句示例

  ```sql
  -- 更新数据
  update Students set Age=100, PhoneNumber='12345678910' where StudentID=100011
  ```

  使用update语句时，一定要注意where条件的配合使用

### 删除实体

- 删除数据表中数据语法

  ```sql
  delete from <表名>[where <删除条件>]
  ```

  ```sql
  truncate table <表名>
  ```

- 删除实体的SQL语句示例

  ```sql
  delete from Students where StudentID=100010
  delete from Students
  
  truncate table Students
  ```

  > 使用删除语句时，一定要注意where条件的配合使用
  >
  > delete删除数据时，要求该记录不能被外键引用，删除后标识列继续增长
  >
  > truncate删除数据时，要求删除的表不能由外键约束，删除后重新添加数据，删除后标识列重新编排
  >
  > truncate比delete执行速度快，而且使用的系统资源和事务日志资源更少

# 数据完整性设计与实现

## 数据完整性的设计

### 完整性约束的类型

- 常用三种类型的约束保证数据完整性

  - 域（列）完整性
  - 实体完整性
  - 引用完整性

- 主键约束与唯一约束

  - 添加约束的基本语法

    ```sql
    alter table 表名 add constraint 约束名 约束类型 具体的约束说明
    ```

  - 约束名的取名规则推荐采用：约束类型、约束字段

    - 主键（Primary）约束：如 PK_StudentId
    - 唯一（Unique Key）约束：如UQ_StudentIdNo

    ```sql
    use	StudentManageDB
    go
    
    use StudentManageDB
    go
    -- 创建主键约束
    if exists(select * from sysobjects where name='pk_StudentId')
    alter table Students drop constraint pk_StudentId
    alter table Students add constraint pk_StudentId primary key(StudentId)
    
    -- 创建唯一约束
    if exists(select * from sysobjects where name='uq_StudentIdNo')
    alter table Students drop constraint uq_StudentIdNo
    alter table Students add constraint uq_StudentIdNo unique(StudentIdNo)
    ```
    

### 检查约束

```sql
-- 创建检查约束
if exists(select * from sysobjects where name='ck_Age')
alter table Students drop constraint ck_Age
alter table Students add constraint ck_Age check(Age between 18 and 25)

if exists(select * from sysobjects where name='ck_PhoneNumber')
alter table Students drop constraint ck_PhoneNumber
alter table Students add constraint ck_PhoneNumber check(len(PhoneNumber)=11)
```

### 默认约束

```sql
-- 默认约束
if exists(select * from sysobjects where name='df_StudentAddress')
alter table Students drop constraint ck_StudentAddress
alter table Students add constraint ck_StudentAddress default('地址不详') for StudentAddress
```

### 外键约束

```sql
-- 外键约束
if exists(select * from sysobjects where name='fk_ClassId')
alter table Students drop constraint fk_ClassId
alter table Students add constraint fk_ClassId foreign key (ClassId) references StudentClass(ClassId)
```

## 数据完整性总结

### 实体完整性

- 能够唯一标识表中的每一条记录
- 实现方式：主键、唯一键、IDENTITY属性

### 域完整性

	- 表中特定列数据的有效性，确保不会输入无效的值
	- 实现方式：数据类型限制、缺省值、非空值

### 引用完整性

 - 维护表间数据的有效性、完整性
 - 实现方式：建立外键，关联另一表的主键

完整数据库创建过程

```mermaid
graph LR
	建库 --> 建表 --> 主键约束 --> 域完整性约束 --> 外键约束
```

插入数据过程

```mermaid
graph LR
	验证主键 --> 主外键关系 --> 约束检查 --> 插入成功
```

# 常用数据查询

## 数据的基本查询

### 理解查询

- 服务器执行命令，在原始数据表中查找符合条件的数据，产生一个虚拟表
- 虚拟表是数据组合后的重新展示，而不是原始的物理数据

### 基本语法构成

- 查询一般有四个基本组成部分

  - 查询内容，如`select studentId, StudentName, Gender`

  - 查询对象，如`from Students`

  - 过滤条件，如`where Gender='男'`

  - 结果排序，如`oder by StudentId DESC`

- 基本查询语法框架

  ```sql
  select <列名>
  from <表名>
  [where <查询条件表达式>]
  [order by <排序的列名>[ASC或DESC]]
  ```

- 查询全部行和列

  ```sql
  -- 查询全部行和列
  select * from Students
  ```

- 查询部分行

  ```sql
   查询部分行
  select StudentName,Gender,Birthday,Age from Students where Gender='男' and Age>=22
  
  select StudentName,Gender,Birthday,Age from Students where Age>=22
  ```

  多个条件使用and连接

- 使用"AS"或使用"="重新命名字段

  ```sql
  -- 自定义命名行
  select StudentName as 学生姓名,性别=Gender,年龄=Age from Students
  ```

- 加号的使用

  ```sql
  -- 列的合并
  select 姓名=StudentName,地址和电话=StudentAddress+'['+PhoneNumber+']' from Students
  ```

  > 注意：
  >
  > 1. `+`连接的数据类型必需兼容
  > 2. 如果使用`+`连接字符型数据，结果为字符串数据的连接
  > 3. 如果使用`+`连接数值型数据，结果为数值的和

- 查询空列

  ```sql
  insert into ScoreList(StudentId,CSharp)values(100001, 89)
  
  select * from ScoreList where SQLServer is null
  ```

- 使用常量列

  ```sql
  select StudentName,Gender,Age='28' from Students where Gender='男'
  ```

  无中生有添加列

- 限制固定行数

  ```sql
  select top 5 StudentName,Gender,Birthday from Students
  ```

- 返回百分之多少行

  ```sql
  select top 20 percent StudentName,Gender,Birthday from Students
  ```

- 按多列排序

  ```sql
  select StudentId,CSharp as C#,DB=SQLServerDB from ScoreList
  order by SQLServerDB ASC,CSharp DESC
  ```

## 查询函数的使用

## 聚合函数

- 对某一列求总和、对满足条件的记录总数求和

  ```sql
  select SUM(CSharp) as C#总成绩 from ScoreList 
  select 总人数=COUNT(*) from Students
  ```

- 求最大值、最小值

  ```sql
  select MAX(CSharp) as C#最高分, MIN(CSharp) as C#最低分 from ScoreList
  ```

## 多表之间的数据查询

### 内连接查询

查询结果是两个源表中严格满足连接条件的记录相连

```sql
select Students.StudentId,C#成绩=CSharp,StudentName,ClassName 
from ScoreList
inner join Students on Students.StudentId=ScoreList.StudentId
inner join StudentClass on Students.ClassId=StudentClass.ClassId
where CSharp > 80
```

需要注意的问题：

1. 需要连接的表
2. 两个表连接的条件（主外键）
3. 两个表中相同的公共字段必需说明来自那个表

### 左外连接查询

查询的结果包括两个表所有满足连接条件的记录，以及左表所有不满足条件的其他记录。这些不满足的左表记录，在结果的右边位置，全部填上Null值  

```sql
select Students.StudentId,StudentName, Gender,C#成绩=CSharp
from Students
left outer join ScoreList on Students.StudentId=ScoreList.StudentId
where Gender='男'
```

### 右外连接查询

查询的结果包括两个表所有满足连接条件的记录，以及右表所有不满足条件的其他记录。这些不满足的右表记录，在结果的左边位置，全部填上Null值  

```sql
select Students.StudentId,StudentName,ClassName
from Students
right outer join StudentClass on Students.ClassId=StudentClass.ClassId
```

## 分组查询与统计

```sql
-- 分组查询
select 班级=StudentClass.ClassName,人数=COUNT(*),C#最高分=MAX(CSharp)
from Students
inner join StudentClass on Students.ClassId=StudentClass.ClassId
inner join ScoreList on ScoreList.StudentId=Students.StudentId
group by ClassName
```

### 分组统计筛选--having

```sql
select 班级=StudentClass.ClassName,人数=COUNT(*),C#最高分=MAX(CSharp),DB平均分=AVG(SQLServer)
from Students
inner join StudentClass on Students.ClassId=StudentClass.ClassId
inner join ScoreList on ScoreList.StudentId=Students.StudentId
group by ClassName
having AVG(CSharp)>=70 and AVG(SQLServer)>=70
```

### 查询重复数据

```sql
-- 在知道那个字段重复的情况下
select StudentId from ScoreList group by StudentId having COUNT(*)>1

-- 查询所有的重复的记录
select * from ScoreList
where StudentId in(select StudentId from ScoreList group by StudentId having COUNT(*)>1)
order by StudentId

-- 其他方法
select * from ScoreList
where (select COUNT(*) from ScoreList s where s.StudentId=ScoreList.StudentId)>1
order by StudentId
```

### 分组查询对比

- `where`子句：
  - 从数据源中去掉不符合其搜索条件的数据
- `group by`子句：
  - 搜集数据行到各个组中，统计函数为各个组计算统计值
- `having`子句：
  - 在分组结果中，去掉不符合其组搜索条件的各组数据行

```mermaid
graph LR
	A[ where ] 
	B[ group by ] 
	C[ having ]
	A --> B --> C
	
```

# 数据库设计

## 数据库设计的基本步骤

- 需求分析

  - 通过向客户调研，了解客户的实际需求

  - 总结分析客服所需要的管理系统，究竟需要哪些处理数据

    > 以学员管理系统开发为背景，分析系统的基本功能：
    >
    > 1. 学院信息管理模块：数据库中存放着学员的个人信息；需要对学员信息进行管理
    > 2. 学员成绩管理模块：数据库中保存每次学员的考试成绩；需要对考试成绩进行分析
    > 3. 学员班级管理模块：数据库中保存着学员的班级信息
    > 4. 课程管理模块：数据库中存放着课程信息

- 标识对象（实体）并设计对象的属性

  - 对象（或实体）将来映射为数据库中的数据表
  - 对象的属性，映射为数据表的字段
  - 对象应该有唯一的标识（ID）

  ```mermaid
  classDiagram
  class 学员信息{
  	学号<ID>
  	姓名
  	性别
  	出生日期
  	联系电话
  	家庭住址
  	所在班级
  }
  
  class 成绩信息{
  	学号
  	课程编号
  	成绩
  	考试日期
  	<ID>
  }
  
  class 班级信息{
  	班级名称
  	班级编号<ID>
  }
  
  class 课程信息{
  	课程编号<ID>
  	课程名称
  	学分
  }
  ```

  > 注意：
  >
  > 1. 需要设计多少实体，取决于需求分析结果，以及设计人员的其他考虑
  > 2. 对于实体的多少，以及实体属性的确定，需要设计人员不断的根据需要修改
  > 3. 实体必须有唯一的标识，如果当前实体属性没有能够作为标识的，需要添加ID
  > 4. 实体设计的好坏，关系到后续系统的修改，应当力求做到完善

- 确定对象之间的映射关系
  - 对象之间通过外键映射，减少数据冗余
  - 对象之间的映射关系是通过对象的唯一标识建立的
  - 常见的对象映射关系有一对一和一对多或者多对多

## 数据库设计的检验与模型设计

### 数据库三范式

- 范式：是具有最小冗余的表结构
- 范式类型：
  - 第一范式（1st NF - First Normal Form）
  - 第二范式（2nd NF - Second Normal Form）
  - 第三范式（3nd NF - Third Normal Form）

### 第一范式（1st NF - First Normal Form）

- 第一范式：目标是确保每列的原子性（即不可再分的最小数据单元）
- 第一范式一般都能满足
- 常见的第一范式不满足情况：地址、姓名（有时分开使用）

### 第二范式（2nd NF - Second Normal Form）

如果一个关系满足1NF，并且除了主键以外的其他列，都和主键列相关，则满足第二范式（2NF）

