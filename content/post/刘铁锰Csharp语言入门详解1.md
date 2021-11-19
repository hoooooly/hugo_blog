---
title: "刘铁锰《C#语言入门详解》类成员和对象"
subtitle: ""
description: ""
date: 2021-11-19T20:23:26+08:00
author: holy
image: ""
tags: ["C#", "class"]
categories: ["Posts" ]
---


# C#入门详解-刘铁锰 类成员和对象

## 类（class)是现实世界事物的模型

类是对现实世界事物进行抽象所得到的结果
- 事物包括“物质”（实体）与“运动”（逻辑）
- 建模是一个去伪存真、由表及里的过程

## 类与对象的关系

对象也叫实列，是类经过“实例化”后得到的内存中的实体
- Formally "instance" is synonymous with "object" ——对象和实列是一回事
- “飞机”与“一架飞机”有何区别？天上有（一架）飞机——必需是实列飞，概念是不能飞的

依照类，我们可以创建对象，这就是“实例化”
- 现实世界钟常称为“对象”，程序世界中称为“实例”
- 二者并无太大区别，常常混用，初学者不必迷惑

使用new操作符创建类的实例

引用变量与实例的关系
- 孩子与气球
- 气球不一定有孩子牵着
- 多个孩子可以使用各自的绳子牵着同一个气球，也可以都通过一根绳子牵着气球

## 类的三大成员

### 属性(Property)

- 存储数据，组合起来表示类或对象当前的状态

### 方法(Method)

- 由C语言中的函数(function)进化而来，表示类或对象“能做什么”
- 工作中90%的时间是在与方法打交道，因为它是“真正做事”、“构成逻辑”的成员

### 事件(Event)

- 类或对象通知其他类或对象的机制，为C#所特有（Java通过其他办法实现这个机制）
- 善用事件机制非常重要

### 使用MSDN文档

### 某些特殊类或对象在成员方面侧重点不同

- 模型类或对象重在属性，如Enity Framework
- 工具类或对象重在方法，如Math, Console
- 通知类或对象重在事件，如各种Timer

Math工具类

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Threading.Tasks;

namespace ClassAndInstace
{
    internal class Program
    {
        static void Main(string[] args)
        {
            double a = Math.Abs(-123.23);
            Console.WriteLine(a);
            double x = Math.Sqrt(4);
            Console.WriteLine(x); 
            double y = Math.Pow(2, 3);
            Console.WriteLine(y);

        }
    }
}
```

EventSample WPF解决方案

```csharp
//...
using System.Windows.Threading; // 引入多线程命名空间

namespace EventSample
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            // 简易桌面时钟
            DispatcherTimer timer = new DispatcherTimer();
            timer.Interval = TimeSpan.FromSeconds(1);
            timer.Tick += Timer_Tick; // 事件处理器,触发时调用Timer_Tick方法
            timer.Start();
        }

        private void Timer_Tick(object? sender, EventArgs e)
        {
            this.timeTextBox.Text = DateTime.Now.ToString();
        }
    }
}
```

## 静态成员和实列成员

静态(Static)成员在语义上表示它是“类的成员”

实例（非静态）成员在语义表示它是“对象成员”

绑定(Binding)指的是编译器如果把一个成员与类或对象关联起来
- 不可小觑"."操作符——成员访问








