---
title: "SQLServer基础开发技能"
subtitle: ""
description: ""
date: 2021-12-08T00:57:01+08:00
author: holy
image: ""
tags: ["ADO", "SQL", "Csharp"]
categories: ["Posts" ]
typora-root-url: ..\..\static\
---

# ADO.NET数据访问技术

## 学习目标

1. 掌握C#访问数据库的基本方法
2. 掌握数据库查询的各种方法
3. 重点理解和掌握OOP原则在数据访问中的应用

## ADO.NET组件与数据库连接

### 理解ADO.NET

- ActiveX Data Objects（ADO）
- 是.NET平台下应用程序和数据源进行交互的一组面向对象类库
- 简单理解即：数据访问组件

### 主要组件

‎用于访问和操作数据的 ADO.NET 的两个主要组件是 .NET Framework 数据提供程序和‎[‎DataSet‎](https://docs.microsoft.com/en-us/dotnet/api/system.data.dataset)‎。‎

###   .NET Framework 数据提供程序类型

- .NET Framework数据提供程序
  - SQL Server数据库->System.Data.SqlClient命名空间
  - Access、Excel或SQLServer数据源->System.Data.OleDb命名空间
  - Oracle数据库->System.Data.OracleClient命名空间（需要添加引用）
  - ODBC公开数据库->System.Data.Odbc命名空间
- 第三方提供的数据提供程序：Mysql.NET数据提供程序

### 连接数据库的准备

- SQL Server服务器端口查看与修改

  启用TCP/IP

![](images/image-20211208012717807.png)

修改端口号

![](images/image-20211208013007932.png)

重启服务后生效

### 如何正确连接数据库

- 需要四个条件
  - 服务器IP地址
  - 数据库名称
  - 登录账号
  - 登录密码
- 账号的使用
  - sa账号拥有访问数据库的所有权限，学习和开发测试阶段使用

