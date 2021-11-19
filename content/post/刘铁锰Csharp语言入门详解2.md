---
title: "刘铁锰《C#语言入门详解》基本元素概览 类型"
subtitle: ""
description: ""
date: 2021-11-19T22:21:26+08:00
author: holy
image: ""
tags: ["C#"]
categories: ["Posts" ]
---


# C#入门详解-刘铁锰 基本元素概览 类型

## 本节内容

- 构成C#语言的基本元素
    - 关键字（Keyword）
    - 操作符（Operator）
    - 标识符（Identifier）
    - 标点符号
    - 文本
    - 注释与空白
- 简要介绍类型、变量与方法
- 算法简介

## 构成C#语言的基本元素

- 关键字（Keyword）
- 操作符（Operator）
- 标识符（Identifier）
    - 什么是合法的标识符？
        - 怎样阅读语言定义文档？
    - 大小写规范
    - 命名规范
- 标点符号
- 文本（字面值）
    - 整数
        - 多种后缀
    - 实数
    - 字符
    - 字符串
    - 布尔
    - 空（null)
- 注释与空白
    - 单行
    - 多行（块注释）

```csharp
int x = 2;   // 短整型
long y = 3L;    // 长整型
float z = 3.0F;     // 单精度浮点型
double h = 3.00;    // 双精度浮点型
char c = 'a';   // 字符型
string s = "a";     // 字符串型
bool b = true;      // 布尔型
string n = null;      // null型
```

注释

```csharp
// 单行注释

/*
块注释
*/
```

## 初识类型、变量和方法

- 初始类型（Type）
    - 亦称数据类型（Data Type）

- 变量是存放数据的地方，简称“数据”
    - 变量的声明
    - 变量的使用
- 方法（旧称函数）是处理数据的逻辑，又称为“算法”
    - 方法的声明
    - 方法的调用
- 程序=数据+算法
    - 有了变量和方法就可以写有意义的程序了

演示代码：

```csharp
using System;

namespace IdentifierExample
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int x = 2;   // 短整型
            long y = 3L;    // 长整型
            float z = 3.0F;     // 单精度浮点型
            double h = 3.00;    // 双精度浮点型
            char c = 'a';   // 字符型
            string s = "a";     // 字符串型
            bool b = true;      // 布尔型
            string n = null;      // null型

            Calculator cal = new Calculator();
            int res = cal.Add(2, 3);
            Console.WriteLine(res);  // 5
            string day = cal.Today();
            Console.WriteLine(day);
        }
    }

    class Calculator // 定义一个Calculator类
    {
        // 有数据输入，有数据输出
        public int Add(int a, int b)   // 定义一个公开的Add方法
        {
            return a + b;
        }

        // 没有数据输入，有数据输出
        public string Today()
        {
            int day = DateTime.Now.Day;
            return day.ToString();
        }

        // 没有数据输入，没有数据输出
        public void PrintSum(int a, int b)  // 没有返回值
        {
            int result = a + b;
            Console.WriteLine(result);
        }
    }
}
```

## 算法简介

- 循环初体验
- 递归初体验
- 计算1到100的和

```csharp
using System;

namespace MyExample
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Calculator c = new Calculator();
            // c.PrintTo1(10);
            c.PrintTo2(10);
            int res = c.SumFrom1ToX1(10);
            Console.WriteLine(res);  // res=55
            res = c.SumFrom1ToX2(100);
            Console.WriteLine(res); // 5050
        }
    }

    class Calculator
    {
        public void PrintTo1(int x) // for循环实现
        {
            for (int i = x; i > 0; i--)
            {
                Console.WriteLine(i);
            }
        }

        public void PrintTo2(int x) // 递归实现
        {
            if (x==1)
            {
                Console.WriteLine(x);
            }
            else
            {
                Console.WriteLine(x);
                PrintTo2(x - 1);
            }
        }

        // 演示，实际开发不要这样命名函数
        public int SumFrom1ToX1(int x) // for循环实现求和
        {
            int res = 0;
            for (int i = 1; i < x+1; i++)
            {
                res = res + i;
            }
            return res;
        }
        public int SumFrom1ToX2(int x)  // 递归实现求和
        { 
            if (x==1)
            {
                return 1;
            }
            else
            {
                int res = x + SumFrom1ToX2(x - 1);
                return res;
            }
        }
    }
}
```







