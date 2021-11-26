---
title: "刘铁锰《C#语言入门详解》 表达式 语句详解"
subtitle: ""
description: ""
date: 2021-11-25T16:33:26+08:00
author: holy
image: ""
tags: ["Csharp"]
categories: ["Posts" ]
typora-root-url: ..\..\static\images
---

# C#入门详解-刘铁锰  表达式 语句详解

## 本节内容

- 表达式的定义
- 各类表达式概览
- 语句的定义
- 语句详解

## 表达式的定义

- 什么是表达式
  - Expressions， together with commands and declarations, are one of the basic components of every programming  language. We can say that expressions are the essential component of every language
  - An expressions is a syntactic entity whose evaluation either produces a value or fails to terminate, in which case the expression is undefined
  - 各种编程语言对表达式的实现不尽相同，但大体上都符合这个定义

- C#语言对表达式的定义
  - An expression is a sequence of one or more operands and zero or more operators that can be evaluated to a single value, object, method, or namespace. Expressions can consist of a literal value, a method invocation, an operator and its operands, or a simple name. Simple names can be the name of a variable, type member, method parameter, namespace of type.
  - 算法逻辑的最基本（最小）单元，表达一定的算法意图
  - 因为操作符有优先级，所以表达式也就有了优先级

## 各类表达式概览

- C#语言中表达式的分类

  - A value. Every value has an associated type. 任何能够的得到值的运算

  - A value. Every variable has an associated type.

  - A namespace.

  - A type.

  - A method group.例如：Console.WriteLine，这是一组方法，重载决策决定具体调用哪一个

  - A null literal.

    ```csharp
    Form myForm = null; // null不属于任何类型
    ```

  - An anonymous function. 匿名方法

    ```csharp
    Action a = delegate(){Console.WriteLine("hello, world!")};
    a(); // a是一个委托方法

  - A property access. 属性表达式

  - An event access. 访问事件

  - An indexer access.

  - Noting. 对返回值为void的方法的调用

- 复合表达式的求值

  - 注意操作符的优先级同优先级操作符的运算方向

- 参考C#语言定义文档

  - 仅做参考，不必深究


## 语句的定义

- Wikipedia对语句的定义
  - In computer programming a statement is the smallest standalone element of an imperative programming language which expresses some action to be carried out. A program written in such a language id formed by a sequence of one or more statements. A statrment will have internal components(e.g., expressions)
  - 语句是高级语言的语法——编译语言和机器语言只有指令（高级语言中的表达式对应低级语言中的指令），*语句等价于一个或一组有明显逻辑关联的指令*。举例：求圆柱体积。

- C#语言对语句的定义

  - The *actions* that a program takes are expressed in statements. Common actions include declaring variables, assigning values, calling methods, looping through collections, and branching to one or another block of code, depending on a given condition. The order in which statements are executed in a program is called the flow of control or flow execution. The flow of control may vary every time that a program is run, depending on how the program reacts to input that it receives at run time.
  - C#语言的语句除了能够让程序员"顺序地"（sequentially）表达算法思想，还能通过条件判断、跳转和循环等方法控制程序逻辑的走向。
  - 简而言之就是：陈述算法思想，控制逻辑走向，完成`有意义`的动作（action）
  - C#语言的语句由分号（;）结尾，但由分号结尾的不一定都是语句
  - 语句一定是出现在方法体里

  ## 语句详解

  ```txt
  statment:					-声明语句
     labeled-statement	 	 -表达式语句
     declartion-statement       -块语句（简称“块”）
     embedded-statement		 -选择（判断、分支）语句
  embedded-statement:			 -迭代（循环）语句
      block					-跳转语句
      empty-statement			 -try...catch..finally语句
      expression-statement	  -using语句
      selection-statement		  -yeild语句
      iteration-statement(标签语句)		  -checked/unchecked语句
      jump-statement			 -lock语句（用于多线程）
      try-statement		     -标签语句
      checked-statement		 -空语句
      unchecked-statement
      locked-statement
      using-statement
      yeild-statement
  ```

  ### 嵌入式语句

  ```csharp
  int score = 90;
  if (score >=60)
      if (score >= 85)
          Console.WriteLine("Best!");
      else
          Console.WriteLine();
  else
      Console.WriteLine("Failed!");
  ```

  ### switch语句
  
  ```csharp
  int score = 100;
  Console.WriteLine(score/10);
  switch (score/10)
  {
      case 10:
          if (score == 100)
          {
              goto case 8;
          }
          else
          {
              goto default;
          }
      case 8:
      case 9:
          Console.WriteLine("A");
          break;  // 必须手动添加break
      case 6:
      case 7:
          Console.WriteLine("B");
          break;
      case 4:
      case 5:
          Console.WriteLine("C");
          break;
      case 0:
      case 1:
      case 2:
      case 3:
          Console.WriteLine("D");
          break;
      default:
          Console.WriteLine("Error");
          break;
  }
  ```
  
  `VStudio`的快捷生成功能：
  
  ```csharp
  Level level = Level.High;
  switch (level) // 输入level，enter自动生成case语句
  {
      case Level.High:
          break;
      case Level.Mid:
          break;
      case Level.Low:
          break;
      default:
          break;
  }
  
  enum Level
  {
      High,
      Mid,
      Low
  }
  ```
  
  
