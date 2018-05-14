---
title: Bash Shell 学习
date: 2017-12-13 15:54:36
tags:
- 学习
- shell
- linux命令
---

## 前言

记录学习shell脚本相关的知识。。。。

## shell简介

Shell本身是一个用C语言编写的程序，它是用户使用Unix/Linux的桥梁，用户的大部分工作都是通过Shell完成的。Shell既是一种命令语言，又是一种程序设计语言。作为命令语言，它交互式地解释和执行用户输入的命令；作为程序设计语言，它定义了各种变量和参数，并提供了许多在高级语言中才具有的控制结构，包括循环和分支。

它虽然不是Unix/Linux系统内核的一部分，但它调用了系统核心的大部分功能来执行程序、建立文件并以并行的方式协调各个程序的运行。因此，对于用户来说，shell是最重要的实用程序，深入了解和熟练掌握shell的特性极其使用方法，是用好Unix/Linux系统的关键。

<!--more-->

## 第一个shell脚本

感觉已经成为了一个习惯，第一个总是输出hello world，不论是c还是java还是其他什么编译型语言或者是解释型语言。就不扯其他的，来让我们打个招呼吧！

**代码：**

```
#!/bin/bash

echo hello world ！
```

**第一行说明：**

 #! 是说明 hello 这个文件的类型的，有点类似于 Windows 系统下用不同文件后缀来表示不同文件类型的意思（但不相同）。Linux 系统根据 "#!" 及该字串后面的信息确定该文件的类型，关于这一问题同学们回去以后可以通过 "man magic"命令 及 /usr/share/magic 文件来了解这方面的更多内容。在 BASH 中 第一行的 "#!" 及后面的 "/bin/bash" 就表明该文件是一个 BASH 程序，需要由 /bin 目录下的 bash 程序来解释执行。BASH 这个程序一般是存放在 /bin 目录下，如果你的 Linux 系统比较特别，bash 也有可能被存放在 /sbin 、/usr/local/bin 、/usr/bin 、/usr/sbin 或 /usr/local/sbin 这样的目录下；如果还找不到，你可以用 "locate bash" "find / -name bash 2> /dev/null" 或 "whereis bash" 这三个命令找出 bash 所在的位置；如果仍然找不到，那你可能需要自己动手安装一个 BASH 软件包了。

### 如何执行shell脚本

**方法一**

```
chmod +x ./test.sh  #使脚本具有执行权限
./test.sh           #执行脚本
```

**方法二**

`sh test.sh / bash test.sh`

## 变量

### 1 定义变量

定义变量时，如：
`variableName="value"`
注意，变量名和等号之间不能有空格，这可能和你熟悉的所有编程语言都不一样。同时，变量名的命名须遵循如下规则：

- 首个字符必须为字母（a-z，A-Z）。
- 中间不能有空格，可以使用下划线（_）。
- 不能使用标点符号。
- 不能使用bash里的关键字（可用help命令查看保留关键字）。

### 2 使用变量

使用一个定义过的变量，只要在变量名前面加美元符号（$）即可，如：

```
your_name="mozhiyan"
echo $your_name
echo ${your_name}       # {}可以使用也可以不用，其作用是区分边界的。推荐一般加上
```
### 3 只读变量

使用 readonly 命令可以将变量定义为只读变量，只读变量的值不能被改变。

**栗子：**

```
#!/bin/bash
name="tom"
readonly name
name="jerry"
```
运行脚本，结果如下：

```
/bin/sh: NAME: This variable is read only.
```

### 4 删除变量
　　
使用 unset 命令可以删除变量。语法：

`unset variable_name`

### 5 特殊变量   

前面已经讲到，变量名只能包含数字、字母和下划线，因为某些包含其他字符的变量有特殊含义，这样的变量被称为特殊变量。

**特殊变量列表**

| 变量 | 含义 |
| --- | --- |
| $0 | 当前脚本的文件名 |
| $n | 传递给脚本或函数的参数。n 是一个数字，表示第几个参数。例如，第一个参数是1，第二个参数2。|
| $# | 传递给脚本或函数的参数个数。 |
| $* | 传递给脚本或函数的所有参数。 |
| $@ | 传递给脚本或函数的所有参数，被双引号""包含时和未被包含时有不同，详情见下 |
| $? | 上个命令的退出状态，或函数的返回值。 |
| $$ | 当前Shell进程ID。对于 Shell 脚本，就是这些脚本所在的进程ID。 |

**说明：**
* 和@都是表示传递给函数或脚本的所有参数，不被双引号“”包含时，各个参数都是分开的形式输出。而当被包含时，* 会将所有的参数作为一个整体，而@还是会不变

**栗子**

执行 ./test.sh "a" "b" "c" "d"，看到下面的结果：

```
#！/bin/bash

$*=  a b c d
"$*"= a b c d
$@=  a b c d
"$@"= a b c d

print each param from $*
a
b
c
d
print each param from $@
a
b
c
d
print each param from "$*"
a b c d
print each param from "$@"
a
b
c
d
```

## 替换

如果表达式中包含特殊字符，Shell 将会进行替换。例如，在双引号中使用变量就是一种替换，转义字符也是一种替换。
举个例子：

```
#!/bin/bash
a=10
echo -e "Value of a is $a \n"
```

运行结果：

`Value of a is 10`

这里 -e 表示对转义字符进行替换。如果不使用 -e 选项，将会原样输出：

`Value of a is 10\n`

下面的转义字符都可以用在 echo 中：

| 转义字符 | 含义 |
| --- | --- |
| \\	| 反斜杠 |
| \a	| 警报，响铃 |
| \b	| 退格（删除键）|
| \f	| 换页(FF)，将当前位置移到下页开头 |
| \n	| 换行 |
| \r	| 回车 |
| \t	| 水平制表符（tab键）| 
| \v	| 垂直制表符 |

可以使用 echo 命令的 -E 选项禁止转义，默认也是不转义的；使用 -n 选项可以禁止插入换行符。

### 变量替换


变量替换可以根据变量的状态（是否为空、是否定义等）来改变它的值。

可以使用的变量替换形式：

| 转义字符 | 含义 |
| --- | --- |
| ${var}	 | 变量本来的值 |
| ${var:-word}	 | 如果变量 var 为空或已被删除(unset)，那么返回 word，但不改变 var 的值。 |
| ${var:=word}	 | 如果变量 var 为空或已被删除(unset)，那么返回 word，并将 var 的值设置为 word。 |
| ${var:?message}	 | 如果变量 var 为空或已被删除(unset)，那么将消息 message 送到标准错误输出，可以用来检测变量 var 是否可以被正常赋值。若此替换出现在Shell脚本中，那么脚本将停止运行。 |
| ${var:+word}	 | 如果变量 var 被定义，那么返回 word，但不改变 var 的值。 |

## 运算符

Bash支持很多运算符，包括算数运算符、关系运算符、布尔运算符、字符串运算符和文件测试运算符。
原生bash不支持简单的数学运算，但是可以通过其他命令来实现，例如 awk 和 expr，expr 最常用。
expr 是一款表达式计算工具，使用它能完成表达式的求值操作。

### 算术运算符

贴上一个加法，其他的都大同小异
例如，两个数相加：

```
#!/bin/bash

a=10
b=20

value=`expr $a + $b`
echo "a + b : $value"
```

注意：

- 表达式和运算符之间要有空格，例如 2+2 是不对的，必须写成 2 + 2，这与我们熟悉的大多数编程语言不一样。
- 完整的表达式要被 ` ` 包含，注意这个字符不是常用的单引号，在 Esc 键下边。
- 乘号(*)前边必须加反斜杠(\)才能实现乘法运算。

### 关系运算符


| 操作描述 | 整数操作 | 字符串操作 |
| --- | --- | --- |
| 相同 | -eq | = |
| 不同 | -ne | !=  |
| 大于 | -gt | > |
| 小于 | -lt | < |
| 大于或等于 | -ge |  |
| 小于或等于 | -le |  |
| 为空 |  | -z |
| 不为空 |  | -n |

### 文件测试运算符

| 操作符 | 说明 |
| --- | --- |
| -b file	检测文件是否是块设备文件，如果是，则返回 true。 |
| -c file	| 检测文件是否是字符设备文件，如果是，则返回 true。 |
| -d file	| 检测文件是否是目录，如果是，则返回 true。 |
| -f file	| 检测文件是否是普通文件（既不是目录，也不是设备文件），如果是，则返回 true。 |
| -g file	| 检测文件是否设置了 SGID 位，如果是，则返回 true。 |
| -k file	| 检测文件是否设置了粘着位(Sticky Bit)，如果是，则返回 true。 |
| -p file	| 检测文件是否是具名管道，如果是，则返回 true。 |
| -u file	| 检测文件是否设置了 SUID 位，如果是，则返回 true。 |
| -r file	| 检测文件是否可读，如果是，则返回 true。 |
| -w file	| 检测文件是否可写，如果是，则返回 true。 |
| -x file	| 检测文件是否可执行，如果是，则返回 true。 |
| -s file	| 检测文件是否为空（文件大小是否大于0），不为空返回 true。 |
| -e file	| 检测文件（包括目录）是否存在，如果是，则返回 true。 |

## 流程控制

### if...then...else

if 语句通过关系运算符判断表达式的真假来决定执行哪个分支。Shell 有三种 if ... else 语句：

- if ... fi 语句；
- if ... else ... fi 语句；
- if ... elif ... else ... fi 语句。

if ... else 语句的语法：
if [ expression ]
then
   Statement(s) to be executed if expression is true
fi

### for

for循环一般格式为：
for 变量 in 列表
do
    command1
    command2
    ...
    commandN
done

### while

while循环用于不断执行一系列命令，也用于从输入文件中读取数据；命令通常为测试条件。其格式为：
while command
do
   Statement(s) to be executed if command is true
done

### until

until 循环执行一系列命令直至条件为 true 时停止。until 循环与 while 循环在处理方式上刚好相反。一般while循环优于until循环，但在某些时候，也只是极少数情况下，until 循环更加有用。
　　until 循环格式为：
until command
do
   Statement(s) to be executed until command is true
done
　　command 一般为条件表达式，如果返回值为 false，则继续执行循环体内的语句，否则跳出循环。
　　
### case

case 语句匹配一个值或一个模式，如果匹配成功，执行相匹配的命令。case语句格式如下：
　　case 值 in
模式1)
    command1
    command2
    command3
    ;;
模式2）
    command1
    command2
    command3
    ;;
*)
    command1
    command2
    command3
    ;;
esac
　　case工作方式如上所示。取值后面必须为关键字 in，每一模式必须以右括号结束。取值可以为变量或常数。匹配发现取值符合某一模式后，其间所有命令开始执行直至 ;;。;; 与其他语言中的 break 类似，意思是跳到整个 case 语句的最后。
　　取值将检测匹配的每一个模式。一旦模式匹配，则执行完匹配模式相应命令后不再继续其他模式。如果无一匹配模式，使用星号 * 捕获该值，再执行后面的命令。

## 重定向

一般情况下，每个 Unix/Linux 命令运行时都会打开三个文件：

- 标准输入文件(stdin)：stdin的文件描述符为0，Unix程序默认从stdin读取数据。
- 标准输出文件(stdout)：stdout 的文件描述符为1，Unix程序默认向stdout输出数据。
- 标准错误文件(stderr)：stderr的文件描述符为2，Unix程序会向stderr流中写入错误信息。

默认情况下，command > file 将 stdout 重定向到 file，command < file 将stdin 重定向到 file。

如果希望 stderr 重定向到 file，可以这样写：
`$command 2 > file`

如果希望 stderr 追加到 file 文件末尾，可以这样写：
`$command 2 >> file`
2 表示标准错误文件(stderr)。

如果希望将 stdout 和 stderr 合并后重定向到 file，可以这样写：

```
$command > file 2>&1
　　或
$command >> file 2>&1
```
如果希望对 stdin 和 stdout 都重定向，可以这样写：
`$command < file1 >file2`
command 命令将 stdin 重定向到 file1，将 stdout 重定向到 file2。
 
全部可用的重定向命令列表

| 命令 | 含义 |
| --- | --- |
| command > file	| 将输出重定向到 file。 |
| command < file	| 将输入重定向到 file。 |
| command >> file	 | 将输出以追加的方式重定向到 file。 |
| n > file	| 将文件描述符为 n 的文件重定向到 file。 |
| n >> file	 | 将文件描述符为 n 的文件以追加的方式重定向到 file。 |
| n >& m	 | 将输出文件 m 和 n 合并。 |
| n <& m	 | 将输入文件 m 和 n 合并。 |
| << tag	 | 将开始标记 tag 和结束标记 tag 之间的内容作为输入。 |

## 函数使用

函数可以让我们将一个复杂功能划分成若干模块，让程序结构更加清晰，代码重复利用率更高。像其他编程语言一样，Shell 也支持函数。Shell 函数必须先定义后使用。
　　Shell 函数的定义格式如下：
function_name () {
    list of commands
    [ return value ]
}
　　如果你愿意，也可以在函数名前加上关键字 function：
function function_name () {
    list of commands
    [ return value ]
}
　　函数返回值，可以显式增加return语句；如果不加，会将最后一条命令运行结果作为返回值。
　　Shell 函数返回值只能是整数，一般用来表示函数执行成功与否，0表示成功，其他值表示失败。如果 return 其他数据，比如一个字符串，往往会得到错误提示：“numeric argument required”。
　　如果一定要让函数返回字符串，那么可以先定义一个变量，用来接收函数的计算结果，脚本在需要的时候访问这个变量来获得函数返回值。
　　
### 函数参数传递

在Shell中，调用函数时可以向其传递参数。在函数体内部，通过 n的形式来获取参数的值，例如，1表示第一个参数，$2表示第二个参数...
带参数的函数示例：

```
#!/bin/bash
funWithParam(){
echo "The value of the first parameter is $1 !"
echo "The value of the second parameter is $2 !"
echo "The value of the tenth parameter is $10 !"
echo "The value of the tenth parameter is ${10} !"
echo "The value of the eleventh parameter is ${11} !"
echo "The amount of the parameters is $# !" # 参数个数
echo "The string of the parameters is $* !" # 传递给函数的所有参数
}
funWithParam 1 2 3 4 5 6 7 8 9 34 73
```
　　
**栗子**


```
#!/bin/bash
Hello () {
value=111
echo "$value"
return $value
}
# Invoke your function
Hello
ret=$?
echo "value is $ret"
```

说明：
**返回值是字符串的话，貌似不行？ 待确认，或许有其他办法**
确认： BASH 要求返回值必须为一个整数，不能用 return 语句返回字符串变量

## 在 BASH 中读取用户输入

BASH 中通过 read 函数来实现读取用户输入的功能，如下面这段程序：

```
#!/bin/bash
echo Please enter your name
read NAME 
echo "Hi! $NAME !"

exit 0
```

## BASH 程序的调试

用 bash -x bash-script 命令，可以查看一个出错的 BASH 脚本到底错在什么地方，可以帮助程序员找出脚本中的错误。
另外用 trap 语句可以在 BASH 脚本出错退出时打印出一些变量的值，以供程序员检查。trap 语句必须作为继 "#!/bin/bash" 后的第一句非注释代码，一般 trap 命令被写作： trap 'message $checkvar1 $checkvar2' EXIT 。

**相关链接：**

[基础-讲的比较详细](https://www.cnblogs.com/maybe2030/p/5022595.html#_label20)

[基础入门-讲的比较粗](http://blog.chinaunix.net/uid-25932176-id-2973818.html)


