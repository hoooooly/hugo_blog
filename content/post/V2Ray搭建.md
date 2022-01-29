# V2Ray搭建

首先必须要一个云服务器，这个不用多说。

获取一键安装脚本：

```bash
bash <(curl -s -L https://git.io/v2ray-setup.sh)
```

显示一下信息代表安装成功（可直接用以下配置进行连接）(以下配置在链接时使用)：

```bash
 ....准备安装了咯..看看有毛有配置正确了...

---------- 安装信息 -------------

 V2Ray 传输协议 = TCP

 V2Ray 端口 = 8888

 是否配置 Shadowsocks = 未配置

---------- END -------------
```

接下来会自动安装。

![image-20220129171629897](D:\Hugo_blog\static\images\image-20220129171629897.png)

安装完成后会显示当前安装的配置信息。

**相关命令：**

> `v2ray info` 查看 V2Ray 配置信息
> `v2ray config` 修改 V2Ray 配置
> `v2ray link` 生成 V2Ray 配置文件链接
> `v2ray infolink` 生成 V2Ray 配置信息链接
> `v2ray qr` 生成 V2Ray 配置二维码链接
> `v2ray ss` 修改 Shadowsocks 配置
> `v2ray ssinfo` 查看 Shadowsocks 配置信息
> `v2ray ssqr` 生成 Shadowsocks 配置二维码链接
> `v2ray status` 查看 V2Ray 运行状态
> `v2ray start` 启动 V2Ray
> `v2ray stop` 停止 V2Ray
> `v2ray restart` 重启 V2Ray
> `v2ray log` 查看 V2Ray 运行日志
> `v2ray update` 更新 V2Ray
> `v2ray update.sh` 更新 V2Ray 管理脚本
> `v2ray uninstall` 卸载 V2Ray

**vmess协议配置**

查看配置文件(**该配置在后面链接时使用**)：

```bash
cat /etc/v2ray/config.json
```