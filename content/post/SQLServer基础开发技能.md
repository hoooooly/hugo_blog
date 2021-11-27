---
title: "SQLServer基础开发技能"
subtitle: ""
description: ""
date: 2021-11-27T16:37:14+08:00
author: holy
image: ""
tags: ["tag1", "tag2"]
categories: ["Posts" ]
draft: true
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

 

