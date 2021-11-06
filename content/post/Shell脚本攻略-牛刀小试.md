---
title: "Shell脚本攻略 使用变量与环境变量"
subtitle: ""
description: ""
date: 2021-11-07T00:02:18+08:00
author: holy
image: ""
tags: ["shell", "linux"]
categories: ["Posts" ]
draft: true
---

# 使用变量与环境变量

shell定义了一些变量，用于保存用到的配置信息，比如可用的打印机、搜索路径等。这些变量叫作环境变量。

使用env或printenv命令查看当前shell中所定义的全部环境变量：

```bash
$ env
```

## 查看进程PID

假设有一个叫作gedit的应用程序正在运行。我们可以使用pgrep命令获得gedit的进程ID：

```bash
$ pgrep gedit
10380
```

## 检查是否为超级用户

环境变量UID中保存的是用户ID。它可以用于检查当前脚本是以root用户还是以普通用户的身份运行的。

```bash
if [ $UID -ne 0 ]; then
    echo Non root user
else
    echo Root user
fi
```

## 识别当前所使用的shell

可以通过环境变量SHELL获知当前使用的是哪种shell。

```bash
$ echo $SHELL
```

或：

```bash
$ echo $0
```

