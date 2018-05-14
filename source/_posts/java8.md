---
title: java8
date: 2017-12-02 15:32:14
category: 知识
tags: 
- 技术
- java
---

## 新特性

Java8 新增了非常多的特性，主要有以下几个：

- **Lambda 表达式** − Lambda允许把函数作为一个方法的参数（函数作为参数传递进方法中。
- **方法引用** − 方法引用提供了非常有用的语法，可以直接引用已有Java类或对象（实例）的方法或构造器。与lambda联合使用，方法引用可以使语言的构造更紧凑简洁，减少冗余代码。
- **默认方法** − 默认方法就是一个在接口里面有了一个实现的方法。
- **新工具** − 新的编译工具，如：Nashorn引擎 jjs、 类依赖分析器jdeps。
- **Stream API** −新添加的Stream API（java.util.stream） 把真正的函数式编程风格引入到Java中。
- **Date Time API** − 加强对日期与时间的处理。
- **Optional 类** − Optional 类已经成为 Java 8 类库的一部分，用来解决空指针异常。
- **Nashorn, JavaScript 引擎** − Java 8提供了一个新的Nashorn javascript引擎，它允许我们在JVM上运行特定的javascript应用。

<!--more-->

## Lambda 表达式

Lambda 允许把函数作为一个方法的参数（函数作为参数传递进方法中）。

### 语法

lambda 表达式的语法格式如下：

```
(parameters) -> expression
或
(parameters) ->{ statements; }
```
以下是lambda表达式的重要特征:

- 可选类型声明：不需要声明参数类型，编译器可以统一识别参数值。
- 可选的参数圆括号：一个参数无需定义圆括号，但多个参数需要定义圆括号。
- 可选的大括号：如果主体包含了一个语句，就不需要使用大括号。
- 可选的返回关键字：如果主体只有一个表达式返回值则编译器会自动返回值，大括号需要指定明表达式返回了一个数值。

### 变量作用域
lambda 表达式只能引用标记了 final 的外层局部变量，这就是说不能在 lambda 内部修改定义在域外的局部变量，否则会编译错误。

## stream api

### 什么是 Stream？

Stream（流）是一个来自数据源的元素队列并支持聚合操作

1. 元素是特定类型的对象，形成一个队列。 Java中的Stream并不会存储元素，而是按需计算。
2. 数据源 流的来源。 可以是集合，数组，I/O channel， 产生器generator 等。
3. 聚合操作 类似SQL语句一样的操作， 比如filter, map, reduce, find, match, sorted等。

和以前的Collection操作不同， Stream操作还有两个基础的特征：

- Pipelining: 中间操作都会返回流对象本身。 这样多个操作可以串联成一个管道， 如同流式风格（fluent style）。 这样做可以对操作进行优化， 比如延迟执行(laziness)和短路( short-circuiting)。
- 内部迭代： 以前对集合遍历都是通过Iterator或者For-Each的方式, 显式的在集合外部进行迭代， 这叫做外部迭代。 Stream提供了内部迭代的方式， 通过访问者模式(Visitor)实现。

### 实例

#### forEach
Stream 提供了新的方法 'forEach' 来迭代流中的每个数据。以下代码片段使用 forEach 输出了10个随机数：

```
Random random = new Random();
random.ints().limit(10).forEach(System.out::println);
```
#### map
map 方法用于映射每个元素到对应的结果，以下代码片段使用 map 输出了元素对应的平方数：
List<Integer> numbers = Arrays.asList(3, 2, 2, 3, 7, 3, 5);
// 获取对应的平方数

```
List<Integer> squaresList = numbers.stream().map( i -> i*i).distinct().collect(Collectors.toList());
```
#### flatMap
和map类似，不同的是其每个元素转换得到的是Stream对象，会把子Stream中的元素压缩到父集合中。
如理所示，将stream中的所有的list中的元素取出直接放入了stream中：

```
Stream<List<Integer>> inputStream = Stream.of(
 Arrays.asList(1),
 Arrays.asList(2, 3),
 Arrays.asList(4, 5, 6)
 );
 
 # flatMap方法
Stream<Integer> outputStream = inputStream.
flatMap((childList) -> childList.stream());
```

#### filter
filter 方法用于通过设置的条件过滤出元素。以下代码片段使用 filter 方法过滤出空字符串：

```
List<String>strings = Arrays.asList("abc", "", "bc", "efg", "abcd","", "jkl");
// 获取空字符串的数量
int count = strings.stream().filter(string -> string.isEmpty()).count();
```

#### limit
对一个Stream进行截断操作，获取其前N个元素，如果原Stream中包含的元素个数小于N，那就获取其所有的元素。
以下代码片段使用 limit 方法打印出 10 条数据：

```
Random random = new Random();
random.ints().limit(10).forEach(System.out::println);
```
#### skip
和limit相反，返回一个丢弃原Stream的前N个元素后剩下元素组成的新Stream，如果原Stream中包含的元素个数小于N，那么返回空Stream；

#### sorted
sorted 方法用于对流进行排序。以下代码片段使用 sorted 方法对输出的 10 个随机数进行排序：

```
Random random = new Random();
random.ints().limit(10).sorted().forEach(System.out::println);
```

#### 并行（parallel）程序
parallelStream 是流并行处理程序的代替方法。以下实例我们使用 parallelStream 来输出空字符串的数量：

```
List<String> strings = Arrays.asList("abc", "", "bc", "efg", "abcd","", "jkl");
// 获取空字符串的数量
int count = strings.parallelStream().filter(string -> string.isEmpty()).count();
```
我们可以很容易的在顺序运行和并行直接切换。

#### Collectors
Collectors 类实现了很多归约操作，例如将流转换成集合和聚合元素。Collectors 可用于返回列表或字符串：

```
List<String>strings = Arrays.asList("abc", "", "bc", "efg", "abcd","", "jkl");
List<String> filtered = strings.stream().filter(string -> !string.isEmpty()).collect(Collectors.toList());
 
System.out.println("筛选列表: " + filtered);
String mergedString = strings.stream().filter(string -> !string.isEmpty()).collect(Collectors.joining(", "));
System.out.println("合并字符串: " + mergedString);
```
#### 统计
另外，一些产生统计结果的收集器也非常有用。它们主要用于int、double、long等基本类型上，它们可以用来产生类似如下的统计结果。

```
List<Integer> numbers = Arrays.asList(3, 2, 2, 3, 7, 3, 5);
 
IntSummaryStatistics stats = integers.stream().mapToInt((x) -> x).summaryStatistics();
 
System.out.println("列表中最大的数 : " + stats.getMax());
System.out.println("列表中最小的数 : " + stats.getMin());
System.out.println("所有数之和 : " + stats.getSum());
System.out.println("平均数 : " + stats.getAverage());
```

## 方法引用

方法引用通过方法的名字来指向一个方法。
方法引用可以使语言的构造更紧凑简洁，减少冗余代码。
方法引用使用一对冒号 :: 。
下面，我们在 Car 类中定义了 4 个方法作为例子来区分 Java 中 4 种不同方法的引用。


```
@FunctionalInterface
public interface Supplier<T> {
    T get();
}
 
class Car {
    //Supplier是jdk1.8的接口，这里和lamda一起使用了
    public static Car create(final Supplier<Car> supplier) {
        return supplier.get();
    }
 
    public static void collide(final Car car) {
        System.out.println("Collided " + car.toString());
    }
 
    public void follow(final Car another) {
        System.out.println("Following the " + another.toString());
    }
 
    public void repair() {
        System.out.println("Repaired " + this.toString());
    }
}
```

* **构造器引用：**它的语法是Class::new，或者更一般的Class< T >::new实例如下：

```
final Car car = Car.create( Car::new );
final List< Car > cars = Arrays.asList( car );
```

* **静态方法引用**：它的语法是Class::static_method，实例如下：

```
cars.forEach( Car::collide );
```

* **特定类的任意对象的方法引用**：它的语法是Class::method实例如下：

```
cars.forEach( Car::repair );
```

* **特定对象的方法引用**：它的语法是instance::method实例如下：

```
final Car police = Car.create( Car::new );
cars.forEach( police::follow );
```

## 默认方法

**什么是默认方法**
简单说，默认方法就是接口可以有实现方法，而且不需要实现类去实现其方法。
我们只需在方法名前面加个default关键字即可实现默认方法。

**为什么要有这个特性？**
首先，之前的接口是个双刃剑，好处是面向抽象而不是面向具体编程，缺陷是，当需要修改接口时候，需要修改全部实现该接口的类，目前的java 8之前的集合框架没有foreach方法，通常能想到的解决办法是在JDK里给相关的接口添加新的方法及实现。然而，对于已经发布的版本，是没法在给接口添加新方法的同时不影响已有的实现。所以引进的默认方法。他们的目的是为了解决接口的修改与现有的实现不兼容的问题。

**实例**

```
public class Java8Tester {
   public static void main(String args[]){
      Vehicle vehicle = new Car();
      vehicle.print();
   }
}
 
interface Vehicle {
   default void print(){
      System.out.println("我是一辆车!");
   }
   
   # 静态方法
   static void blowHorn(){
      System.out.println("按喇叭!!!");
   }
}
 
interface FourWheeler {
   default void print(){
      System.out.println("我是一辆四轮车!");
   }
}
 
class Car implements Vehicle, FourWheeler {
   public void print(){
      Vehicle.super.print();    # 默认方法调用
      FourWheeler.super.print();    
      Vehicle.blowHorn();   # 静态方法调用
      System.out.println("我是一辆汽车!");
   }
   # 重写默认方法
   default void print(){
      System.out.println("我是一辆普通的五菱宏光车!");
   }
}
```

## Java 8 函数式接口

函数式接口(Functional Interface)就是一个具有一个方法的普通接口。
函数式接口可以被隐式转换为lambda表达式。
函数式接口可以现有的函数友好地支持 lambda。
JDK 1.8之前已有的函数式接口:
java.lang.Runnable
java.util.concurrent.Callable
java.security.PrivilegedAction
java.util.Comparator
java.io.FileFilter
java.nio.file.PathMatcher
java.lang.reflect.InvocationHandler
java.beans.PropertyChangeListener
java.awt.event.ActionListener
javax.swing.event.ChangeListener

JDK 1.8 新增加的函数接口：
java.util.function

java.util.function 它包含了很多类，用来支持 Java的 函数式编程，该包中的函数式接口有：
[链接](http://www.runoob.com/java/java8-functional-interfaces.html)

## Date Time API

Java 8通过发布新的Date-Time API (JSR 310)来进一步加强对日期与时间的处理。
在旧版的 Java 中，日期时间 API 存在诸多问题，其中有：

- 非线程安全 − java.util.Date 是非线程安全的，所有的日期类都是可变的，这是Java日期类最大的问题之一。
- 设计很差 − Java的日期/时间类的定义并不一致，在java.util和java.sql的包中都有日期类，此外用于格式化和解析的类在java.text包中定义。java.util.Date同时包含日期和时间，而java.sql.Date仅包含日期，将其纳入java.sql包并不合理。另外这两个类都有相同的名字，这本身就是一个非常糟糕的设计。
- 时区处理麻烦 − 日期类并不提供国际化，没有时区支持，因此Java引入了java.util.Calendar和java.util.TimeZone类，但他们同样存在上述所有的问题。

Java 8 在 java.time 包下提供了很多新的 API。以下为两个比较重要的 API：

- Local(本地) − 简化了日期时间的处理，没有时区的问题。
- Zoned(时区) − 通过制定的时区处理日期时间。

### 本地化日期时间 API 实例

```
public class Java8Tester {
   public static void main(String args[]){
      Java8Tester java8tester = new Java8Tester();
      java8tester.testLocalDateTime();
   }
    
   public void testLocalDateTime(){
    
      // 获取当前的日期时间
      LocalDateTime currentTime = LocalDateTime.now();
      System.out.println("当前时间: " + currentTime);
        
      LocalDate date1 = currentTime.toLocalDate();
      System.out.println("date1: " + date1);
        
      Month month = currentTime.getMonth();
      int day = currentTime.getDayOfMonth();
      int seconds = currentTime.getSecond();
        
      System.out.println("月: " + month +", 日: " + day +", 秒: " + seconds);
        
      LocalDateTime date2 = currentTime.withDayOfMonth(10).withYear(2012);
      System.out.println("date2: " + date2);
        
      // 12 december 2014
      LocalDate date3 = LocalDate.of(2014, Month.DECEMBER, 12);
      System.out.println("date3: " + date3);
        
      // 22 小时 15 分钟
      LocalTime date4 = LocalTime.of(22, 15);
      System.out.println("date4: " + date4);
        
      // 解析字符串
      LocalTime date5 = LocalTime.parse("20:15:30");
      System.out.println("date5: " + date5);
   }
}
```

### 使用时区的日期时间API
如果我们需要考虑到时区，就可以使用时区的日期时间API： 

```
public class Java8Tester {
   public static void main(String args[]){
      Java8Tester java8tester = new Java8Tester();
      java8tester.testZonedDateTime();
   }
    
   public void testZonedDateTime(){
    
      // 获取当前时间日期
      ZonedDateTime date1 = ZonedDateTime.parse("2015-12-03T10:15:30+05:30[Asia/Shanghai]");
      System.out.println("date1: " + date1);
        
      ZoneId id = ZoneId.of("Europe/Paris");
      System.out.println("ZoneId: " + id);
        
      ZoneId currentZone = ZoneId.systemDefault();
      System.out.println("当期时区: " + currentZone);
   }
}
```
## Optional 类

Optional 类是一个可以为null的容器对象。如果值存在则isPresent()方法会返回true，调用get()方法会返回该对象。
Optional 是个容器：它可以保存类型T的值，或者仅仅保存null。Optional提供很多有用的方法，这样我们就不用显式进行空值检测。
Optional 类的引入很好的解决空指针异常

[Optional 具体类方法](http://www.runoob.com/java/java8-optional-class.html)

## Nashorn, JavaScript 引擎
 
Nashorn 一个 javascript 引擎。
从JDK 1.8开始，Nashorn取代Rhino(JDK 1.6, JDK1.7)成为Java的嵌入式JavaScript引擎。Nashorn完全支持ECMAScript 5.1规范以及一些扩展。它使用基于JSR 292的新语言特性，其中包含在JDK 7中引入的 invokedynamic，将JavaScript编译成Java字节码。
与先前的Rhino实现相比，这带来了2到10倍的性能提升。


