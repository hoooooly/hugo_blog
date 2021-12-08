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

### Connection对象

- 作用：建立应用程序和数据库的点对点连接

- 属性：ConnectionString(连接字符串)

  - 封装连接数据库的四个条件

  - Server=服务器名称或IP地址;DataBase=数据库名称;User ID=登录账户;Password=登录密码

  - 使用SQLServer用户验证登录的字符串示例

    ```bash
    Server=192.168.1.2;DataBase=StudentManageDB;Uid=xiaoming;Pwd=password
    ```

  - 使用Windows集成验证登录的字符串示例（仅限于本机）

    ```bash
    Data Source=; Initial Catalog=StudentManageDB;Integrated Security=True
    ```

- 方法：

  - Open()：打开连接
  - Close()：关闭连接

## 数据库增、删、改方法的编写

### Command对象

- 作用：向数据库发送SQL语句
  - 封装“连接对象”和要执行的“SQL语句”
  - 对数据库执行具体的操作，提供“增、删、改、查”的方法
- 属性
  - CommandText：需要封装的SQL语句或存储过程名称
  - Connection：Command对象使用的数据库连接对象
- 方法：
  - ExecuteNonQuery()：执行增、删、改操作
  - ExecuteScalar()：返回单一结果查询
  - ExecuteReader()：返回只读数据列表的查询
- ExecuteNonQuery()方法使用要点
  - 执行insert、update、delete类型的语句
  - 执行后返回受影响的行数，一般是大于0的整数，等于0说明没有影响，-1表示执行出错

```c#
using System;
// 引入命名空间
using System.Data;
using System.Data.SqlClient;


namespace ADOConnectSql
{
    internal class Program
    {
        static void Main(string[] args)
        {
            // 定义连接字符串
            // string connStrings = "Server=.;Database=StudentsManageDB;UID=sa;PWD=sqlpassword";
            string connStrings = "Data Source=; Initial Catalog=StudentManageDB;Integrated Security=True";

            // 创建连接对象
            SqlConnection sqlConnection = new SqlConnection(connStrings);
            // 打开连接
            try
            {
                sqlConnection.Open();
                if (ConnectionState.Open == sqlConnection.State)
                {
                    // Console.WriteLine("Connection is opened");
                    // 连接成功，执行SQL语句
                    string sqlString = @"insert into Students(StudentName,Gender,Birthday,StudentIdNo,Age,PhoneNumber,StudentAddress,ClassId)";
                    sqlString += "values('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}')";
                    sqlString = string.Format(sqlString, "张三", "男", "1990-09-01", 413302198730289090, 20, "12972782727", "北京", 1);
                    // 创建Command对象
                    /*SqlCommand sqlCommand = new SqlCommand();
                    sqlCommand.CommandText = sqlString;*/
                    SqlCommand sqlCommand = new SqlCommand(sqlString, sqlConnection);

                    int result = sqlCommand.ExecuteNonQuery();

                    Console.WriteLine(result);
                }
                else
                {
                    Console.WriteLine("Connection is filed");
                }
            }
            catch (Exception ex)
            {

                Console.WriteLine(ex.Message);
            }
            
            // 关闭连接
            sqlConnection.Close();
            if (ConnectionState.Closed == sqlConnection.State)
            {
                Console.WriteLine("Connection is Closed");
            }
            Console.ReadLine();
        }
    }
}
```

修改实体

```c#
// 修改实体
                    string updateString = @"update Students set StudentName='{0}' where StudentId={1}";
                    updateString = string.Format(updateString,"钱七", 100005);
                    result = new SqlCommand(updateString, sqlConnection).ExecuteNonQuery();
```

### 获得标识列的值

- 问题引出

  - 在Students表中添加一个新的学员对象，并返回新增学员的学号
  - 提示：学号是自动标识的，即插入新纪录以后返回该记录的标识列

- 问题解决：

  - 在insert语句后面添加select @@identity查询

  - 执行ExecuteScalar()方法：同时执行insert和select

    ```sql
    insert insert into Students(StudentName,Gender,Birthday,StudentIdNo,Age,PhoneNumber,StudentAddress,ClassId)
    values('张三','男','1990-01-20',123302198730289090,24,'010-1231231','深圳海上世界',1);select @@identity
    ```

  - 说明

    - @@identity是数据库中的一个全局变量，里面保存着最近一次生成的标识列的值

  ```csharp
   string sqlString = @"insert into Students(StudentName,Gender,Birthday,StudentIdNo,Age,PhoneNumber,StudentAddress,ClassId)";
  sqlString += "values('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}');select @@identity";
  sqlString = string.Format(sqlString, "赵四", "男", "1990-09-01", 012307998730289090, 20, "13972782727", "北京", 1);
  SqlCommand sqlCommand = new SqlCommand(sqlString, sqlConnection);
  object res = sqlCommand.ExecuteScalar();
  
  Console.WriteLine(res);
  ```

  

### 
