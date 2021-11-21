---
title: "刘铁锰《C#语言入门详解》详解类型、变量与对象"
subtitle: ""
description: ""
date: 2021-11-20T16:21:26+08:00
author: holy
image: ""
tags: ["Csharp"]
categories: ["Posts" ]
typora-root-url: ..\..\static\images
---

# C#入门详解-刘铁锰  详解类型、变量与对象

## 本节内容

- 什么是类型（Type）
- 类型在C#语言中的作用
- C#语言的类型系统
- 变量、对象与内存

## 什么是类型（Type）

- 又名数据类型（Data Type）
  - A data type is a homogeneous collection of values（性质相同值的集合）, effectively presented, equipped with a set of operations which manipulate these values
  - 是数据在内存中存储时的“型号”
  - 小内存容纳大尺寸数据会丢失精度、发生错误
  - 大内存容纳小尺寸数据会造成浪费
  - 编程语言的数据类型与数据的数据类型不完全相同
- 强类型语言与弱类型语言的比较
  - C语言示例：if条件
  - JavaScript示例：动态类型
  - C#语言对弱类型/动态类型的模仿

## 类型在C#语言中的作用

- 一个C#类型中所包含的信息有：
  - 存储此类型变量所需的内存空间大小
  
  - 此类型的值可表示的最大、最小值范围
  
  - 此类型所包含的成员（如方法、属性、事件等）
  
  - 此类型由何基类派生而来
  
    ```csharp
    static void Main(string[] args)
    {
        Type myType = typeof(Form); //查询一个类型具体是什么类型
        PropertyInfo[] pinfos = myType.GetProperties(); // 动态查询这个类型的所有属性
        MethodInfo[] minfos = myType.GetMethods(); //动态查询这个类型的所有方法
        foreach (var p in pinfos)
        {
            Console.WriteLine(p.Name);
        }
        Console.WriteLine(myType); //System.Windows.Forms.Form
        Console.WriteLine(myType.FullName); //System.Windows.Forms.Form
        Console.WriteLine(myType.BaseType); // 查询一个类型的父类 System.Windows.Forms.ContainerControl
    }
    ```
  
  - 此程序运行的时候，此类型的变量在分配在内存的什么位置
    - Stack简介
    
    - Stack overflow
    
      ```csharp
      namespace StackOverflow
      {
          internal class Program
          {
              static void Main(string[] args)
              {
                  BadGuy bg = new BadGuy();
                  bg.BadMethod();
              }
          }
      
          class BadGuy
          {
              public void BadMethod()
              {
                  int x = 100;
                  this.BadMethod();
              }
          }
      }
      ```
    
    - Heap简介
    
    - 使用Performance Monitor查看进程的堆内存使用量
    
      - `win + r` 输入perfmon
    
    - 关于内存泄漏
    
  - 此类型所允许的操作（运算）

 ## C#语言的类型系统

- C#的五大数据类型

  - 类（class）：如Windows， Form， Console， String
  - 结构体（Structures）：如Int32，Int64，Single，Double
  - 枚举（Enumerations）：如HorizontalAlignment， Visibility
  - 接口（Interfaces）
  - 委托（Delegates）

- C#类型的派生谱系

  ![](/image-20211121155842141.png)

## 变量、对象与内存

- 什么是变量?

  - 表面上来看，变量的用途是存储数据

    ```csharp
    int x;
    x = 100;
    ```

  - 实际上，变量表示了存储位置，并且每个变量都有一个类型，以决定什么样的值能够存入变量

  - 变量一共有7种

    - 静态变量、实列变量（成员变量、字段）、数组元素、值参数、引用参数、输出参数、局部参数

  - 侠义的变量是指局部变量，因为其它种类的变量都有自己的约定名称

    - 简单地讲，*局部变量就是方法体（函数体）里声明的变量*

  - 变量的声明

    - `有效的修饰符组合<sub>opt</sub> 类型 变量名 初始化器<sub>opt</sub>`

  - 值类型的变量

    - 以byte/sbyte/short/ushort为例
    - 值类型没有实例，所谓的“实例”与变量合而为一

  - 引用类型的变量与实列

    - 引用类型变量与实例的关系：引用类型变量里存储的数据是对象的内存地址

  - 变量的默认值

    - 成员变量有默认值

      ```csharp
      using System;
      
      namespace TypeInCsharp
      {
          internal class Program
          {
              static void Main(string[] args)
              {
                  Student stu = new Student();
                  Console.WriteLine(stu.ID); // 0
                  Console.WriteLine(stu.Sccore); // 0
      
              }
          }
      
          class Student
          {
              public uint ID;
              public ushort Sccore;
          }
      }
      
      ```

    - 本地变量没有默认值

  - 常量（值不可改变的变量）

    - 初始化时必须赋值

  - 装箱与拆箱（Boxing & Unboxing)

    ```csharp
    static void Main(string[] args)
    {
        int x = 100;
        object obj = x; // 装箱
        // obj是引用类型，int是值类型
        int y = (int)obj; // 拆箱
        Console.WriteLine(y);  
    }
    ```

**变量**

> 以变量名所对应的内存地址为起点、以其数据类型所要求的存储空间为长度的一块内存区域

计算机是以字节为基本单元存储数据的

