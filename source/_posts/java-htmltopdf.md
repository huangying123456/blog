---
title: java-htmltopdf
date: 2018-10-26 12:01:38
category: 知识
tags: 
- 技术
- java 
---

<!--more-->

## 实现方式

### wkhtmltopdf
优点：
由于是基于 WebKit, 所以渲染结果和 Chrome( 包括其他基于 Chromium的浏览器几乎完全一致)
可以和前端公用一套 CSS 样式, 结果还是体验的一致性
支持大量的定制, 包括页头页脚, 页码, 目录等等
缺点：
一些框架网页支持不是很好，需要对页面样式进行调整，不然有可能会出现转出空白页面的情况。

官网地址：https://wkhtmltopdf.org
github地址：https://github.com/wkhtmltopdf/wkhtmltopdf

下载使用：官网有对应的windows、linux、macOs的安装包，下载安装后直接运行：

```
wkhtmltopdf http://google.com google.pdf
```

感觉使用这个需要对前端比较熟悉，不然感觉页面转不出来就会很着急，感觉是毫无办法。。


### itext

iText 是一个生成PDF文档的开源Java库，能够动态的从XML或者数据库生成PDF，同时还可以对文档进行加密，权限控制，并且还支持Java/C#等，但是iText本身提供的HTML解析器还是不够强大，许多HTML标签和属性无法识别，更悲催的是简单的CSS它不认识，排版调整样式让人头大。那么有没有什么方式能够支持css呢，又查阅到了 flying-saucer， flying-saucer也是导出PDF的一种解决方案，并且是基于iText的开源API，并且实现了CSS解析器，能够很好的支持CSS2.1，以及少量的CSS。

具体示例：
[flying-saucer + iText + Freemarker实现pdf的导出， 支持中文、css以及图片](https://www.cnblogs.com/youzhibing/p/7692366.html
)

[Spring Boot集成Freemarker和iText生成PDF文档](https://www.jianshu.com/p/069fcec0c8dd)

还有如果pdf中需要插入各种图表的话，可以考虑使用 ：**JFreeChart**
然后再转成图片插入页面中但是感觉要对这个使用的比较好，不然画出来的图各种吃藕。

这里有个老哥的具体demo示例项目：
[ iText+FreeMarker+JFreeChart生成可动态配置的PDF文档](https://github.com/superad/pdf-kit)

可能会出现的问题
1、设置页面大小
2、中文汉字显示问题
推荐博文 http://www.cnblogs.com/reese-blogs/p/5546806.html


