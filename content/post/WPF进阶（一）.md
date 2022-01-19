---
title: "WPF进阶（一）"
subtitle: ""
description: "WPF进阶（一）"
date: 2022-1-17T16:15:25+08:00
author: holy
image: ""
tags: ["WPF"]
categories: ["Posts"]
typora-root-url: ..\..\static\
---

# 创建控件模板

## 理解控件模板

WPF包含数据模板和控件模板，其中控件模板又包括`ControlTemplate`和 `ItemsPanelTemplate`。

WPF的每一个控件都有一个默认的模板，板描述了控件的外观以及外观对外界刺激所做出的反应（触发器）。

控件模板 可以改变控件的内部结构（VisualTree，视觉树）来完成更为复杂的定制，需要替换控件的模板。与Style不同，Style只能改变控件的已有属性值（比如颜色字体）来定制控件。

`ControlTemplate`包含两个重要的属性：

- VisualTree，该模板的视觉树，使用这个属性来描述控件的外观
- Triggers，触发器列表，里面包含一些触发器Trigger，定制这个触发器列表来使控件对外界的刺激发生反应，比如鼠标经过时文本变成粗体等。

## 创建控件模板

## 模板绑定

## 模板触发器

```xaml
<Window x:Class="控件模板.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:控件模板"
        mc:Ignorable="d"
        Title="MainWindow" Height="450" Width="800">
    <Window.Resources>
        <!--在这里定义控件模板 
            TargetType="{x:Type 控件类型}"-->
        <ControlTemplate x:Key="ButtonTemplate" TargetType="{x:Type Button}">
            <Border x:Name="myBorder" BorderBrush="Orange" BorderThickness="3" CornerRadius="2" Background="Red" TextBlock.Foreground="White">
                <!--内容表示器-->
                <ContentPresenter Margin="{TemplateBinding Padding}" HorizontalAlignment="Center" VerticalAlignment="Center"/>
            </Border>
            
            <!--触发器列表-->
            <ControlTemplate.Triggers>
                <Trigger Property="IsMouseOver" Value="true">
                    <!--鼠标系统到Border元素中，背景色发生改变-->
                    <Setter TargetName="myBorder" Property="Background" Value="Darkred"></Setter>
                </Trigger>
                <Trigger Property="IsPressed" Value="true">
                    <!--鼠标点击的时候背景变成蓝色-->
                    <Setter TargetName="myBorder" Property="Background" Value="Blue"></Setter>
                    <Setter TargetName="myBorder" Property="BorderBrush" Value="Green"></Setter>
                </Trigger>
            </ControlTemplate.Triggers>
            
        </ControlTemplate>
    </Window.Resources>
    <StackPanel Margin="5">
        <Button Margin="5" Padding="3">Normal Button</Button>
        <!--普通按钮-->
        <Button Margin="5" Padding="3" Template="{StaticResource ButtonTemplate}">Temaplated Button</Button>
        <!--模板化按钮-->
    </StackPanel>
</Window>
```





