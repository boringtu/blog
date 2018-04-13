---
title: 'Hexo 博客搭建笔记'
subtitle: '(theme: Tranquilpeak)'
date: 2018-04-10 14:00:00
thumbnailImage: hexo-logo.png
thumbnailImagePosition: bottom
categories:
  - Technology
  - Blog
tags:
  - Technology
  - Blog
  - Hexo
  - Tranquilpeak
  - Gitment
keywords:
  - Blog
  - Hexo
  - Tranquilpeak
  - Gitment
---

<!-- toc -->

_**写在前面**：_
- _本人是以`hexo + hexo-theme-tranquilpeak`为基础搭建的博客，所以如果您套用的`theme`不是`tranquilpeak`，也许不太适合您，请摘对您有用的部分看；_
- _关于`hexo`以及`hexo-theme-tranquilpeak`的搭建，其实就看官方文档基本就足够了，我这里只记录了本人搭建过程中踩过的坑。_

<!-- more -->

## 目录系统
`Tranquilpeak`已经内置目录功能了，只需要在文章里指定位置写一句`<!-- toc -->`就可以了。

## more & excerpt
`<!-- more -->`与`<!-- excerpt -->`的区别
### 共同点
都是文章开头到标记位置之间的内容显示在主页上
### 不同点
- `<!-- more -->`: 文章正文正常显示（包括标记之前和之后的内容）
- `<!-- excerpt -->`: 文章正文会忽略文章开头一直到标记处的内容

## 评论系统（Gitment）

_废话可忽略：本来很想用`disqus`的，风格啥的都很喜欢，但毕竟在国内的盆友只能通过科学上网才能成功加载，虽然我的博客受众群体不会科学上网有点说不过去。。但。。我真的见过很多很多程序猴不会的。。甚是无奈。退而求其次，感觉就`Gitment`比较适合了。（如果你身为一个程序猴，连`GitHub`账号都没有。。可以。。考虑。。转行了。。吧。。囧rz）_

### 配置
配置文件：
``` shell
blog/themes/tranquilpeak/_config.yml
```
配置案例：
``` yml
# Your Gitment information
# Read https://github.com/imsun/gitment#get-started to setup Gitment
gitment:
    # Switch
    enable: true
    # Your Github ID (Github username):
    github_id: boringtu
    # The repo to store comments:
    repo: boringtu.github.io
    # Your client ID:
    client_id: *******************
    # Your client secret:
    client_secret: ***************************************
```
解读：
- `enable`要改成`true`（这不废话么。。）
- `github_id`自然就是字面意思，就是你的`GitHub`的`ID`
- `client_id`与`client_secret`是在`GitHub`提供的[New OAuth Application](https://github.com/settings/applications/new)页面成功注册之后得到的

### 各种`Error`
#### Error: Not Found
如果你确定你的`github_id`没写错，那么肯定就是`repo`写错了。我当时就是犯了这个错误。
拿我现在这个博客为例，我曾在`repo`这里试过：
- https://github.com/boringtu/boringtu.github.io
- git@github.com:boringtu/boringtu.github.io.git
都不行，后来网上搜了半天搜到了`Gitment`关于这个问题的[issue](https://github.com/imsun/gitment/issues/18)，发现`repo`只需要配成项目名就好了，比如：`boringtu.github.io`。

#### Error: Comments Not Initialized
每篇文章刚创建好`deploy`之后，评论区都会有这个提示，这是正常的，只要`Login`了就会看到让你初始化评论区的按钮，戳它就可以了。（前提是在你注册`OAuth Application`的时候，`callback URL`没写错~）

#### Error：validation failed
这个问题的出现，`99%`是因为`id`太长，`hexo`以及`tranquilpeak`的默认配置都是`id: 文章标题`，比如`tranquilpeak`：
``` shell
blog/themes/tranquilpeak/layout/_partial/script.ejs
```
``` ejs
...
id: '<%= post.permalink %>'
...
```
文章标题这个不方便也没有道理限制长度，所以我们可以把`id`改成其他的，比如很多人推荐的改成`文章日期`：
``` ejs
...
id: '<%= post.date %>'
...
```
**注意：如果这样配置的话，建议最好所有文章的`date`都精确到`秒`以下，毕竟`Gitment`是根据这个`id`来区分文章的。**

## 零碎的各种配置
### 订制css文件位置
``` shell
blog/themes/tranquilpeak/source/_css/themes/_hljs-custom.scss
```
但本人是`缩进党`，而且并不是很喜欢`{}`这种，所以相比`scss`我更喜欢`sass`，然后就把这个文件名改成了：`_hljs-custom.sass`
_放心改，没问题的，毕竟`sass`和`scss`是本家，而且引入这些文件的地方也没有强调后缀名。_
详见：
``` shell
blog/themes/tranquilpeak/source/_css/tranquilpeak.scss
```
再之后样式上想改些什么的话，只要有点前端基础，就都不是问题了，想咋改都成~

## References
- [(GitHub Documentation) - Tranquilpeak](https://github.com/LouisBarranqueiro/hexo-theme-tranquilpeak/blob/master/DOCUMENTATION.md)
- [(GitHub Documentation) - Gitment](https://github.com/imsun/gitment)
- [(GitHub Issue - Gitment) Error: Not Found](https://github.com/imsun/gitment/issues/18)
- [(GitHub Issue - Gitment) Error: Validation Failed](https://github.com/imsun/gitment/issues/118)

