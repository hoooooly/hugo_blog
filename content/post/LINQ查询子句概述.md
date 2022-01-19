---
title: "LINQ查询子句概述.md"
subtitle: ""
description: ""
date: 2022-01-0422:05:01+08:00
author: holy
image: ""
tags: ["ADO", "SQL", "Csharp"]
categories: ["Posts" ]
typora-root-url: ..\..\static\
---

## LINQ查询子句概述

### 查询表达式

查询表达式是一种查询语法表示的表达式，由一组用类似SQL的语法编写的句子组成。每一个子句可以包含一个或多个C#表达式。

```csharp
var list = from num in nums
    where num % 2 != 0
    orderby num descending
    select num;
```

> LINQ查询表达式必需以`from`子句开头，并且必需以`select`或`group`子句结束，中间可以添加多个子句

### LINQ查询表达式包含的子句

- `from`子句：指定查询操作的数据源和范围变量
- `where`子句：筛选元素的逻辑条件，返回值是一个`bool`类型
- `select`子句：指定查询结果的类型和表现形式
- `orderby`子句：对查询结果进行排序（升序或降序）
- `group`子句：对查询结果进行分组
- `into`子句：提供一个临时的标识符，该表示可充当对`join/group/select`子句结果的引用
- `join`子句：连接多个查询操作的数据源
- `let`子句：引入用于存储查询表达式的子表达式结果的范围变量

## `from`子句

LINQ查询表达式必需包含`from`子句，并且必须以`from`子句开头。`from`子句指定的数据源类型必须为`IEnumerable`、`IEnumerable<T>`或者两者的派生类型（例如：数据、List<T>、ArrayList等)

```csharp
int[] nums = {1, 7, 9, 10, 29, 21}
var list = from num in nums
    where num % 2 != 0
    orderby num descending
    select num;
```

如果数据源是泛型类型，则编译器可以自动推断出范围变量的类型，比如上面的`num`类型为`int`类型。如果数据源是非泛型类型，如`ArrayList`，则必须显式的指定范围变量的数据类型。

### 复合`from`子句查询

如果数据源（本身是一个序列）的元素还包含子数据源（如序列、列表等），如果要查询子数据源中的数据则需要使用`from`子句。

```csharp
Student obj1 = new Student() { StudId = 1001, StuName = "学员1", ScoreList = new List<int>() { 90, 80, 100 } };
Student obj2 = new Student() { StudId = 1001, StuName = "学员2", ScoreList = new List<int>() { 90, 98, 50 } };
Student obj3 = new Student() { StudId = 1001, StuName = "学员3", ScoreList = new List<int>() { 90, 60, 45 } };
List<Student> stuList = new List<Student>() { obj1, obj2, obj3 };
// 查询成绩包含95分以上的学员
var result = from stu in stuList
    from score in stu.ScoreList
    where score >= 95
    select stu;
// 显示查询结果
foreach (var item in result)
{
    Console.WriteLine("成绩包含95以上的学员有：{0}", item.StuName);
}
Console.ReadLine();
```

输出结果：

```bash
成绩包含95以上的学员有：学员1
成绩包含95以上的学员有：学员2
```

### 多个from子句查询

若LINQ查询表达式包含两个或两个以上的独立数据源时，可以使用多个`from`子句查询所有数据。

```csharp
#region 示例9：多个from子句查询
Student obj1 = new Student() { StudId = 1001, StuName = "学员1" };
Student obj2 = new Student() { StudId = 1012, StuName = "学员2" };
Student obj3 = new Student() { StudId = 1003, StuName = "学员3" };
Student obj4 = new Student() { StudId = 1014, StuName = "学员4" };
Student obj5 = new Student() { StudId = 1004, StuName = "学员5" };
Student obj6 = new Student() { StudId = 1024, StuName = "学员6" };

List<Student> stuList1 = new List<Student>() { obj1, obj2, obj3 };
List<Student> stuList2 = new List<Student>() { obj4, obj5, obj6 };

// 查询学号大于1010的学员
var result = from stu1 in stuList1
    where stu1.StudId >= 1010
    from stu2 in stuList2
    where stu2.StudId >= 1010
    select new { stu1, stu2 };
// 显示查询结果
foreach (var item in result)
{
    Console.WriteLine(item.stu1.StuName + " " +item.stu1.StudId);
    Console.WriteLine(item.stu2.StuName + " " +item.stu2.StudId);
}
Console.ReadLine();
#endregion
```

## 高级查询方法

### 聚合类

- Count返回集合项的数目

```csharp
#region Count返回集合项的数目
Student obj1 = new Student() { StudId = 1001, StuName = "学员1" };
Student obj2 = new Student() { StudId = 1012, StuName = "学员2" };
Student obj3 = new Student() { StudId = 1003, StuName = "学员3" };
Student obj4 = new Student() { StudId = 1014, StuName = "学员4" };
Student obj5 = new Student() { StudId = 1004, StuName = "学员5" };
Student obj6 = new Student() { StudId = 1024, StuName = "学员6" };

List<Student> students = new List<Student>() { obj1, obj2, obj3, obj4, obj5, obj6 };

var count1 = (from c in students
              where c.StudId > 1010
              select c).Count();

var count2 = students
    .Where(c => c.StudId > 1010)
    .Count();
Console.WriteLine("count1={0}, count2={1}", count1, count2);

// count1=3, count2=3
#endregion
```

- 聚合函数Max/Min，Average，Sum，最大值/最小值，平均值，Sum返回集合总数

```csharp
#region Max Min Average Sum
Student obj1 = new Student() { StudId = 1001, Age =22 ,StuName = "学员1" };
Student obj2 = new Student() { StudId = 1012, Age = 21, StuName = "学员2" };
Student obj3 = new Student() { StudId = 1003, Age = 37, StuName = "学员3" };
Student obj4 = new Student() { StudId = 1014, Age = 29, StuName = "学员4" };
Student obj5 = new Student() { StudId = 1004, Age = 27, StuName = "学员5" };
Student obj6 = new Student() { StudId = 1024, Age = 25, StuName = "学员6" };

List<Student> students = new List<Student>() { obj1, obj2, obj3, obj4, obj5, obj6 };

var maxAge = (from s in students
              select s.Age).Max();
var minAge = (from s in students
              select s.Age).Min();
var avrAge = (from s in students
              select s.Age).Average();
var sumAge = (from s in students
              select s.Age).Sum();

Console.WriteLine("maxAge:{0}, minAge:{1}, avrAge:{2}, sumAge:{3}",maxAge, minAge, avrAge, sumAge);

// maxAge:37, minAge:21, avrAge:26.8333333333333, sumAge:161
#endregion
```

### 排序类

- ThenBy 提供符合排序条件

```csharp
#region ThenBy提供符合排序条件
Student obj1 = new Student() { StudId = 1001, Age = 22, StuName = "学员1" };
Student obj2 = new Student() { StudId = 1012, Age = 21, StuName = "学员2" };
Student obj3 = new Student() { StudId = 1003, Age = 37, StuName = "学员9" };
Student obj4 = new Student() { StudId = 1014, Age = 29, StuName = "学员4" };
Student obj5 = new Student() { StudId = 1004, Age = 27, StuName = "学员8" };
Student obj6 = new Student() { StudId = 1024, Age = 25, StuName = "学员6" };

List<Student> students = new List<Student>() { obj1, obj2, obj3, obj4, obj5, obj6 };

var stu1 = from s in students
    orderby s.StuName, s.Age, s.StudId
    select s;
var stu2 = students
    .OrderBy(s => s.StuName)
    .ThenBy(s => s.Age)
    .ThenBy(s => s.StudId)
    .Select(p => p);

foreach (var s in stu1)
{
    Console.WriteLine(s.StuName);
}
Console.WriteLine("-------------");
foreach (var s in stu2)
{
    Console.WriteLine(s.StuName);
}
#endregion
```



### 分区类

- Take 提取指定数量的项
- Skip 跳过指定数量的项并获取剩余的项
- TakeWhile 只要满足条件，就会返回序列的元素，然后跳过剩余的元素
- SkipWhile 只要满足指定的元素，就跳过序列中的元素，然后返回剩余元素

```csharp
#region 分区类
int[] nums = { 1, 2, 3, 4, 5, 6, 7, 8, 9 };
var list1 = nums.Skip(1).Take(3);
var list2 = nums.SkipWhile(i => i % 3 != 0)
    .TakeWhile(i => i % 2 != 0);
foreach (var item in list1) { Console.WriteLine(item); }
Console.WriteLine("----------------------");
foreach (var item in list2) { Console.WriteLine(item); }
//2
//3
//4
//----------------------
//3
#endregion
```

### 集合类

- Distinct 去掉集合中的重复项

```cs
int[] nums = { 1, 2, 2, 4, 5, 6, 8, 8 };
var list = nums.Distinct();
foreach (var item in list)
{
    Console.WriteLine(item);
}
//1
//2
//4
//5
//6
//8
```

### 生成类

- Range生成一个整数序列
- Repeat生成一个重复项序列

```csharp
var num1 = Enumerable.Range(1, 10);
var num2 = Enumerable.Repeat("LINQ best!", 10);
foreach (var item in num1)
{
    Console.WriteLine(item);
}
Console.WriteLine("-----------------");
foreach (var item in num2)
{
    Console.WriteLine(item);
}
```

> Rang/Repeat不是扩展方法，而是不同的静态方法
>
> Range只能产生整数序列
>
> Repeat可以产生泛型序列
>
> 所有的查询方法都放在System.Linq.Enumerable静态类中



