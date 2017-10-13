#-*- coding:UTF-8 -*-
'''
author:Loopher
date:2017-10-12

代码分析器：

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


5、匿名内部类的问题

'''
import constrant
import re
import os
from log import log
import fileutils

interface_class_reg_str ='.* (interface).*'

native_method_reg_str='.* (native).*'
abstract_method_reg_str='.* (abstract).*'
constructor_reg_str='.* (<init>).*'
static_method_reg_str='.* (<clinit>).*'

def modifySmaliFileMethod(file):
	try:

		#读取内容，同时写文件
		tmp=os.path.split(file)
		filename = tmp[1]
		fd = open(file, 'r')
		lines = fd.readlines()
		tmpFile=tmp[0]+os.sep+"_tmp_"+tmp[1]
		outfd = open(tmpFile,'w')
		isInterFaceClass =False
		isAddMethod = True
		for line in lines:
			if isInterfaceClass(line):
				# log.log_print('**********************************')
				# log.log_print("******* found interface class ***  ",log.DEBUG)
				# log.log_print(line)
				# log.log_print('**********************************')
				isInterFaceClass=True
				break
			matchobj = re.match(constrant.METHOD_START, line.strip())
			if matchobj:
				# log.log_print("found method start",log.DEBUG)
				if isStaticMethod(line) or isAbstractMethod(line) or isNativeMethod(line) or isConstructorMethod(line):
					isAddMethod=True
					# log.log_print("found method start static or constructor or abstract or native method ", log.DEBUG)
				else:
					# log.log_print('=======================')
					# log.log_print("====== add native decoration ==  ",log.DEBUG)
					# log.log_print(line)
					# log.log_print('=======================')
					isAddMethod = False
					tmpMethod =  line.split(" ")
					tmpMethod.insert(2,'native')
					line =  ' '.join(tmpMethod)
					# log.log_print(line)
					# log.log_print('=======================')
					outfd.writelines(line)
			if re.match(constrant.METHOD_END, line.strip()):
				# log.log_print("found method end ==>", log.DEBUG)
				outfd.writelines(line)
				outfd.writelines('\n')
				isAddMethod =False
			if  isAddMethod:
				outfd.writelines(line) #
		if isInterFaceClass:
			outfd.writelines(lines)
		outfd.close()
		fd.close()
		os.remove(file)
		os.rename(tmpFile,os.path.split(tmpFile)[0]+os.sep+filename)
	except (IOError,OSError )as e:
		log.log_print("when createMethodStruct  was occured exception ",log.ERROR)
		log.log_print(e,log.ERROR)
'''
过滤方法 <clinit>
静态代码
(.*(<clinit>).*)
.method static constructor <clinit>()V
'''
def isStaticMethod(methodline):
	return re.match(static_method_reg_str,methodline.strip())
'''
<init>
构造函数

(.*(<init>).*)

.method public constructor <init>()V
'''
def isConstructorMethod(methodline):
	return re.match(constructor_reg_str,methodline.strip())
'''
是否是native修饰函数
'''
def isNativeMethod(methodline):
	return re.match(native_method_reg_str,methodline.strip())

'''
是否是抽象修饰符修饰函数

正则：
.* (abstract).*
.method public abstract getAget()I
	ob1 = re.match(reg_str,mm) #从
	if ob1:
		print ob1.group(1)
'''
def isAbstractMethod(methodline):
	return re.match(abstract_method_reg_str,methodline.strip())
'''
接口类，不做处理
正则：
.* (interface).*

.class public interface abstract Litsec/parserelf/TestListener;

'''
def isInterfaceClass(classline):
	return  re.match(interface_class_reg_str,classline.strip())


















