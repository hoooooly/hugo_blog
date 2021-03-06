---
title: "Vscode使用koroFileHeader注释插件"
subtitle: ""
description: "注释是代码必须的，vscode有丰富的插件支持，koroFileHeader就是一款非常不错的注释插件"
date: 2021-10-10T22:18:19+08:00
author: holy
image: ""
tags: ["vscode"]
categories: ["Posts" ]
---

# 安装

`Ctrl+Shift+x`搜索`koroFileHeader`安装即可。

![](/images/20211010223015.png)

# 两种注释方式

## 文件添加头部注释：

在当前编辑文件中使用快捷键:

- window：`Ctrl+Alt+i`
- mac：`Ctrl+cmd+i`
- linux：`Ctrl+meta+i` 

即可生成文件头部注释。

## 在光标处添加函数注释

将光标放在函数行或者将光标放在函数上方的空白行，使用快捷键：

- window：`Ctrl+Alt+t`
- mac：`Ctrl+cmd+t`
- linux：`Ctrl+meta+t `

即可生成函数注释。

# 注释模板配置

`Ctrl + Shift + p`输入`settings.json`打开配置文件。

```json
    // 头部注释
    "fileheader.customMade": {
        // 头部注释默认字段
        "Author": "user",
        "Date": "Do not edit", // 设置后默认设置文件生成时间
        "LastEditTime": "Do not edit", // 设置后，保存文件更改默认更新最后编辑时间
        "LastEditors": "user", // 设置后，保存文件更改默认更新最后编辑人
        "Description": "",
        "FilePath": "Do not edit", // 设置后，默认生成文件相对于项目的路径
        "custom_string_obkoro1": "你也总是天亮了才睡!"
    },
    // 函数注释
    "fileheader.cursorMode": {
        // 默认字段
        "description": "",
        "param": "",
        "return": ""
    },
    // 插件配置项
    "fileheader.configObj": {
        "autoAdd": true, // 检测文件没有头部注释，自动添加文件头部注释
        "autoAddLine": 100, // 文件超过多少行数 不再自动添加头部注释
        "autoAlready": true, // 只添加插件支持的语言以及用户通过`language`选项自定义的注释
        // 自动添加头部注释黑名单
        "prohibitAutoAdd": [
            "json"
        ],
        "prohibitItemAutoAdd": [
            "项目的全称禁止项目自动添加头部注释, 使用快捷键自行添加"
        ],
        "switch": {
            "newlineAddAnnotation": true // 默认遇到换行符(\r\n \n \r)添加注释符号
        },
        "wideSame": false, // 头部注释等宽设置
        "wideNum": 13, // 头部注释字段长度 默认为13
        "moveCursor": true, // 自动移动光标到Description所在行
        "dateFormat": "YYYY-MM-DD HH:mm:ss",
        "atSymbol": "@", // 更改所有文件的自定义注释中的@符号
        "atSymbolObj": {}, //  更改单独语言/文件的@
        "colon": ": ", // 更改所有文件的注释冒号
        "colonObj": {}, //  更改单独语言/文件的冒号
        "filePathColon": "路径分隔符替换", // 默认值： mac: / window是: \
        "showErrorMessage": false, // 是否显示插件错误通知 用于debugger
        "CheckFileChange": false, // 单个文件保存时进行diff检查
        "createHeader": true, // 新建文件自动添加头部注释
        // 自定义语言注释符号，覆盖插件的注释格式
        "language": {
            "java": {
                "head": "/$$",
                "middle": " $ @",
                "end": " $/"
            },
            // 一次匹配多种文件后缀文件 不用重复设置
            "h/hpp/cpp": {
                "head": "/*** ", // 统一增加几个*号
                "middle": " * @",
                "end": " */"
            },
            // 针对有特殊要求的文件如：test.blade.php
            "blade.php": {
                "head": "<!--",
                "middle": " * @",
                "end": "-->",
            }
        },
        // 默认注释  没有匹配到注释符号的时候使用。
        "annotationStr": {
            "head": "/*",
            "middle": " * @",
            "end": " */",
            "use": false
        },
    }
```

[注释模板配置](https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE)



