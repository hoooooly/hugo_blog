---
title: "Go语言对文件的操作"
subtitle: ""
description: ""
date: 2021-10-21T00:23:23+08:00
author: holy
image: ""
tags: ["os库", "go"]
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

```bash
const (
    O_RDONLY int = syscall.O_RDONLY // 只读模式打开文件
    O_WRONLY int = syscall.O_WRONLY // 只写模式打开文件
    O_RDWR   int = syscall.O_RDWR   // 读写模式打开文件
    O_APPEND int = syscall.O_APPEND // 写操作时将数据附加到文件尾部
    O_CREATE int = syscall.O_CREAT  // 如果不存在将创建一个新文件
    O_EXCL   int = syscall.O_EXCL   // 和O_CREATE配合使用，文件必须不存在
    O_SYNC   int = syscall.O_SYNC   // 打开文件用于同步I/O
    O_TRUNC  int = syscall.O_TRUNC  // 如果可能，打开时清空文件
)
```

#### 文件模式

创建文件时，我们可以指定文件的权限，文件权限总共分三种：读（r）、写（w）、执行（x），其中：

```bash
读（r）：4
写（w）：2
执行（x）：1
```

然后一个文件可被拥有者、拥有者所在组里的其他成员、以及除此以外的其他成员读写或执行（在赋予相应的权限的前提下）。例如 0764 模式，代表的意思见下面的讲解：

```bash
其中 0 后面第一个位置处的 7 代表 4 + 2 + 1，即 rwx 权限，意思就是：文件拥有者可以读写并执行该文件
7 后面的 6 代表 4 + 2 + 0，即 rw- 权限，意思就是：文件拥有者所在的组里的其他成员可对文件进行读写操作
6 后面的 4 代表 4 + 0 + 0，即 r-- 权限，意思就是：除了上面提到的用户，其余用户只能对该文件进行读操作
```

创建一个不存在的文件，并且文件权限设为 rwxr-xr–。

```bash
package main

import (
	"fmt"
	"os"
)

func OpenFile(filename string)  {
	_, err := os.OpenFile(filename, os.O_CREATE, 0754)
	if err != nil{
		fmt.Println(err)
	}else {
		fmt.Println("文件创建成功")
	}
}

func main() {
	OpenFile("golang_file1.txt")
}
```

### 创建单级目录

创建单级目录用到的方法是 Mkdir(name string, perm FileMode) error。

```bash
package main

import (
	"fmt"
	"os"
)

func MkDir(dirname string, perm os.FileMode){
	err := os.Mkdir(dirname, perm)
	if err != nil{
		fmt.Println(err)
	}
	fmt.Println(dirname, "目录创建成功")

}

func main() {
	MkDir("static", 0740)
}
```

### 创建多级目录

创建多级目录用到的方法是 MkdirAll(path string, perm FileMode) error。权限位 perm 会应用在每一个被本函数创建的目录上。如果 path 指定了一个已经存在的目录，MkdirAll 不做任何操作并返回 nil。

```bash
package main

import (
	"fmt"
	"os"
)

func MkDirP(dirname string, perm os.FileMode){
	err := os.MkdirAll(dirname, perm)
	if err!= nil{
		fmt.Println(err)
		return
	}
	fmt.Println(dirname, "多级目录创建成功")
}

func main() {
	MkDirP("static/go", 0740)
}
```

## 打开文件

### os.Open(name string) (file *File, err error)

Open打开一个文件用于读取。如果操作成功，返回的文件对象的方法可用于读取数据；对应的文件模式是 `O_RDONLY` 模式。

```bash
file, err := os.Open(filename)
```

### os.OpenFile(name string, flag int, perm FileMode) (file *File, err error)

## 读取文件内容

### 按字节读取

- 循环读取

读取的时候，要注意一个问题，就是文件有时候可能太大，需要我们循环多次去读取，这个时候需要设置两个“容器”，一个容器用来装每次读的内容，另一个容器用来累积读的所有内容，看下面示例代码：



- 一次性读取