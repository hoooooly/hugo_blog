---
title: "Gorm Go语言对象关系映射 CRUD"
subtitle: ""
description: ""
date: 2021-11-08T19:44:24+08:00
author: holy
image: ""
tags: ["go", "gorm", "curd"]
categories: ["Posts" ]
---

# CURD接口

## 创建

### 创建记录

```go
user := User{Name: "holy", Age: 28, Birthday: time.Now()}

result := db.Create(&user) //通过数据的指针来创建

fmt.Println(user.ID)             // 返回插入数据的主键
fmt.Println(result.Error)        // 返回 error
fmt.Println(result.RowsAffected) // 返回插入记录的条数
```

### 用指定的字段创建记录

创建记录并更新给出的字段。

```go
db.Select("Name", "Age", "CreatedAt").Create(&user)
// INSERT INTO `users` (`name`,`age`,`created_at`) VALUES ("jinzhu", 18, "2020-07-04 11:05:21.775")
```

创建一个记录且一同忽略传递给略去的字段值。

```go
db.Omit("Name", "Age", "CreatedAt").Create(&user)
// INSERT INTO `users` (`birthday`,`updated_at`) VALUES ("2020-01-01 00:00:00.000", "2020-07-04 11:05:21.775")
```

### 批量插入

要有效地插入大量记录，请将一个 `slice` 传递给 `Create` 方法。 `GORM` 将生成单独一条SQL语句来插入所有数据，并回填主键的值，钩子方法也会被调用。

```go
var users = []User{{Name: "jinzhu1"}, {Name: "jinzhu2"}, {Name: "jinzhu3"}}
db.Create(&users)

for _, user := range users {
  user.ID // 1,2,3
}
```

使用 `CreateInBatches` 分批创建时，你可以指定每批的数量，例如：

```go
var users = []User{{name: "jinzhu_1"}, ...., {Name: "jinzhu_10000"}}

// 数量为 100
db.CreateInBatches(users, 100)
```

### 创建钩子

GORM 允许用户定义的钩子有 BeforeSave, BeforeCreate, AfterSave, AfterCreate 创建记录时将调用这些钩子方法，高级用法中会详细介绍。

```go
func (u *User) BeforeCreate(tx *gorm.DB) (err error) {
  u.UUID = uuid.New()

    if u.Role == "admin" {
        return errors.New("invalid role")
    }
    return
}
```

### 根据 Map 创建

GORM 支持根据 map[string]interface{} 和 []map[string]interface{}{} 创建记录，例如：

```go
db.Model(&User{}).Create(map[string]interface{}{
  "Name": "jinzhu", "Age": 18,
})

// batch insert from `[]map[string]interface{}{}`
db.Model(&User{}).Create([]map[string]interface{}{
  {"Name": "jinzhu_1", "Age": 18},
  {"Name": "jinzhu_2", "Age": 20},
})
```

> 注意： 根据 map 创建记录时，association 不会被调用，且主键也不会自动填充


## 查询



## 高级查询

## 更新

## 删除

## 原生SQL和SQL生成器
