<!--
 * @Author: holy
 * @Date: 2021-10-21 00:23:23
 * @LastEditTime: 2021-10-25 16:17:23
 * @LastEditors: holy
 * @Description: 
 * @FilePath: \undefinede:\blog\content\post\Go语言对文件的操作.md
-->
---
title: "Go语言对文件的操作"
subtitle: ""
description: ""
date: 2021-10-21T00:23:23+08:00
author: holy
image: ""
tags: ["os", "go"]
categories: ["Posts" ]
---

# 前言

文件是什么？

计算机中的文件是存储在外部介质（通常是磁盘）上的数据集合，文件分为`文本文件`和`二进制文件`。

Go 语言的 os 包，拥有对文件进行操作的一系列方法、函数。

# 文件操作-创建、打开、读、写

## 创建文件

### os.Create(name string) (file *File, err error)

Create采用模式0644（文件创建者可读写但不可执行，同组以及其他人都只可读，不可写和执行）创建一个名为name的文件，如果文件已存在会截断它（为空文件）。如果成功，返回的文件对象可用于I/O；对应的文件描述符具有O_RDWR模式。如果出错，err 不为 nil，错误底层类型是*PathError。

```go
func CreateFile(filename string) {
	_, err := os.Create(filename)
	if err != nil {
		fmt.Println(err)
	} else {
		fmt.Printf("%s文件创建成功！", filename)
	}
}
func main() {
	CreateFile("golang.txt")
}
```
执行上述代码：

```bash
E:\go\src\Go_by_example\文件读写>go run maIn.go
golang.txt文件创建成功！
```

### os.OpenFile(name string, flag int, perm FileMode) (file *File, err error)

OpenFile是一个更一般性的文件打开函数，大多数调用者都应用Open或Create代替本函数。它会使用指定的选项（如O_RDONLY等）、指定的模式（如0666等）打开指定名称的文件。如果操作成功，返回的文件对象可用于I/O。如果出错，err 不为 nil，错误底层类型是*PathError。

#### 文件选项



