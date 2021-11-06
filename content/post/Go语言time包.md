---
title: "Go语言time包"
subtitle: ""
description: ""
date: 2021-11-06T16:10:43+08:00
author: holy
image: ""
tags: ["time", "go"]
categories: ["Posts" ]
---

# Time包

time 包提供了时间的显示和计量用的功能。日历的计算采用的是公历。提供的主要类型如下：

## 时间类型

time.Time类型表示时间。

### Time的内部结构

```go
type Time struct {
    // sec gives the number of seconds elapsed since
    // January 1, year 1 00:00:00 UTC.
    sec int64

    // nsec specifies a non-negative nanosecond
    // offset within the second named by Seconds.
    // It must be in the range [0, 999999999].
    nsec int32

    // loc specifies the Location that should be used to
    // determine the minute, hour, month, day, and year
    // that correspond to this Time.
    // Only the zero Time has a nil Location.
    // In that case it is interpreted to mean UTC.
    loc *Location
}
```

`Time`有很多方法，可以获取时间信息。

通过time.Now()函数获取当前的时间对象，然后获取时间对象的年月日时分秒等信息。

```go
	nowTime := time.Now() //获取当前时间
	fmt.Printf("当前时间为:%v\n", nowTime)

	year := nowTime.Year() //年
	month := nowTime.Month() //月
	day := nowTime.Day() //日
	hour := nowTime.Hour() //小时
	minute := nowTime.Minute() //分钟
	second := nowTime.Second() //秒
	fmt.Printf("%d-%02d-%02d %02d:%02d:%02d\n", year, month, day, hour, minute, second)
```

运行结果：

```bash
当前时间为:2021-11-06 21:51:25.7291889 +0800 CST m=+0.002630701
2021-11-06 21:51:25
```

## 时间戳

时间戳是自1970年1月1日（08:00:00GMT）至当前时间的总毫秒数。它也被称为Unix时间戳（UnixTimestamp）。

基于时间对象获取时间戳的示例代码如下：

```go
func timeStamp()  {
	nowTime := time.Now()	// 获取当前时间
	timeStamp1 := nowTime.Unix() // 获取Unix时间戳
	timeStamp2 := nowTime.UnixNano() // 纳秒时间戳
	fmt.Printf("当前时间戳：%v\n", timeStamp1)
	fmt.Printf("当前时间内戳（纳秒）：%v\n", timeStamp2)
}
```

运行结果：

```bash
当前时间戳：1636207208
当前时间内戳（纳秒）：1636207208581358400
```

使用time.Unix()函数可以将时间戳转为时间格式。

```bash
func timeStamp2time(timestamp int64){
	timeObj := time.Unix(timestamp, 0) // 将时间戳转成时间格式
	fmt.Println(timeObj)
	year := timeObj.Year() //年
	month := timeObj.Month() //月
	day := timeObj.Day() //日
	hour := timeObj.Hour() //小时
	minute := timeObj.Minute() //分钟
	second := timeObj.Second() //秒
	fmt.Printf("%d-%02d-%02d %02d:%02d:%02d\n", year, month, day, hour, minute, second)
}
```

## 时间间隔

time.Duration是time包定义的一个类型，它代表两个时间点之间经过的时间，以纳秒为单位。time.Duration表示一段时间间隔，可表示的最长时间段大约290年。

time包中定义的时间间隔类型的常量如下：

```go
const (
    Nanosecond  Duration = 1
    Microsecond          = 1000 * Nanosecond
    Millisecond          = 1000 * Microsecond
    Second               = 1000 * Millisecond
    Minute               = 60 * Second
    Hour                 = 60 * Minute
)
```

例如：time.Duration表示1纳秒，time.Second表示1秒。

## 时间操作

### Add

```go
func (t Time) Add(d Duration) Time
```

Add返回时间点t+d。

比如，求一个小时之后的时间：

```go
func main() {
    now := time.Now()
    later := now.Add(time.Hour) // 当前时间加1小时后的时间
    fmt.Println(later)
} 
```

### Sub

求两个时间之间的差值：

```go
func (t Time) Sub(u Time) Duration 
```

返回一个时间段t-u。如果结果超出了Duration可以表示的最大值/最小值，将返回最大值/最小值。要获取时间点t-d（d为Duration），可以使用t.Add(-d)。

### Equal

```go
func (t Time) Equal(u Time) bool
```

判断两个时间是否相同，会考虑时区的影响，因此不同时区标准的时间也可以正确比较。本方法和用t==u不同，这种方法还会比较地点和时区信息。

### Before

```go
func (t Time) Before(u Time) bool
```

如果t代表的时间点在u之前，返回真；否则返回假。

### After

```go
func (t Time) After(u Time) bool
```

如果t代表的时间点在u之后，返回真；否则返回假。

## 定时器

使用time.Tick(时间间隔)来设置定时器，定时器的本质上是一个通道（channel）。

```go
func timeTick()  {
	ticker := time.Tick(time.Second) // 定义一个1秒间隔的定时器
	for i := range ticker{
		fmt.Println(i) // 没秒都会执行的任务
	}
}
```

运行结果：

```bash
2021-11-06 22:31:56.4939571 +0800 CST m=+1.003378501
2021-11-06 22:31:57.49535 +0800 CST m=+2.004771401
2021-11-06 22:31:58.4952497 +0800 CST m=+3.004671101
2021-11-06 22:31:59.4944173 +0800 CST m=+4.003838701
...
```

不停止的话会一直执行下去。

## 时间格式化

时间类型有一个自带的方法Format进行格式化，需要注意的是Go语言中格式化时间模板不是常见的Y-m-d H:M:S而是使用Go的诞生时间2006年1月2号15点04分（记忆口诀为2006 1 2 3 4）。

如果想格式化为12小时方式，需指定PM。

```go
func timeFormat()  {
	now := time.Now()
	// 24小时制
	fmt.Println(now.Format("2006-01-02 15:04:05.00 Mon Jan"))
	// 12小时制
	fmt.Println(now.Format("2006-01-02 03:04；05.000 PM Mon Jan"))
	fmt.Println(now.Format("2006/01/02 15:04"))
	fmt.Println(now.Format("15:04 2006/01/02"))
	fmt.Println(now.Format("2006/01/02"))
}
```

运行结果：

```bash
2021-11-06 22:59:46.95 Sat Nov
2021-11-06 10:59；46.954 PM Sat Nov
2021/11/06 22:59
22:59 2021/11/06
2021/11/06
```


### 解析字符串格式的时间

```go
func main(){
	now := time.Now()
	fmt.Println(now)
	// 时区
	loc, err := time.LoadLocation("Asia/Shanghai")
	if err != nil{
		fmt.Println(err)
		return
	}

	// 按照指定时和指定格式解析字符串时间
	timeObj, err := time.ParseInLocation("2006/01/02 15:04:05", "2022/11/06 23:14:20", loc)
	if err != nil{
		fmt.Println(err)
		return
	}
	fmt.Println(timeObj)
	fmt.Println(timeObj.Sub(now))
}
```

