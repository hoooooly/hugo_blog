---
title: "LINQ查询时机与查询形式.md"
subtitle: ""
description: ""
date: 2022-01-0322:47:01+08:00
author: holy
image: ""
tags: ["ADO", "SQL", "Csharp"]
categories: ["Posts" ]
typora-root-url: ..\..\static\
---

## LINQ查询的时机

- 观察如下代码的执行顺序

  ![linq_query](images/linq_query.png)

- 查询步骤

  - 获取数据源、定义查询、执行查询

- 观察结论

  - 定义查询后，查询并没有立即执行，而是直接到需要枚举结果（遍历）时才被真正执行
  - 这种方式称为"延时执行"（deferred execution）

## LINQ查询的两种形式

- Method Syntax，查询方式

​		主要利用`System.Linq.Enumerable`类中定义的扩展方法和Lambda表达式进行查询。

​		在此之前所用的查询都是这种方法。

- Query Syntax，查询语句方式

​		一种更接近SQL语法的查询方式，可读性更好。

​		查询语句最后还是要被翻译成查询方法。

![linq_query_twoway](images/linq_query_twoway.png)
