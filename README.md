<!--
 * @Author: holy
 * @Date: 2021-10-13 16:45:59
 * @LastEditTime: 2021-10-13 17:03:14
 * @LastEditors: holy
 * @Description: 
 * @FilePath: \hugo_blog\README.md
-->
# Hugo_blog

基于hugo搭建的个人博客

## 部署位置

腾讯云提供的静态网站托管服务


原博客地址[https://hoooooly.github.io](https://hoooooly.github.io)

新博客地址[https://holychan.ltd](https://holychan.ltd/)

## 安装tcb

### 安装 Node.js

如果本机没有安装 Node.js，请从 Node.js 官网下载二进制文件直接安装，建议选择 LTS 版本，版本必须为 8.6.0+。

### 安装 CloudBase CLI#
使用 NPM

```bash
npm i -g @cloudbase/cli
```

或使用 Yarn

```bash
yarn global add @cloudbase/cli
```

> 注意:如果 npm install -g @cloudbase/cli 失败，您可能需要修改 npm 权限，或者以系统管理员身份运行：

```bash
sudo npm install -g @cloudbase/cli
```

如果安装过程没有错误提示，一般就是安装成功了。下面，我们可以继续输入命令：

```bash
tcb -v
```

## 登录

在您的终端中输入下面的命令

```bash
tcb login
```

CloudBase CLI 会自动打开云开发控制台获取授权，您需要点击同意授权按钮允许 CloudBase CLI 获取授权。如您没有登录，您需要登录后才能进行此操作。