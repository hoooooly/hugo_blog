---
title: "刘铁锰《C#语言入门详解》基本元素概览 类型"
subtitle: ""
description: ""
date: 2021-11-19T22:21:26+08:00
author: holy
image: ""
tags: ["Csharp"]
categories: ["Posts" ]
typora-root-url: ..\..\static
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

## 汉诺塔问题

[参考博文地址]([(156条消息) C#中的递归以及解决汉诺塔问题_柠檬i的博客-CSDN博客_c#汉诺塔问题递归算法](https://blog.csdn.net/weixin_49125123/article/details/112827223))

汉诺塔由法国数学家爱德华·卢卡斯创造，他曾经编写了一个印度的古老传说：

> 在世界中心贝拿勒斯（在印度北部）的圣庙里，一块黄铜板上插着三根宝石针。印度教的主神梵天在创造世界的时候，在其中一根针上从下到上地穿好了由大到小的64片金片，这就是所谓的汉诺塔。不论白天黑夜，总有一个僧侣在按照下面的法则移动这些金片：一次只移动一片，不管在哪根针上，小片必须在大片上面。僧侣们预言，当所有的金片都从梵天穿好的那根针上移到另外一根针上时，世界就将在一声霹雳中消灭，而梵塔、庙宇和众生也都将同归于尽。

### 怎么解决汉诺塔问题？

要完成四层汉诺塔，需要先把第四层盘子从A柱放到C柱，而要把第四层盘子放到C柱，就要把上面三层的盘子放到B柱：

![img](/images/hannuota.png)

那么要把这三层盘子移到B柱，那么就要先把第三层盘子移到B柱。
要把第三层盘子移到B柱，就要把第二层盘子移到C柱子。
要把第二层盘子移到C柱，就要把第一层盘子移到B柱子。
移动一层汉诺塔到另一个柱不简单吗？
这样子把问题解决了，第四层盘子就可以移动到C柱上了。
然后把剩下的三层汉诺塔也按照上面的思想，就可以移动到C柱上了。

### 具体代码实现

把大象装进冰箱需要多少步

1. 把冰箱门打开
2. 把大象放进去
3. 把冰箱门关上

把汉诺塔放到C柱需要多少步？

1. 把底层上面的盘子放到B柱

2. 把最底层盘子放到C柱

3. 把B柱那些盘子放到C柱

抽象一下就是：

1. 把n-1层盘子从起点移到暂存区

2. 然后把第n层盘子从起点移到终点

3. 然后把n-1层盘子从暂存区移到终点

在这里可以创建一个Move方法来移动盘子

```csharp
static void Move(int pile, char src, char tmp, char dst)
{

}
```

`src`就是源起点，`tmp`就是暂存区，`dst`就是终点

最外层的`Move`方法完成的是把`pile`层汉诺塔从`src`经过`tmp`移动到`dst`

**现在要把大象装进冰箱了**

在`Move`方法里面调用`Move`方法来解决之后的问题：

1. 把冰箱门打开

  ```csharp
  Move(pile - 1, src, dst, tmp);
  ```


  这层`Move`完成的是把`pile-1`层汉诺塔从`src`经过`dst`移动到`tmp`

2. 把大象塞进去	

   ```csharp
   Move(1, src, tmp, dst);
   ```


   这层`Move`完成的是把最底层汉诺塔盘子从`src`直接移动到`dst`

3. 把门关上

   ```csharp
   Move(pile - 1, tmp, src, dst);
   ```


   这层`Move`完成的是把`pile-1`层汉诺塔从`tmp`经过`src`移动到`dst`

`Move`方法完整代码：

```csharp
static void Move(int pile, char src, char tmp, char dst)
{
    if (pile ==1)
    {
        Console.WriteLine($"{src}-->{dst}");
        steps++;
        return;
    }
    Move(pile - 1, src, dst, tmp);
    Move(1, src, tmp, dst);
    Move(pile-1, tmp, src, dst);
}
```

每一层`Move`方法都有他自己的起点、暂存区和终点，我们只需要把上一层的起点、暂存区和终点传过去就行了。

### 完整代码

```csharp
using System;

namespace Hannuota
{
    internal class Program
    {
        public const int Max_VALUE = 30; //声明最大层数
        public static int steps = 0;
        static void Main(string[] args)
        {
            int levels;
            Console.WriteLine($"输入汉诺塔层数（1-{Max_VALUE}）:");
            levels = int.Parse(Console.ReadLine());
            if (levels > 0 && levels < Max_VALUE)
            {
                Move(levels, 'A', 'B', 'C');
                Console.WriteLine($"一共移动了{Program.steps}次。");
                Console.ReadKey();
                return;
            }
            Console.WriteLine("输入范围有误");
            Console.ReadKey();
        }

        static void Move(int pile, char src, char tmp, char dst)
        {
            if (pile ==1)
            {
                Console.WriteLine($"{src}-->{dst}");
                steps++;
                return;
            }
            Move(pile - 1, src, dst, tmp);
            Move(1, src, tmp, dst);
            Move(pile-1, tmp, src, dst);
        }
    }
}
```

运行结果：

![image-20211120135027277](/images/image-20211120135027277.png)
