---
title: ssh-key 
date: 2018-05-31 15:31:01
tags:
- 工具
---

## 前言

使用ssh key的目的是使得两台机器之间建立互信，从其中一台登陆到另一台时不需要密码。例如使用git时，配置好了ssh key 每次连接时就不需要密码了，非常的方便实用。

<!--more-->

## 生成ssh hey

**1、 检查是否已经存在ssh key**

通常sshkey会默认生成在用户家目录下，所以查看家目录下是否存在.ssh 文件夹，以及是否存在相关目录就行。（~/.ssh/id_rsa）

**2、生成ssh key**

输入命令：


```
ssh-keygen -t rsa -C "youremail@example.com"
```

密钥类型可以用 -t 选项指定。如果没有指定则默认生成用于SSH-2的RSA密钥。这里使用的是rsa。

同时在密钥中有一个注释字段，用-C来指定所指定的注释，可以方便用户标识这个密钥，指出密钥的用途或其他有用的信息。所以在这里输入自己的邮箱或者其他都行。

输入完毕后程序同时要求输入一个密语字符串(passphrase)，一般默认直接enter 跳过，这样后面使用的时候也不用再输入密码。


## ssh key 使用

**1、连接github**

登录github。打开setting->SSH keys，点击右上角 New SSH key，把生成好的公钥id_rsa.pub放进 key输入框中，再为当前的key起一个title来区分每个key。

**2、连接远程服务器**

首先登陆到远程服务器，然后将公钥放入服务器的认证列表中，即 ~/.ssh/authorized_keys。
有可能该目录及文件不存在，则需要我们先新建

```
mkdir .ssh  //创建文件夹
cd .ssh  //切换到该目录下
vim authorized_keys  // 创建文件
```
最后将公钥copy到 authorized_keys 文件中。

配置文笔后，本地登陆远程服务器命令

```
ssh test@127.0.0.1 -p 8080 -i ~/.ssh/id_rsa
```

![命令说明](https://upload-images.jianshu.io/upload_images/1727535-e14090ea44b0a9c6.jpg)

但是这样看起来登陆命令也是蛮麻烦的，最后可以将一些配置加入到.ssh/config 中

```
Host test
    Hostname 47.94.162.200
    User hy
    Port 8080
    IdentityFile ~/.ssh/id_rsa
```
HostName： 是目标主机的主机名，也就是平时我们使用ssh后面跟的地址名称。

Port：指定的端口号。

User：指定的登陆用户名。

IdentifyFile：指定的私钥地址。
最后登陆

```
ssh test
```


