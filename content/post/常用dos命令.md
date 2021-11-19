---
title: "常用dos命令"
subtitle: ""
description: ""
date: 2021-11-09T14:37:01+08:00
author: holy
image: ""
tags: ["dos", "hack"]
categories: ["Posts" ]
---

# 常用dos命令

## cd命令

使用`cd（Change Directory）`命令可以改变当前目录，该命令用于切换路径目录。`cd`命令主要有以下3种使用方法。

1. `cd path`：path是路径，如输入cd c:\命令后按Enter键或输入cd Windows命令，即可分别切换到C:\和C:\Windows目录下。

2. `cd..`：cd后面的两个“.”表示返回上一级目录，如当前的目录为C:\Windows，如果输入cd..命令，按Enter键即可返回上一级目录，即C:\。

3. `cd\`：表示当前无论在哪个子目录下，通过该命令可立即返回到根目录下。

## dir命令

使用`dir`命令可以列出磁盘上所有的或指定的文件目录，主要显示的内容包含卷标、文件名、文件大小、文件建立日期和时间、目录名、磁盘剩余空间等。`dir`命令的格式如下

```shell
dir [盘符] [路径] [文件名] [/P] [/W] [/A: 属性]
```

其中，各个参数的作用如下。

1. `/P`：当显示的信息超过一屏时暂时锁定，暂停滚动显示后续的信息，直至按任意键才继续显示下一屏。

2. `/W`：以横向排列的形式显示文件名和目录名，每行5个（不显示文件大小、建立日期和时间）。

3. `/A`:属性：仅显示指定属性的文件，无此参数时，dir显示除系统和隐含文件外的所有文件。可指定为以下几种形式：

- /A:S：显示系统文件的信息。
- /A:H：显示隐含文件的信息。
- /A:R：显示只读文件的信息。
- /A:A：显示归档文件的信息。
- /A:D：显示目录信息。

比如，在“命令提示符”窗口中输入`dir c:\windows /a:h`命令，按`Enter`键，即可列出`c:\windows`目录下的隐藏文件

```bash
c:\>dir c:\windows /a:h
 驱动器 C 中的卷没有标签。
 卷的序列号是 E2BF-6CE8

 c:\windows 的目录

2019/12/07  22:47    <DIR>          BitLockerDiscoveryVolumeContents
2020/07/08  15:47    <DIR>          ELAMBKUP
2021/11/09  09:41    <DIR>          Installer
2019/12/07  17:14    <DIR>          LanguageOverlayCache
2019/12/07  17:09               670 WindowsShell.Manifest
               1 个文件            670 字节
               4 个目录  1,585,741,824 可用字节
```

## ping命令

`ping`命令是TCP/IP中最为常用的命令之一，主要用来检查网络是否通畅或者网络连接的速度。在“命令提示符”窗口中输入`ping /?`，可以得到这条命令的帮助信息。

```shell
c:\>ping /?

用法: ping [-t] [-a] [-n count] [-l size] [-f] [-i TTL] [-v TOS]
            [-r count] [-s count] [[-j host-list] | [-k host-list]]
            [-w timeout] [-R] [-S srcaddr] [-c compartment] [-p]
            [-4] [-6] target_name

选项:
    -t             Ping 指定的主机，直到停止。若要查看统计信息并继续操作，请键入 Ctrl+Break；若要停止，请键入 Ctrl+C。
    -a             将地址解析为主机名。
    -n count       要发送的回显请求数。
    -l size        发送缓冲区大小。
    -f             在数据包中设置“不分段”标记(仅适用于 IPv4)。
    -i TTL         生存时间。
    -v TOS         服务类型(仅适用于 IPv4。该设置已被弃用，对 IP 标头中的服务类型字段没有任何影响)。
    -r count       记录计数跃点的路由(仅适用于 IPv4)。
    -s count       计数跃点的时间戳(仅适用于 IPv4)。
    -j host-list   与主机列表一起使用的松散源路由(仅适用于 IPv4)。
    -k host-list    与主机列表一起使用的严格源路由(仅适用于 IPv4)。
    -w timeout     等待每次回复的超时时间(毫秒)。
    -R             同样使用路由标头测试反向路由(仅适用于 IPv6)。根据 RFC 5095，已弃用此路由标头。如果使用此标头，某些系统可能丢弃回显请求。
    -S srcaddr     要使用的源地址。
    -c compartment 路由隔离舱标识符。
    -p             Ping Hyper-V 网络虚拟化提供程序地址。
    -4             强制使用 IPv4。
    -6             强制使用 IPv6。
```

利用TTL值判断操作系统类型。由于不同的操作系统的主机设置的TTL值是不同的，所以可以根据其中TTL值来识别操作系统类型。一般情况下，分以下3种：

1. TTL=32，认为目标主机操作系统为Windows 95/98。
2. TTL=64~128，认为目标主机操作系统为Windows NT/2000/XP/7/10。
3. TTL=128~255或者32~64，认为目标主机操作系统为UNIX/Linux。

## net命令

使用`net`命令可以查询网络状态、共享资源以及计算机所开启的服务等，该命令的语法格式信息如下。

```shell
NET
    [ ACCOUNTS | COMPUTER | CONFIG | CONTINUE | FILE | GROUP | HELP |
      HELPMSG | LOCALGROUP | PAUSE | SESSION | SHARE | START |
      STATISTICS | STOP | TIME | USE | USER | VIEW ]
```

查询本台计算机开启哪些Window服务:

使用`net`命令查看网络状态。打开“命令提示符”窗口，输入`net start`命令。

## netstat命令

`netstat`命令主要用来显示网络连接的信息，包括显示活动的TCP连接、路由器和网络接口信息，是一个监控TCP/IP网络非常有用的工具，可以让用户得知系统中目前都有哪些网络连接正常。

在“命令提示符”窗口中输入`netstat/?`命令，可以得到这条命令的帮助信息。

```shell
C:\Users\q>netstat /?

显示协议统计信息和当前 TCP/IP 网络连接。

NETSTAT [-a] [-b] [-e] [-f] [-n] [-o] [-p proto] [-r] [-s] [-t] [-x] [-y] [interval]

  -a            显示所有连接和侦听端口。
  -b            显示在创建每个连接或侦听端口时涉及的可执行文件。在某些情况下，已知可执行文件托管多个独立的组件，此时会显示创建连接或侦听端口时涉及的组件序列。在此情况下，可执行文件的名称位于底部 [] 中，它调用的组件位于顶部，直至达到 TCP/IP。注意，此选项 可能很耗时，并且可能因为你没有足够的权限而失败。
  -e            显示以太网统计信息。此选项可以与 -s 选项结合使用。
  -f            显示外部地址的完全限定
                域名(FQDN)。
  -n            以数字形式显示地址和端口号。
  -o            显示拥有的与每个连接关联的进程 ID。
  -p proto      显示 proto 指定的协议的连接；proto可以是下列任何一个: TCP、UDP、TCPv6 或 UDPv6。如果与 -s选项一起用来显示每个协议的统计信息，proto 可以是下列任何一个:IP、IPv6、ICMP、ICMPv6、TCP、TCPv6、UDP 或 UDPv6。
  -q            显示所有连接、侦听端口和绑定的非侦听 TCP 端口。绑定的非侦听端口不一定与活动连接相关联。
  -r            显示路由表。
  -s            显示每个协议的统计信息。默认情况下，
                显示 IP、IPv6、ICMP、ICMPv6、TCP、TCPv6、UDP 和 UDPv6 的统计信息；
                -p 选项可用于指定默认的子网。
  -t            显示当前连接卸载状态。
  -x            显示 NetworkDirect 连接、侦听器和共享终结点。
  -y            显示所有连接的 TCP 连接模板。无法与其他选项结合使用。
  interval      重新显示选定的统计信息，各个显示间暂停的间隔秒数。按 CTRL+C 停止重新显示统计信息。如果省略，则 netstat 将打印当前的配置信息一次。
```

## tracert命令

使用`tracert`命令可以查看网络中路由节点信息，最常见的使用方法是在`tracert`命令后追加一个参数，表示检测和查看连接当前主机经历了哪些路由节点，适用于大型网络的测试，该命令的语法格式如下。

```shell
用法: tracert [-d] [-h maximum_hops] [-j host-list] [-w timeout]
               [-R] [-S srcaddr] [-4] [-6] target_name

选项:
    -d                 不将地址解析成主机名。
    -h maximum_hops    搜索目标的最大跃点数。
    -j host-list       与主机列表一起的松散源路由(仅适用于 IPv4)。
    -w timeout         等待每个回复的超时时间(以毫秒为单位)。
    -R                 跟踪往返行程路径(仅适用于 IPv6)。
    -S srcaddr         要使用的源地址(仅适用于 IPv6)。
    -4                 强制使用 IPv4。
    -6                 强制使用 IPv6。
```

## Tasklist命令

`Tasklist`命令用来显示运行在本地或远程计算机上的所有进程，带有多个执行参数。`Tasklist`命令的语法格式如下。

```shell
TASKLIST [/S system [/U username [/P [password]]]]
         [/M [module] | /SVC | /V] [/FI filter] [/FO format] [/NH]

描述:
    该工具显示在本地或远程机器上当前运行的进程列表。


参数列表:
   /S     system           指定连接到的远程系统。
   /U     [domain\]user    指定应该在哪个用户上下文执行这个命令。
   /P     [password]       为提供的用户上下文指定密码。如果省略，则提示输入。
   /M     [module]         列出当前使用所给 exe/dll 名称的所有任务。如果没有指定模块名称，显示所有加载的模块。
   /SVC                    显示每个进程中主持的服务。
   /APPS 显示 Microsoft Store 应用及其关联的进程。
   /V                      显示详细任务信息。
   /FI    filter           显示一系列符合筛选器指定条件的任务。
   /FO    format           指定输出格式。有效值: "TABLE"、"LIST"、"CSV"。
   /NH                     指定列标题不应该在输出中显示。只对 "TABLE" 和 "CSV" 格式有效。
   /?                      显示此帮助消息。

筛选器:
    筛选器名称     有效运算符           有效值
    -----------     ---------------           --------------------------
    STATUS          eq, ne                    RUNNING | SUSPENDED NOT RESPONDING | UNKNOWN
    IMAGENAME       eq, ne                    映像名称
    PID             eq, ne, gt, lt, ge, le    PID 值
    SESSION         eq, ne, gt, lt, ge, le    会话编号
    SESSIONNAME     eq, ne                    会话名称
    CPUTIME         eq, ne, gt, lt, ge, le    CPU 时间，格式为
                                              hh:mm:ss。
                                              hh - 小时，
                                              mm - 分钟，ss - 秒
    MEMUSAGE        eq, ne, gt, lt, ge, le    内存使用(以 KB 为单位)
    USERNAME        eq, ne                    用户名，格式为
                                              [域\]用户
    SERVICES        eq, ne                    服务名称
    WINDOWTITLE     eq, ne                    窗口标题
    模块         eq, ne                    DLL 名称

注意: 当查询远程计算机时，不支持 "WINDOWTITLE" 和 "STATUS"
      筛选器。

Examples:
    TASKLIST
    TASKLIST /M
    TASKLIST /V /FO CSV
    TASKLIST /SVC /FO LIST
    TASKLIST /APPS /FI "STATUS eq RUNNING"
    TASKLIST /M wbem*
    TASKLIST /S system /FO LIST
    TASKLIST /S system /U 域\用户名 /FO CSV /NH
    TASKLIST /S system /U username /P password /FO TABLE /NH
    TASKLIST /FI "USERNAME ne NT AUTHORITY\SYSTEM" /FI "STATUS eq running"
```


使用`Tasklist命令`可以查看每个进程提供的服务。例如，查看本机进程`svchost.exe`提供的服务，在“命令提示符”窗口中输入`Tasklist /svc`命令，按Enter键，即可显示进程svchost.exe提供的服务。

如果要查看本地系统中哪些进程调用了`shell32.dll`模块文件，用户可以在“命令提示符”窗口中输入`Tasklist /m shell32.dll`，按Enter键，即可显示这些进程的列表。

## SFC命令

SFC命令是Windows操作系统中使用频率比较高的命令，主要作用是扫描所有受保护的系统文件并完成修复工作。该命令的语法格式如下。该命令必须以管理员权限使用。

```shell
SFC [/SCANNOW] [/VERIFYONLY] [/SCANFILE=<file>] [/VERIFYFILE=<file>]
    [/OFFWINDIR=<offline windows directory> /OFFBOOTDIR=<offline boot directory> [/OFFLOGFILE=<log file path>]]

/SCANNOW        扫描所有保护的系统文件的完整性，并尽可能修复]有问题的文件。
/VERIFYONLY     扫描所有保护的系统文件的完整性。不会执行修复操作。
/SCANFILE       扫描引用的文件的完整性，如果找到问题，则修复文件。指定完整路径 <file>
/VERIFYFILE     验证带有完整路径 <file> 的文件的完整性。不会执行修复操作。
/OFFBOOTDIR     对于脱机修复，指定脱机启动目录的位置
/OFFWINDIR      对于脱机修复，指定脱机 Windows 目录的位置
/OFFLOGFILE     对于脱机修复，通过指定日志文件路径选择性地启用记录

示例:
        sfc /SCANNOW
        sfc /VERIFYFILE=c:\windows\system32\kernel32.dll
        sfc /SCANFILE=d:\windows\system32\kernel32.dll /OFFBOOTDIR=d:\ /OFFWINDIR=d:\windows
        sfc /SCANFILE=d:\windows\system32\kernel32.dll /OFFBOOTDIR=d:\ /OFFWINDIR=d:\windows /OFFLOGFILE=c:\log.txt
        sfc /VERIFYONLY
```

# 常用操作

## 使用命令行清除系统垃圾

```shell
@echo off
echo 正在清理系统垃圾文件，请稍等....
del /f /s /q %systemdrive%\*.tmp
del /f /s /q %systemdrive%\*._tmp
del /f /s /q %systemdrive%\*.log
del /f /s /q %systemdrive%\*.gid
del /f /s /q %systemdrive%\*.chk
del /f /s /q %systemdrive%\*.old
del /f /s /q %systemdrive%\recycled\*.*
del /f /s /q %windir%\*.bak
del /f /s /q %windir%\prefetch\*.*
rd /s /q %windir%\temp & md %windir%\temp
del /f /q %userprofile%\cookies\*.*
del /f /q %userprofile%\recent\*.*
del /f /s /q %userprofile%\Local Settings\Temporary Internet Files\*.
del /f /s /q %userprofile%\Local Settings\Temp\*.*
del /f /s /q %userprofile%\recent\*.*
echo 清除系统垃圾完成！
```

## 定时开关机

使用`shutdown`命令可以实现定时关机的功能，具体操作步骤如下。

```shell
shutdown /s /t 40
```

