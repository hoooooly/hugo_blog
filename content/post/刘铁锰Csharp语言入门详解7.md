---
title: "刘铁锰《C#语言入门详解》 字段、属性、索引器和常量 "
subtitle: ""
description: ""
date: 2021-11-27T02:03:26+08:00
author: holy
image: ""
tags: ["Csharp"]
categories: ["Posts" ]
typora-root-url: ..\..\static\images
---

# C#入门详解-刘铁锰  字段、属性、索引器和常量 

## 字段

- 什么是字段？
  - 字段（field）是一种表示与对象或类型（类与结构体）关联的变量
  
  - 字段是类型的成员，旧称`“成员变量”`
  
  - 与对象关联的字段亦称为“实例字段”
  
  - 与类型关联的字段称为“静态字段”，由`static`修饰
  
    ```csharp
    using System;
    
    namespace DataMember
    {
        internal class Program
        {
            static void Main(string[] args)
            {
                List<Student> stuList = new List<Student>();
                for (int i = 0; i < 100; i++)
                {
                    Student stu = new Student(); //实例化100次
                    stu.Age = 24;
                    stu.Score = i;
                    stuList.Add(stu);
                }
    
                int totalAge = 0;
                int totalScore = 0;
                foreach (var stu in stuList)
                {
                    totalAge += stu.Age;
                    totalScore += stu.Score;
                }
    
                Student.AverageAge = totalAge / Student.Amount;
                Student.AverageScore = totalScore / Student.Amount;
    
    
                Student.ReportAmount(); //调用静态方法,100
                Student.ReportAverageAge(); //24
                Student.ReportAverageScore();//49
    
            }
        }
    
        class Student
        {
            public int Age;  //实列字段
            public int Score;
    
            public static int AverageAge; //静态字段
            public static int AverageScore;
            public static int Amount;
    
            public Student() // 构造方法
            {
                Student.Amount++; //没次创造实例Amount+1
            }
    
            public static void ReportAmount()
            {
                Console.WriteLine(Student.Amount);
            }
    
            public static void ReportAverageAge()
            {
                Console.WriteLine(Student.AverageAge);
            }
    
            public static void ReportAverageScore()
            {
                Console.WriteLine(Student.AverageScore);
            }
    
        }
    }
    ```
  
- 字段的声明
  - 参见C#语言定义文档
  - 尽管字段声明带有分号，但它不是语句
  - 字段的名字一定是动词
  
- 字段的初始值
  - 无显式初始化时，字段获得其类型的默认值，所以字段“永远都不会未被初始化”
  
  - 实例字段初始化的时机——对象创建时
  
  - 静态字段初始化的时机——类型被加载时（load）时
  
    > 静态构造器只会执行一次
  
- 只读字段
  - 实例只读字段
  - 静态只读字段

## 属性

- 什么是属性？

  - 属性（property）是一种用于`访问对象或类型的特征`的成员，`特征反映了状态`

  - 属性是字段的自然扩展

    - 从命名上看，field更偏向于实例对象在内存中的布局，proerty更偏向于反映现实世界对象的特征
    - 对外：暴露数据，数据可以被存储在字段里，也可以是动态计算出来的
    - 对内：保护字段不被非法值“污染”

    ```csharp
    using System;
    
    namespace PropertyExample
    {
        internal class Program
        {
            static void Main(string[] args)
            {
                try
                {
                    Student stu1 = new Student();
                    stu1.SetAge(20);
    
                    Student stu2 = new Student();
                    stu2.SetAge(20);
    
                    Student stu3 = new Student();
                    stu3.SetAge(20);
    
                    int avgAge = (stu1.GetAge() + stu2.GetAge() + stu3.GetAge()) / 3;
                    Console.WriteLine(avgAge);
                }
                catch (Exception ex)
                {
    
                    Console.WriteLine(ex.Message); ;
                }
            }
        }
    
        class Student
        {
            private int age;
    
            /// <summary>
            /// 访问字段age方法
            /// </summary>
            /// <returns></returns>
            public int GetAge()
            {
                return this.age;
            }
    
            /// <summary>
            /// 设置字段age方法，添加逻辑保护内部字段不受污染
            /// </summary>
            /// <param name="value">年龄</param>
            public void SetAge(int value)
            {
                if (value >= 0 && value <= 120)
                {
                    this.age = value;
                }
                else
                {
                    throw new Exception("Age value has error.");
                }
            }
        }
    }
    ```

  - 属性由`Get/Set`方法对进化而来

    ```csharp
    private int age;
    public int Age
    {
        get { return this.age; }
        set
        {
            if (value >= 0 && value <= 120)
            {
                this.age = value;
            }
            else
            {
                throw new Exception("Age value has error.");
            }
        }
    }
    ```

  - 又一个“语法糖”——属性背后的秘密

- 属性的声明

  - 完整声明——后台（back）成员变量与访问器

    ```csharp
    // propfull + 双击Tab
    private int myVar;
    
    public int MyProperty
    {
        get { return myVar; }
        set { myVar = value; }
    }
    ```

  - 简略申明——只有访问器（查看IL代码）

    ```csharp
    // prop + 双击Tab
    public int MyProperty { get; set; }
    ```

  - 动态计算值的属性

    ```csharp
    using System;
    
    namespace Property1Example
    {
        internal class Program
        {
            static void Main(string[] args)
            {
                Student student = new Student();
                student.Age = 12;
                Console.WriteLine(student.CanWork);
            }
        }
    
        class Student
        {
            private int age;
    
            public int Age
            {
                get { return age; }
                set { 
                    age = value;
                    this.CalcumateCanWork();
                }
            }
    
            private bool canWork;
    
            public bool CanWork
            {
                get { return canWork; }
                set { canWork = value; }
            }
    
    
            private void CalcumateCanWork()
            {
                if (this.age>=16)
                {
                    this.canWork = true;
                }else
                {
                    this.canWork = false;
                }
            }
        }
    }
    ```

  - 注意实例属性和静态属性

  - 属性的名字一定是名词

  - 只读属性——只有`getter`没有`setter`
    - 几乎没有使用“只写属性”，属性的主要目的就是通过向外暴露数据

- 属性与字段的关系

  - 一般情况下，他们都表示实体（对象或类型）的状态
  - 属性大多数情况下是字段的包装器（wrapper）
  - 建议：永远使用属性（而不是字段）来暴露数据，及字段永远都是`private`或`protected`的

### 索引器

```csharp
using System;
using System.Collections.Generic;

namespace Property2Example
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Student stu = new Student();
            stu["Math"] = 90;
            stu["Math"] = 100;
            var mathScore = stu["Math"];
            Console.WriteLine(mathScore);
        }
    }

    class Student
    {
        private Dictionary<string, int> scoreDictionary = new Dictionary<string, int>();

        public int? this[string subject] //声明索引器
        {
            get { /* return the specified index here */
                if (this.scoreDictionary.ContainsKey(subject))
                {
                    return this.scoreDictionary[subject];
                }
                else
                {
                    return null;
                }
            }
            set { /* set the specified index to value here */

                // null异常处理
                if (value.HasValue==false)
                {
                    throw new Exception("Score cannot be null");
                }
                if (this.scoreDictionary.ContainsKey(subject))
                {
                    this.scoreDictionary[subject] = value.Value;
                }
                else
                {
                    this.scoreDictionary.Add(subject, value.Value);
                }
            }
        }
    }
}
```

## 常量

- 什么是常量

  - 常量（constant）是表示常量（即，可以在编译时计算的值）的类成员
  - 常量隶属于类型而不是对象，即没有“实例常量”
    - “实例常量”的角色由只读实例字段来担当
  - 注意区分成员常量与局部常量

- 常量的声明

- 各种“只读”的应用场景

  - 为了提高程序可读性和执行效率——常量
  - 为了防止对象的值被改变——只读字段
  - 向外暴露不允许修改的数据——只读属性（静态或非静态），功能和常量有一些重叠
  - 当希望成为常量的值其类型不能被常量声明接收时（类/自定义结构体）——静态只读字段

  
