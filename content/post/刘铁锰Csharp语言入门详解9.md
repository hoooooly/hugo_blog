---
title: "刘铁锰《C#语言入门详解》 委托详解"
subtitle: ""
description: ""
date: 2021-11-28T18:37:26+08:00
author: holy
image: ""
tags: ["Csharp"]
categories: ["Posts" ]
typora-root-url: ..\..\static
---

# C#入门详解-刘铁锰  委托详解

## 本节内容

- 什么是委托？
- 委托的声明（自定义委托）
- 委托的使用

## 什么是委托？

- 委托（delegate）是函数指针的“升级版”
  - 实例：C/C++中的函数指针
- 一切皆地址
  - 变量（数据）是以某个地址为起点的一段内存中所存储的值
  - 函数（算法）是以某个地址为起点的一段内存中所存储的一组机器语言指令
- 直接调用与间接调用
  - 直接调用：通过函数名来调用函数，CPU通过函数名直接获得函数所在地址并开始执行->返回
  - 间接调用：通过函数指针来调用函数，CPU通过读取函数指针存储的值来获得函数所在地址并开始执行->返回
- Java中没有与委托相对应的功能实体
- 委托的简单使用
  - Action委托
  - Func委托

```csharp
using System;

namespace DelegateExample
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Calculator calculator = new Calculator();
            Action action = new Action(calculator.Report); // action委托
            calculator.Report(); // 直接调用
            action.Invoke(); // 间接调用
            action(); // 简便写法

            Func<int, int, int> func1 = new Func<int, int, int>(calculator.Add); //Func委托
            Func<int, int, int> func2 = new Func<int, int, int>(calculator.Sub);

            int x = 100;
            int y = 200;
            int z = 0;
            z = func1.Invoke(x, y);
            Console.WriteLine(z); // 300
            z = func2.Invoke(x, y);
            Console.WriteLine(z); // -100
            

        }
    }

    class Calculator
    {
        public void Report()
        {
            Console.WriteLine("I have 3 methods.");
        }

        public int Add(int a, int b)
        {
            return a + b;
        }

        public int Sub(int a, int b)
        {
            return a - b;
        }
    }
}
```

## 委托的声明（自定义委托）

- 委托是一种类（class），类是数据类型所以委托也是一种数据类型

  ```csharp
  Type t = typeof(Action);
  Console.WriteLine(t.IsClass); // True
  ```

- 它的声明方式与一般的类不同，主要是为了照顾可读性和C/C++传统

- 注意声明委托的位置

  - 避免写错地方结果声明嵌套类型

- 委托与所封装的方法必需“类型兼容”

  ```csharp
  delegate double Calc(double x, double y):
  		double Add(double x, double y){return x + y;}
  		double Sub(double x, double y){return x - y;}
  		double Mul(double x, double y){return x * y;}
  		double Div(double x, double y){return x / y;}
  ```

   - 返回值的数据类型一致

   - 返回列表在个数和数据类型上一致（参数名不需要一样）

```csharp
using System;

namespace Delegate1Example
{
    internal class Program
    {
        // 自定义委托
        public delegate double Calc(double x, double y);
        static void Main(string[] args)
        {
            Type t = typeof(Action);
            Console.WriteLine(t.IsClass); // True

            Calculator calculator = new Calculator();
            Calc calc1 = new Calc(calculator.Add);
            Calc calc2 = new Calc(calculator.Sub);
            Calc calc3 = new Calc(calculator.Mul);
            Calc calc4 = new Calc(calculator.Div);

            double a = 100;
            double b = 200;
            double c = 0;

            c = calc1.Invoke(a, b);
            Console.WriteLine(c);
            c = calc2.Invoke(a, b);
            Console.WriteLine(c);
            c = calc3.Invoke(a, b);
            Console.WriteLine(c);
            c = calc4.Invoke(a, b);
            Console.WriteLine(c);
        }
    }
    class Calculator
    {
        public double Add(double x, double y)
        {
            return x + y;
        }
        public double Sub(double x, double y)
        {
            return x - y;
        }
        public double Mul(double x, double y)
        {
            return x * y;
        }
        public double Div(double x, double y)
        {
            return x / y;
        }
    }
}
```

## 委托的一般使用

- 实例：把方法当作参数传给另一个方法
  - 正确使用1：模板方法，“借用”指定的外部方法来产生结果
    - 相当于“填空题”
    - 常位于代码中部
    - 委托有返回值
  - 正确使用2：回调（**callback**）方法，调用指定的外部方法
    - 相当于“流水线”
    - 常位于代码末尾
    - 委托无返回值
- 注意：难精通+易使用+功能强大的东西，一旦被滥用则后果非常严重
  - 缺点1：这是一种方法级别的紧耦合，现实工作中要慎之又慎
  - 缺点2：使可读性下降、debug的难度增加
  - 缺点3：把委托回调、异步调用和多线程纠缠在一起，会让代码变得难以阅读和维护
  - 缺点4：委托使用不当有可能造成内存泄漏和程序性能下降



