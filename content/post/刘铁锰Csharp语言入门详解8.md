---
title: "刘铁锰《C#语言入门详解》 传值/输出/引用/数组/扩展方法"
subtitle: ""
description: ""
date: 2021-11-27T11:27:26+08:00
author: holy
image: ""
tags: ["Csharp"]
categories: ["Posts" ]
typora-root-url: ..\..\static
---

# C#入门详解-刘铁锰  传值/输出/引用/数组/扩展方法

## 本节内容

- 传值参数
- 输出参数
- 引用参数
- 数值参数
- 具名参数
- 可选参数
- 扩展方法（this参数）

## 传值参数

传值参数->引用类型，并且创建新对象

![image-20211127153341281](/images/image-20211127153341281.png)

> 注意：
>
> - 值参数创建变量的副本
> - 对值参数的操作永远不影响变量的值

```csharp
using Parameters1Example;



Student stu = new Student() { Name = "Tom" };

static void SomeMethod(Student stu)
{
    stu = new Student() { Name="Tim"};
    Console.WriteLine("{0},{1}",stu.GetHashCode(), stu.Name); // Tim
}

SomeMethod(stu);

Console.WriteLine("{0},{1}", stu.GetHashCode(), stu.Name); // Tom
```

传值参数->引用类型，只操作对象，并不创建新对象

![image-20211127162527935](/images/image-20211127162527935.png)

> 注意：
>
> 对象还是那个对象，值被修改了

## 引用参数



