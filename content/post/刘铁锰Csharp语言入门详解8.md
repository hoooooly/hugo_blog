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

**传值参数->引用类型，并且创建新对象**

![](/images/image-20211127153341281.png)

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

**传值参数->引用类型，只操作对象，并不创建新对象**

![](/images/image-20211127162527935.png)

> 注意：
>
> 对象还是那个对象，值被修改了

## 引用参数

**引用参数->值类型**

![](/images/image-20211128145202703.png)

```csharp
internal class Program
{
    static void Main(string[] args)
    {
        int y = 1;
        iWantSideEffect(ref y);
        Console.WriteLine(y); // 101, y的值也被改变了
    }

    static void iWantSideEffect(ref int x)
    {
        x = x + 100;
    }
}
```

**引用参数->引用类型，创建新对象**

![](/images/image-20211128150819986.png)

> 注意：
>
> - 引用参数并不创建变量的副本
> - 使用ref修饰符显式指出——此方法的副作用是改变实际参数的值

```csharp
using System;

namespace Paramters2Example
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Student outterStu = new Student() { Name="Tim"};
            Console.WriteLine("HashCode={0}, Name={1}", outterStu.GetHashCode(), outterStu.Name);
            Console.WriteLine("---------------------------------------------------");
            iWantEffect(ref outterStu);
            Console.WriteLine("HashCode={0}, Name={1}", outterStu.GetHashCode(), outterStu.Name); // 引用类型的引用参数

        }

        static void iWantEffect(ref Student stu)
        {
            stu = new Student() { Name = "Tom" };
            Console.WriteLine("HashCode={0}, Name={1}", stu.GetHashCode(),stu.Name);
        }
    }

    class Student
    {
        public string Name { get; set; }
    }
}

```

输出结果：

```csharp
HashCode=46104728, Name=Tim
---------------------------------------------------
HashCode=12289376, Name=Tom
HashCode=12289376, Name=Tom
```

## 输出参数

用out修饰符声明的形参是输出参数。输出形参不创建新的存储位置。变量在可以作为输出参数传递之前不一定需要明确赋值。

在方法返回之前，该方法的每个输出形参都必须明确赋值。

**输出参数->值类型**

![](/images/image-20211128152539141.png)

> 注意：
>
> - 输出参数并不创建变量的副本
> - 方法体必需要有对输出变量的赋值的操作
> - 使用out修饰符显式指出——此方法的副作用是通过参数向外输出值
> - 从语义上来讲——ref是为了”改变“，out是为了”输出“

```csh
using System;

namespace Parameter3Example
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Please input first number:");
            string arg1 = Console.ReadLine();
            double x = 0;
            bool b1 = double.TryParse(arg1, out x);
            if (!b1)
            {
                Console.WriteLine("input error");
                return;
            }
         

            Console.WriteLine("Please input first number:");
            string arg2 = Console.ReadLine();
            double y = 0;
            bool b2 = double.TryParse(arg2, out y);
            if (!b2)
            {
                Console.WriteLine("input error");
                return;
            }

            double z = x + y;
            Console.WriteLine(z);
        }
    }
}
```

**输出参数->引用类型**

![](/images/image-20211128160147831.png)

```csh
using System;

namespace Paramter5Example
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Student stu = new Student();
            bool b = StudentFactory.Create("Tom", 34, out stu);
            if (b)
            {
                Console.WriteLine("Student {0}, age is {1}.", stu.Name, stu.Age);
            }
        }
    }

    class Student
    {
        public int Age { get; set; }
        public string Name { get; set; }
    }

    /// <summary>
    /// 制造学生类的实例
    /// </summary>
    class StudentFactory
    {
        public static bool Create(string stuName, int stuAge, out Student result)
        {
            result = null;
            if (string.IsNullOrEmpty(stuName))
            {
                return false;
            }
            else if (stuAge<20 || stuAge>80)
            {
                return false;
            }

            result = new Student() { Name = stuName, Age = stuAge };
            return true;
        }
    }
}
```

## 数组参数

- 必需是形参列表中的最后一个，由`params`修饰
- 举例：`String.Format`方法和`String.Split`方法

```csharp
using System;

namespace ParamsParrmtersExample
{
    internal class Program
    {
        static void Main(string[] args)
        {
            // 数组参数
            // int[] myintArray = new int[] { 1, 2, 3 };
            int result = CalculateSum(1,2,3); // 直接输入数组
            Console.WriteLine(result);
            int x = 100;
            int y = 200;
            int z = x+y;
            Console.WriteLine("{0} + {1} = {2}", x, y, z);


            string str = "Tom:Tim:Amy,Lis";
            string[] a = str.Split(':', ',');
            foreach (var item in a)
            {
                Console.WriteLine(item);
            }
        }

        static int CalculateSum(params int[] intArray)
        {
            int sum = 0;
            foreach (var item in intArray)
            {
                sum += item;
            }
            return sum;
        }
    }
}
```

## 具名参数

- 参数的位置不再受约束

  ```csharp
  using System;
  
  namespace Paramter6Example
  {
      internal class Program
      {
          static void Main(string[] args)
          {
              Println(age: 18, name: "Holy");
          }
  
          static void Println(string name, int age)
          {
              Console.WriteLine("{0}'s age is {1}.", name, age); //Holy's age is 18.
          }
      }
  }
  ```

  

## 可选参数

- 参数因为具有默认值而变得”可选“
- 不推荐使用可选参数

```csharp
using System;

namespace Paramter6Example
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Println(name: "Holy");
        }

        static void Println(string name, int age = 88)
        {
            Console.WriteLine("{0}'s age is {1}.", name, age); //Holy's age is 88.
        }
    }
}
```

## 扩展方法（this参数）

- 方法必须是公有的、静态的，即被public static所修饰
- 必须是形参列表中的第一个，由this修饰
- 必需有一个静态类（一般类名为SomeTypeExtension）来同意收纳对SomeType类型的扩展方法
- 举例：LINQ方法

```csharp
using System;

namespace ThisMethodExample
{
    internal class Program
    {
        static void Main(string[] args)
        {
            double x = 3.14159;
            // double y = Math.Round(x, 4); // 3.1416
            double y = x.Round(4);
            Console.WriteLine(y); // 3.1416
        }
    }

    static class DoubleExtension
    {
        // 使用扩展方法实现double的Round方法
        public static double Round(this double input, int digits)
        {
            double result = Math.Round(input, digits);
            return result;
        }
    }
}
```

LINQ实列：

```csharp
using System;
using System.Collections.Generic;
using System.Linq;

namespace LINQStartExample
{
    internal class Program
    {
        static void Main(string[] args)
        {
            /*List<int> myList = new List<int>() { 11, 12, 13, 14, 15 };
            bool result = AllGreaterThanTen(myList);
            Console.WriteLine(result);*/
            List<int> myList = new List<int>() { 11, 12, 13, 14, 15 };
            bool result = myList.All(i => i > 10);  // All是扩展方法
            Console.WriteLine(result);
        }
        static bool AllGreaterThanTen(List<int> intList)
        {
            foreach (var item in intList)
            {
                if (item<=10)
                {
                    return false;
                }
            }
            return true;
        }
    }
}
```

## 各种参数的使用场景总结

- 传值参数：参数的默认传递方式
- 输出参数：用于除返回值外还需要输出的场景
- 引用参数：用于需要修改实际参数值的场景
- 数组参数：用于简化方法的调用
- 具名参数：提高可读性
- 可选参数：参数拥有默认值
- 扩展方法（this参数）：为目标数据类型"追加"方法
