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
  - An anonymous function.
  - A property access.
  - An event access.
  - An indexer access.
  - Noting. 对返回值为void的方法的调用

- 复合表达式的求值

  - 注意操作符的优先级同优先级操作符的运算方向

- 参考C#语言定义文档

  - 仅做参考，不必深究

  

