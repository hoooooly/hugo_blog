---
title:       "使用hugo搭建个人博客"
subtitle:    ""
description: "如何使用hugo快速搭建个人或企业网站"
date:        2021-10-06T20:06:27+08:00
author:      "holy"
image:       ""
tags:        ["hugo", "blog"]
categories:  ["Posts" ]
---

## Hugo简介

Hugo世界上最快的网站构建框架‎，Hugo是由Go语言实现的静态网站生成器。简单、易用、高效、易扩展、快速部署。

## 快速开始

Windows平台下的安装非常简单，到 [Hugo Releases](https://github.com/gohugoio/hugo/releases) 下载对应的操作系统版本的Hugo二进制文件（hugo或者hugo.exe）

最好下载`hugo_extended`版本，因为有些主题是扩展功能。

将`hugo.exe`所在的目录添加到系统环境变量中，这样能使用Hugo了。

## 使用

### 创建站点

使用下面的命令创建站点。

```bash
hugo new site blog
```

### 目录结构

```bash
blog
    -archetypes/
    -config.toml
    -content/
    -data/
    -layouts/
    -static/
    -themes/
    -pulic/
```

**archetypes**

在通过`hugo new xxx`创建内容页面的时候，默认情况下hugo会创建`date`、`title`等`front matter`，可以通过在`archetypes`目录下创建文件，设置自定义的`front matter`。

关于`front matter`的详细说明可以访问[https://gohugo.io/content-management/front-matter/)](https://gohugo.io/content-management/front-matter/)获取更多答案。

**config.toml**

所有的hugo站点都有一个全局配置文件，用来配置整个站点的信息，hugo默认提供了跟多配置指令。

**content**

站点下所有的内容页面，也就是我们创建的md文件都在这个content目录下面。

**data**

data目录用来存储网站用到一些配置、数据文件。文件类型可以是`yaml|toml|json`等格式。

**layouts**

存放用来渲染content目录下面内容的模版文件，模版.html格式结尾，layouts可以同时存储在项目目录和`themes/<THEME>/layouts`目录下。

**static**

用来存储图片、css、js等静态资源文件。

**themes**

用来存储主题，主题可以方便的帮助我们快速建立站点，也可以方便的切换网站的风格样式。

**public**

hugo编译后生成网站的所有文件都存储在这里面，把这个目录放到任意web服务器就可以发布网站。

### 选择主题

hugo社区有很多免费的主题供我们选择, 选择一个自己喜欢的主题, 下载后保存在themes目录下面。

```bash
通过命令行的方式使用主题: hugo -t 主题目录名
通过在config.toml配置使用: theme = “主题目录名”
```

### 创建/编写文章

```bash
hugo new [路径]文章名.md
```

hugo new会创建包含默认元数据的文章, 这时作者已经可以使用任何自己喜欢的编辑工具来编辑这篇文章了。


在创建文章时, 如果没有路径, 文章会保存在content目录中, 如果包含路径则会在content目录中创建对应的目录。

```bash
hugo new about-me.md
hugo new post/first.md
# 执行上面两条语句后content的目录结构
├─content
│    about-me.md
├────post
│        first.md
```bash

### 生成网站

```bash
hugo -d 目标路径 
```

如果不指定目标路径, 会默认在public目录下生成可部署的网站。

### 本地预览网站

通过`hugo server -D`本地生成网站预览. 会监控页面的更改, 并刷新页面。

```bash
$ hugo server -D
Start building sites …
hugo v0.88.1-5BC54738+extended windows/amd64 BuildDate=2021-09-04T09:39:19Z VendorInfo=gohugoio
                   | EN
-------------------+-----
  Pages            | 25
  Paginator pages  |  0
  Non-page files   |  0
  Static files     | 67
  Processed images |  0
  Aliases          |  4
  Sitemaps         |  1
  Cleaned          |  0

Built in 136 ms
Watching for changes in E:\holyBlog\{archetypes,content,data,layouts,static,themes}
Watching for config changes in E:\holyBlog\config.toml
Environment: "development"
Serving pages from memory
Running in Fast Render Mode. For full rebuilds on change: hugo server --disableFastRender
Web Server is available at http://localhost:1313/ (bind address 127.0.0.1)
Press Ctrl+C to stop
```

默认地址为: `http://localhost:1313/` 如果1313端口被占用, 会随机生成其他的端口. `-D(大写)`参数作用是为草稿文件生成预览。

## 部署

### 推送到仓库


### 自动部署