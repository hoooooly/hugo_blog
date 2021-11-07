---
title: "Gorm Go语言对象关系映射"
subtitle: ""
description: ""
date: 2021-11-07T11:06:44+08:00
author: holy
image: ""
tags: ["go", "orm", "gorm"]
categories: ["Posts" ]
---

# 概述

一个神奇的，对开发人员友好的 `Golang ORM` 库

## 概览

- 全特性 ORM (几乎包含所有特性)
- 模型关联 (一对一， 一对多，一对多（反向）， 多对多， 多态关联)
- 钩子 (Before/After Create/Save/Update/Delete/Find)
- 预加载
- 事务
- 复合主键
- SQL 构造器
- 自动迁移
- 日志
- 基于GORM回调编写可扩展插件
- 全特性测试覆盖
- 开发者友好

## 安装

```bash
go get -u gorm.io/gorm
go get -u gorm.io/driver/sqlite
```

## 快速开始

```go
package main

import (
	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
)

type Product struct {
	gorm.Model
	Code string
	Price uint
}

func main() {
	db, err := gorm.Open(sqlite.Open("test.db"), &gorm.Config{})
	if err != nil {
		panic("failed to connect database")
	}

	//自动检查 Product 结构是否变化，变化则进行迁移
	db.AutoMigrate(&Product{})

	// 增
	db.Create(&Product{Code: "L1212", Price: 1000})

	// 查
	var product Product
	db.First(&product, 1) // 找到id为1的产品
	db.First(&product, "code = ?", "L1212") // 找出 code 为 l1212 的产品

	// 改 - 更新产品的价格为 2000
	db.Model(&product).Update("Price", 2000)

	// 删 - 删除产品
	db.Delete(&product)
}
```

# 入门指南

## 模型定义

模型一般都是普通的 `Golang` 的结构体，Go的基本数据类型，或者指针。`sql.Scanner` 和 `driver.Valuer`，同时也支持接口。

```go
type User struct {
  gorm.Model
  Name         string
  Age          sql.NullInt64
  Birthday     *time.Time
  Email        string  `gorm:"type:varchar(100);unique_index"`
  Role         string  `gorm:"size:255"` //设置字段的大小为255个字节
  MemberNumber *string `gorm:"unique;not null"` // 设置 memberNumber 字段唯一且不为空
  Num          int     `gorm:"AUTO_INCREMENT"` // 设置 Num字段自增
  Address      string  `gorm:"index:addr"` // 给Address 创建一个名字是  `addr`的索引
  IgnoreMe     int     `gorm:"-"` //忽略这个字段
}
```

### 结构标签

标签是声明模型时可选的标记。`GORM`支持以下标记：

1. 支持的结构标签

声明 model 时，tag 是可选的，GORM 支持以下 tag： tag 名大小写不敏感，但建议使用 camelCase 风格

| 标签 | 说明 |
| :-- | :-- |
| Column | 指定列的名称 |
| Type | 指定列的类型 |
| Size | 指定列的大小，默认是 255 |
| PRIMARY_KEY | 指定一个列作为主键 |
| UNIQUE | 指定一个唯一的列 |
| DEFAULT | 指定一个列的默认值 |
| PRECISION | 指定列的数据的精度 |
| NOT NULL | 指定列的数据不为空 |
| AUTO_INCREMENT | 指定一个列的数据是否自增 |
| INDEX | 创建带或不带名称的索引，同名创建复合索引 |
| UNIQUE_INDEX | 类似 索引，创建一个唯一的索引 |
| EMBEDDED | 将 struct 设置为 embedded |
| EMBEDDED_PREFIX | 设置嵌入式结构的前缀名称 |
| <- | 设置字段写入的权限， <-:create 只创建、<-:update 只更新、<-:false 无写入权限、<- 创建和更新权限 |
| -> | 设置字段读的权限，->:false 无读权限 |
| -	| 忽略该字段，- 无读写权限 |
| comment | 迁移时为字段添加注释 |

2. 关联的结构标签

| 标签 | 说明 |
| :-- | :-- |
| MANY2MANY | 指定连接表名称 |
| FOREIGNKEY | 指定外键 |
| ASSOCIATION_FOREIGNKEY | 指定关联外键 |
| POLYMORPHIC | 指定多态类型 |
| POLYMORPHIC_VALUE | 指定多态的值 |
| JOINTABLE_FOREIGNKEY | 指定连接表的外键 |
| ASSOCIATION_JOINTABLE_FOREIGNKEY | 指定连接表的关联外键 |
| SAVE_ASSOCIATIONS | 是否自动保存关联 |
| ASSOCIATION_AUTOUPDATE | 是否自动更新关联 |
| ASSOCIATION_AUTOCREATE | 是否自动创建关联 |
| ASSOCIATION_SAVE_REFERENCE | 是否引用自动保存的关联 |
| PRELOAD | 是否自动预加载关联 |

## 惯例

### gorm.Model

`gorm.Model`是一个包含一些基本字段的结构体, 包含的字段有 `ID`，`CreatedAt`， `UpdatedAt`，`DeletedAt`。

可以用它来嵌入到你的模型中，或者也可以用它来建立自己的模型。

```go
// gorm.Model 定义
type Model struct {
  ID        uint `gorm:"primary_key"`
  CreatedAt time.Time
  UpdatedAt time.Time
  DeletedAt *time.Time
}

// 将字段 `ID`, `CreatedAt`, `UpdatedAt`, `DeletedAt` 注入到 `User` 模型中
type User struct {
  gorm.Model
  Name string
}
// 等效于
type User struct {
  ID        uint           `gorm:"primaryKey"`
  CreatedAt time.Time
  UpdatedAt time.Time
  DeletedAt gorm.DeletedAt `gorm:"index"`
  Name string
}
```

### ID作为主键

`GORM` 默认使用 `ID` 作为主键名。

```go
type User struct {
  ID   string // 字段名 `ID` 将被作为默认的主键名
}

// 设置字段 `AnimalID` 为默认主键
type Animal struct {
  AnimalID int64 `gorm:"primary_key"`
  Name     string
  Age      int64
}
```

