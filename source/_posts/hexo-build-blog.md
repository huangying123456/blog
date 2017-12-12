---
title: 使用hexo、github搭建个人博客
date: 2017-12-01 17:06:55
tags:
- 技术
---

## 环境支持

- node.js
- 安装git，申请github个人账号
- 安装hexo

安装node.js
地址：[node.js官网](https://nodejs.org/en/)

安装hexo
node.js安装好了之后，可以直接执行命令

```
 sudo npm install -g hexo
```

<!--more-->

## 默认实现



### 本地实现

新建一个文件夹 blog

初始化，直接执行命令

```
hexo init
```
生成静态页面

```
hexo generate（hexo g也可以）
```

本地启动

启动本地服务，进行文章预览调试，命令：


```
hexo server
```
启动配置在_config.yml文件中
```
port: 4000
server_ip: localhost
```
浏览器输入http://localhost:4000，这是便能访问一个默认模板的博客。

### 配置部署到github

建立Repository

建立与你用户名对应的仓库，仓库名必须为【your_user_name.github.io】

现在我们需要_config.yml文件，来建立关联，命令：


```
vim _config.yml
```
打开config.yml后添加下面代码
```
deploy:
  type: git
  repo: https://github.com/you_user_name/you_user_name.github.io.git
  branch: master
```
然后执行命令：

```
npm install hexo-deployer-git --save

```
最后执行命令进行部署：

```
hexo deploy （hexo d）
```
执行成功之后访问http://you_user_name.github.io，就可以访问线上的博客了。

### 修改博客模板
个人有个人的爱好，可以自己找找，不过感觉特别惊艳的我反正没看见。
 [前十的一个链接](https://en.abnerchou.me/Blog/5c00ca67/)
 选择好模板之后，在你blog的根目录进行clone，一般模板都会有教程，clone 之后记得更新，最后修改根目录下的_config.yml，
 
```
theme: yilia  #主题
```
嗯，我用的这个主题。


## 插件功能

### 评论

说明：
1. 畅言（需要网站审核，排除）
2. 多说（不提供服务了）
3. 还有一些就不说了，最后选了gitment

[基于github issues 搭建评论系统](https://imsun.net/posts/gitment-introduction/)

个人实现是根据这篇的，因为自己使用的是yilia模板，而且这个实现很较简单：
http://blog.csdn.net/q_qtowerq_q/article/details/78565166


## 绑定个人域名

1. 搞个域名
2. 在博客根目录下添加CANCEL文件，将自己的域名写入这个文件

这里有一篇比较详细的博客,最后是讲域名配置的：[在GithubPages上搭建个人主页](http://blog.csdn.net/yanzhenjie1003/article/details/51703370)

说明： 解决每次部署的时候CNAME文件消失，
最好的解决办法，在你博客源码的source目录下添加CNAME，相当于每次部署都会去自动生成一次。



## 如何让自己的博客在搜索引擎中搜到

[hexo高阶教程：想让你的博客被更多的人在搜索引擎中搜到吗？](http://blog.csdn.net/sunshine940326/article/details/70936988)

## hexo自动部署

[hexo监听git push 实现自动部署](https://segmentfault.com/a/1190000006745478)

## hexo相关命令


```
hexo init 初始化
hexo new "postName" #新建文章
hexo new page "pageName" #新建页面
hexo generate #生成静态页面至public目录
hexo server #开启预览访问端口（默认端口4000，'ctrl + c'关闭server）
hexo deploy #将.deploy目录部署到GitHub
hexo help  # 查看帮助
hexo version  #查看Hexo的版本
hexo deploy -g  #生成加部署
hexo server -g  #生成加预览
命令的简写
hexo n == hexo new
hexo g == hexo generate
hexo s == hexo server
hexo d == hexo deploy

```


