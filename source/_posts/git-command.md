---
title: git使用命令
date: 2018-10-30 17:29:04
tags: git
---

感觉平时虽然一直在使用git，但是自己使用的命令还是比较单一，有时候需要用到某个操作的时候，还是要去查找命令，所以这里做一个简单的记录。

先贴一个感觉比较全的链接：[常用 Git 命令清单](http://www.ruanyifeng.com/blog/2015/12/git-cheat-sheet.html)

下面是自己使用到的一一些

<!--more-->
## 分支


```
git branch      列出所有本地分支
        -a      列出所有本地分支和远程分支
        -r      列出所有远程分支     
        -vv     列出本地分支并能有与远程分支的追踪关系
```

#### 新建分支

新建一个分支，但依然停留在当前分支
`git branch [branch]  `

新建一个分支，并切换到该分支
`git checkout -b [branch]`

从远程分支新建本地分支
`git checkout -b [branch] [origin/branch]`    

#### 切换分支

`git checkout [branch]`

#### 删除分支

删除本地分支
`git branch -d [branch-name]` 

删除远程分支

```
git push origin --delete [branch-name]
git branch -dr [remote/branch]
```

#### 合并分支

合并指定分支到当前分支

`git merge [branch] ` 

#### 关联本地分支和远程分支

无论之前本地分支是否和远程分支关联都可以使用该命令
`git branch --set-upstream [branch] origin/[branch]`


.....未完待续

