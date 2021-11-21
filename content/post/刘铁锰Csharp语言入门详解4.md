---
title: "刘铁锰《C#语言入门详解》方法的定义、调用和调试"
subtitle: ""
description: ""
date: 2021-11-21T19:25:26+08:00
author: holy
image: ""
tags: ["Csharp"]
categories: ["Posts" ]
typora-root-url: ..\..\static\images
---

# C#入门详解-刘铁锰  方法的定义、调用和调试

## 本节内容

- 方法的由来
- 方法的定义与调用
- 构造器（一种特殊的方法）
- 方法的重载（Overload）
- 如何对方法进行debug
- 方法的调用与栈*

## 方法的由来

- 方法（method）的前身是C/C++语言的函数（function)

  - 方法是面向对象范畴的规范，在非面向对象语言中仍然称为函数
  - 使用C/C++语言做对比

- 永远都是类（或结构体）的成员

  - C#语言中函数不可能独立于类（或结构体）外
  - 只有作为类（结构体）的成员时才被称为方法
  - C++中是可以的，称为“全局函数”

- 是类（或结构体）最基本的成员之一

  - 最基本的成员只有两个——字段和方法（成员变量和成员方法），本质还是数据+算法
  - 方法表示类（或结构体）“能做什么事情”

- 为什么需要方法和函数？

  - 目的1：隐藏复杂的逻辑

  - 目的2：把大算法分解为小算法

  - 目的3：复用（reuse，重用）

  - 示例：计算圆面积、圆柱面具、圆锥面积

    ```csharp
    using System;
    
    namespace CsharpMethodExample
    {
        internal class Program
        {
            static void Main(string[] args)
            {
                Calculator c = new Calculator();
                Console.WriteLine(c.GetCircleArea(10));
            }
        }
    
        class Calculator
        {
            public double GetCircleArea(double r)
            {
                return Math.PI * r * r;
            }
    
            public double GetCylinderVolume(double r, double h)
            {
                return GetCircleArea(r) * h;
            }
    
            public double GetConeVolume(double r, double h)
            {
                return GetCylinderVolume(r , h) / 3;
            }
        }
    }
    ```

    自顶向下，逐步求精

  ## 方法的声明和调用

  - 声明方法的语法详解

    - 参见C#语言文档（声明/定义不分家）
    - Parameter全称为“formal parameter”形式上的参数，简称“形参”
    - Parameter是一种变量

  - 方法的命名规范

    - 大小写规范
    - 需要以动词或动词短语作为名字

  - 重温静态（Static）方法和实列方法

  - 调用方法

    - Argument中文C#文档的方法译法为“实际参数”，简称“实参”

      可以理解为调用方法时的真实条件

    - 调用方法时的argument列表要与定义方法时的parameter列表相匹配

      - C#是强类型语言，argument是值、parameter是变量，值与变量一定要匹配，不然编译器就会报错

  ## 构造器

  - 构造器（constructor）是类型的成员之一

  - 狭义的构造器指的是"实例构造器"（instance constructor）

    ```csharp
    using System;
    
    namespace ConstructorExample
    {
        internal class Program
        {
            static void Main(string[] args)
            {
                Student stu = new Student(); // ()调用构造器
                Console.WriteLine(stu.ID); // 0 默认构造函数进行初始化（如果没有自定义构造器） 1(有自定义构造器）
                Console.WriteLine(stu.Name); // No name
    
            }
        }
    
        class Student
        {
            public Student() //自定义构造器
            {
                this.ID = 1;
                this.Name = "No name";
            }
            public int ID;
            public string Name;
        }
    }
    ```

  - 如何调用构造器

  - 声明构造器

    有了带参数的构造器，默认的构造器就会失效

    ```csharp
    class Student
    {
        public Student(int initId, string initName) //自定义构造器
        {
            this.ID = initId;
            this.Name = initName;
        }
        public int ID;
        public string Name;
    }
    ```

    声明带参数的构造器，再声明不带参数的构造器，有参数时会使用带参数构造器，没有参数使用不带参数构造器（重载）

    ```csharp
    class Student
    {
        public Student(int initId, string initName) //自定义构造器
        {
            this.ID = initId;
            this.Name = initName;
        }
    
        public Student()
        {
            this.ID = 1;
            this.Name = "No name";
        }
        public int ID;
        public string Name;
    }
    ```

    快速生成构造器代码片段，在类里面

    ```csharp 
    ctor + tab(两次)
    ```

  - 构造器的内存原理

## 方法的重载（Overload)

- 调用重载方法的示例

- 声明带有重载的方法

  - 方法签名（method signature)由方法的名称、类型形参的个数和它的每一个形参（按从左到右的顺序）的类型和种类（值、引用或输出）组成。**方法签名不包含返回类型**

    ```csharp
    class Calculator
    {
        public int Add(int a, int b)
        {
            return a + b;
        }
    
        public int Add(int a, int b, int c)
        {
            return a + b + c;
        }
    
        public double Add(double x, double y)
        {
            return x + y;
        }
    }
    ```

  - 实例构造函数签名由它的每一个形参（按从左往右的顺序）的类型和种类（值、引用或输出）组成

  - 重载决策（到底调用哪一个重载）：用于在给定了参数列表和一组候选函数成员的情况下，选择一个最佳函数成员来实施调用

  ## 如何对方法进行debug

  - 设置断点（breakpoint）
  - 观察方法调用时的call stack
  - Step-in（F11），Step-over（F10），Step-out（Shift+F11）
  - 观察局部变量的值和变化

## 方法的调用与栈

- 方法调用时栈内存的分配

  - 对stack frame的分析

    
