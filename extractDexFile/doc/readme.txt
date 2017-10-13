dex文件代码抽取工程

2017-11-12

版本1.0

当前版本，支持全量smali文件抽取代码抽取。

抽取依据：

根据当前应用包名做抽取

*******************************************************************
主要分析代码，删除方法体，添加native属性标志

注意：
1、忽略<clinit> <init> 对应的方法为
static{
//静态代码块
}
public A(){
//构造函数
}
2、忽略掉方法已经是native修饰函数

public native voud test();//忽略掉


3、忽略掉抽象属性方法
public abstract void test();



4、忽略接口类
public interface A{
public void test();
}

5、忽略掉方法体最小的方法


**************************




