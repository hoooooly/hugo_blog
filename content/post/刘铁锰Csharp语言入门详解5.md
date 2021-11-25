---
title: "刘铁锰《C#语言入门详解》 操作符详解"
subtitle: ""
description: ""
date: 2021-11-22T00:35:26+08:00
author: holy
image: ""
tags: ["Csharp"]
categories: ["Posts" ]
typora-root-url: ..\..\static\images
---

# C#入门详解-刘铁锰  操作符详解

## 本节内容

- 操作符概览
- 操作符的本质
- 操作符的优先级
- 同级操作符的运算顺序
- 各类操作符的示例

## 操作符概览

| 类别               | 运算符                                                       |
| :----------------- | ------------------------------------------------------------ |
| 基本               | `x.y f(x) a[x] x++ x-- new typeof default checked unchecked delegate sizeof ->` |
| 一元               | `+ - ! ~ ++x --x (T)x await &x *x`                           |
| 乘法               | `* / %`                                                      |
| 加减               | `+ -`                                                        |
| 移位               | `<< >>`                                                      |
| 关系和类型检测     | `< > <= >= is as`                                            |
| 相等               | `==  !=`                                                     |
| 逻辑“与”           | `&`                                                          |
| 逻辑 XOR           | `^`                                                          |
| 逻辑 OR            | `|`                                                          |
| 条件 AND           | `&&`                                                         |
| 条件 OR            | `||`                                                         |
| null 合并          | `??`                                                         |
| 条件               | `?:`                                                         |
| 赋值和lambda表达式 | `= *= /= %= += -= <<= >>= &= ^= \|= \>`                      |

- 操作符（Operator）也译为“运算符”

- 操作符是用来操作数据的，被操作符操作的数据称为操作数（Operand）

  > 注：表中越上的的操作符优先级越高

## 操作符的本质

- 操作符的本质是函数（即算法）的“简记法”

  - 假如没有发明“+”、只有`Add`函数，算式`3+4+5`将可以写成`Add(Add(3,4),5)`
  - 假如没有发明“x”、只有`Mul`函数，算式`3+4+5`将可以写成`Add(3, Mul(3,4))`，注意优先级

- 操作符不能脱离与它关联的数据类型

  - 可以说操作符就是与固定数据类型相关联的一套基本算法的简记法

    ```csharp
    using System;
    using System.Collections.Generic;
    
    namespace CreateOperator
    {
        internal class Program
        {
            static void Main(string[] args)
            {
                Person person1 = new Person();
                Person person2 = new Person();
                person1.Name = "Deer";
                person2.Name = "Dear's wife";
                List<Person> nation = Person.GerMarry(person2, person2);
                foreach (var p in nation)
                {
                    Console.WriteLine(p.Name);
                }
            }
        }
    
        class Person
        {
            public string Name;
            public static List<Person> GerMarry(Person p1, Person p2)
            {
                List<Person> people = new List<Person>();
                people.Add(p1);
                people.Add(p2);
                for (int i = 0; i < 11; i++)
                {
                    Person child = new Person();
                    child.Name = p1.Name + "&" + p2.Name + "s child";
                    people.Add(child);
                }
                return people;
            }
        }
    }
    ```

    

  - 示例：为自定义数据类型创建操作符

    ```csharp
    using System;
    
    namespace CreateOperator
    {
        internal class Program
        {
            static void Main(string[] args)
            {
                int x = 5;
                int y = 4;
                int z = x / y;
                Console.WriteLine(z); // 1
    
                double a = 5.0;
                double b = 4.0;
                double c = a / b;
                Console.WriteLine(c); // 1.25
            }
        }
    }
    ```

  ## 优先级与运算顺序

  - 操作符的优先级

    - 可以使用圆括号提高被括起来表达式的优先级
    - 圆括号可以嵌套
    - 不像数学里面有方括号和花括号，在C#语言里“[]”与“{}”有专门的用途

  - 同优先级操作符的运算顺序

    - 除了带有赋值功能的操作符，同优先级操作符都是由左向右进行运算

      ```csharp
      int x = 100;
      int y = 200;
      int z = 300;
      x += y += z;
      Console.WriteLine(x); // 600
      Console.WriteLine(y); // 500
      Console.WriteLine(z); // 300
      ```

    - 带有赋值功能的操作符的运行顺序是由右向左

    - 与数学运算不同，计算机语言的同优先级运算没有“结合率”

      - `3+4+5`只能理解为`Add(Add(3,4),5)`不能理解为`Add(3,Add(4,5))`
    
    ```csharp
    using System;
    using System.Collections.Generic;
    using System.Windows.Forms;
    
    namespace OperatorsExample
    {
        internal class Program
        {
            static void Main(string[] args)
            {
                Calculator c = new Calculator();
                /* double v = c.Add(1.0, 23.00);
                 Console.WriteLine(v);*/
                Action myAction = new Action(c.PrintHello);
                myAction();
    
                int[] myIntArray = new int[] {1,2,3,4,5 };  //数组实列
                Console.WriteLine(myIntArray[0]);
                Console.WriteLine(myIntArray[myIntArray.Length -1]);
    
                Dictionary<string, Student> stuDic = new Dictionary<string, Student>();
                for (int i = 0;  i<=100; i++)
                {
                    Student stu = new Student();
                    stu.Name = "S_" + i.ToString();
                    stu.Score = 100;
                    stuDic.Add(stu.Name, stu);
                }
    
                Student number6 = stuDic["S_6"];
                Console.WriteLine(number6.Name, number6.Score); // 元素访问操作符
    
    
                int x = 100;
                int y = x++; // 先赋值，后执行操作
                Console.WriteLine(x); // 101
                Console.WriteLine(y); // 100
    
                // Metadata
                Type t = typeof(int);
                Console.WriteLine(t.Namespace);
                Console.WriteLine(t.FullName);
                Console.WriteLine(t.Name);
                int n = t.GetMethods().Length;
                foreach (var m in t.GetMethods())
                {
                    Console.WriteLine(m.Name);
                }
                Console.WriteLine(n);
    
                int I = default(int);
                Console.WriteLine(I);  // 0
    
                Form myForm = default(Form);
                Console.WriteLine(myForm==null); // true
    
                // 枚举类型
                Level level = default(Level);
                Console.WriteLine(level); // Low
            }
        }
    
        enum Level
        {
            Mid = 2,
            Low = 1,
            High = 3
        }
    
        class Student
        {
            public string Name;
            public int Score;
        }
    
        class Calculator
        {
            public double Add(double a, double b)
            {
                return a + b;
            }
    
            public void PrintHello()
            {
                Console.WriteLine("Hello");
            }
        }
    }

## 类型转换

- 隐式（implict）类型转换

  - 不丢失精度的转换

    ```csharp
    int x = int.MaxValue;
    Console.WriteLine(x);
    long y = x;
    Console.WriteLine(y);
    ```

  - 子类向父类的转换

    ```csharp
    internal class Program
    {
        static void Main(string[] args)
        {
            Teacher t = new Teacher();
            Human h = t;
            Animal a = h;
            a.Eat(); // Eating...
        }
    }
    
    class Animal
    {
        public void Eat()
        {
            Console.WriteLine("Eating...");
        }
    }
    
    class Human : Animal
    {
        public void Think()
        {
            Console.WriteLine("Who I am?");
        }
    }
    
    class Teacher : Human
    {
        public void Teach()
        {
            Console.WriteLine("I teach programming.");
        }
    }
    ```

    装箱

- 显式（explicit）类型转换

  ```csharp
  using System;
  
  namespace Conversion1Example
  {
      internal class Program
      {
          static void Main(string[] args)
          {
              Stone stone = new Stone();
              stone.Age = 5000;
              Monkey wukongsun = (Monkey)stone; // 石头变猴子
              Console.WriteLine(wukongsun.Age); //10
          }
      }
  
      class Stone
      {
          public int Age;
  
          public static explicit operator Monkey(Stone stone)
          {
              // 显式类型转换操作符就是目标类型的一个实列构造器
              Monkey m = new Monkey();
              m.Age = stone.Age / 500;
              return m;
          }
      }
  
      class Monkey
      {
          public int Age;
      }
  }
  ```

  - 有可能丢失精度（甚至发生错误）的转换，即cast

  - 拆箱

  - 使用Convert类

    ```csharp
    System.Convert
    ```

  - ToString方法与各数据类型的Parse/TryParse方法

- 自定义类型转换操作符

  - 示例


### 自动精度提升

```csharp
var x = 3.0 * 4;
Console.WriteLine(x.GetType().FullName); // double 会自动进行类型提升
Console.WriteLine(x);
```

### 除运算符

整型除法，返回的结果也是整数类型，小数点后的会被舍弃。除数不能为0，否者会报异常

```csharp
int a = 5;
int b = 4;  // b不能为0
int c = a / b;
Console.WriteLine(c);  // 1
Console.WriteLine(c.GetType().FullName); // System.Int32
```

浮点型除法，这里的d,e任何一个修改为int型，所得的结果也是和下面一样，这是因为在运行的时候如果两边的变量不是同一类型，会进行数值提升，自动提升到不损失精度的类型

```csharp
double d = 5.0;
double e = 4.0;
double f = d / e;
Console.WriteLine(f);  // 1.25
Console.WriteLine(f.GetType().FullName); // System.Double

double g = double.PositiveInfinity; // 正无穷大
double h = double.NegativeInfinity; // 负无穷大
Console.WriteLine(g/h); // NaN

double m = (double) 5 / 4; // 1.25,(T)x的操作优先级大于/
double n = (double)(5 / 4); // 1
```

### 求余操作符和加法操作符

```csharp
// 求余运算符
for (int i = 0; i < 10; i++)
{
    Console.WriteLine(i % 10);
}

double x = 3.5;
double y = 3;
Console.WriteLine(x % y); // 0.5

// 加法操作符
var a = 3.0 + 4;
Console.WriteLine(a);
Console.WriteLine(a.GetType().FullName); // System.Double

string s1 = "123";
string s2 = "abc";
string s3 = s1 + s2;
Console.WriteLine(s3);  
```

### 位移操作符

```csharp
int m = 7;
int n = m << 1; // 左位移一位，相当于乘2，相反，右移相当于除2
int k = m >> 2; // 右移溢出,在check上下文环境不会报错
string strM = Convert.ToString(m, 2).PadLeft(32, '0');
string strN = Convert.ToString(n, 2).PadLeft(32, '0');
string strK = Convert.ToString(k, 2).PadLeft(32, '0');
Console.WriteLine(strM); // 00000000000000000000000000000111
Console.WriteLine(strN); // 00000000000000000000000000001110
Console.WriteLine(strK); // 00000000000000000000000000000001
Console.WriteLine(n); // 14
```

### 关系运算符

```csharp
// 关系运算符
int x = 5;
double y = 4.0;
var result = x > y; 
Console.WriteLine(result.GetType().FullName); // System.Boolean
Console.WriteLine(result); // True

char char1 = 'a';  // char类型归类于整数类型，对应Unicode码表上的字符
char char2 = 'A';
var res = char1 > char2;
Console.WriteLine(res); // True
ushort u1 = (ushort)char1;
ushort u2 = (ushort)char2;
Console.WriteLine($"u1:{u1}"); // u1:97
Console.WriteLine($"u2:{u2}"); // u2:65

string str1 = "abc";
string str2 = "Abc";
Console.WriteLine(str1 == str2 ); // False
Console.WriteLine(str1.ToLower() == str2.ToLower()); // True
```

### 逻辑运算符

按位求与

```csharp
int x = 7;
int y = 28;
int z = x & y;
string strX = Convert.ToString(x, 2).PadLeft(32, '0');
string strY = Convert.ToString(y, 2).PadLeft(32, '0');
string strZ = Convert.ToString(z, 2).PadLeft(32, '0');
Console.WriteLine(strX); //00000000000000000000000000000111
Console.WriteLine(strY); //00000000000000000000000000011100
Console.WriteLine(strZ); //00000000000000000000000000000100
```

按位求或

```csharp
int x = 7;
int y = 28;
int z = x | y;
string strX = Convert.ToString(x, 2).PadLeft(32, '0');
string strY = Convert.ToString(y, 2).PadLeft(32, '0');
string strZ = Convert.ToString(z, 2).PadLeft(32, '0');
Console.WriteLine(strX); //00000000000000000000000000000111
Console.WriteLine(strY); //00000000000000000000000000011100
Console.WriteLine(strZ); //00000000000000000000000000011111
```

按位异或

```csharp
int x = 7;
int y = 28;
int z = x ^ y;
string strX = Convert.ToString(x, 2).PadLeft(32, '0');
string strY = Convert.ToString(y, 2).PadLeft(32, '0');
string strZ = Convert.ToString(z, 2).PadLeft(32, '0');
Console.WriteLine(strX); //00000000000000000000000000000111 
Console.WriteLine(strY); //00000000000000000000000000011100
Console.WriteLine(strZ); //00000000000000000000000000011011
```

条件与（&&）

条件或（||）

```csharp
Nullable<int> n = null;
int? m = null;
n = 100;
m = 100;
Console.WriteLine(n); // 100
Console.WriteLine(n.HasValue); //True
Console.WriteLine(n.GetType().FullName); // System.Int32

Console.WriteLine(m); // 100
Console.WriteLine(m.HasValue); //True
Console.WriteLine(m.GetType().FullName); // System.Int32
```

条件运算符（?:）

```csharp
int x = 90;
string str = string.Empty;
str = x >= 60 ? "passed" : "failed";
Console.WriteLine(str); //passed
```





