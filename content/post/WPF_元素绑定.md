---
title: "WPF_元素绑定"
subtitle: ""
description: "WPF_元素绑定"
date: 2021-12-24T16:15:25+08:00
author: holy
image: ""
tags: ["WPF"]
categories: ["Posts"]
typora-root-url: ..\..\static\
---



将两个元素绑定到一起，一个元素影响另外一个元素。

首先，创建一个WPF程序。

添加`Stack Panel`控件到`Grid`中，添加`Slider`控件到`Stack Panel`元素中，添加`TextBlock`控件到`Stack Panel`中。

```xaml
<Window x:Class="将元素绑定到一起.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:将元素绑定到一起"
        mc:Ignorable="d"
        Title="MainWindow" Height="450" Width="800">
    <Grid>
        <StackPanel Margin="5" Name="stackPanel">
            <Slider Height="Auto" Name="slider1" Margin="3" Minimum="1" Maximum="40"/>
            <TextBlock Name="textBlock1" Text="Simple Text" Margin="10" FontSize="{Binding ElementName=slider1, Path=Value}"></TextBlock>
        </StackPanel>

    </Grid>
</Window>
```

使用`Binding`将`Textblcok`控件的`Fontsize`值和滑动条`Slider`的`Value`值绑定到一起，这样滑动条移动会改变字体的大小。

![image-20211224163614387](images\image-20211224163614387.png)

如果有`Slider`的`Value`值发生变化，`Fontsize`的值也会发生相应变化。

