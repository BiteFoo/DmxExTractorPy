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
current_java_class_name='^\.source \D+'

buildAndRfilelNameList=['BuildConfig.smali','R$anim.smali','R$attr.smali',
                        'R$bool.smali','R$color.smali','R$dimen.smali',
                        'R$drawable.smali','R$id.smali','R$integer.smali','R$layout.smali',
                        'R$mipmap.smali','R$string.smali','R$style.smali','R$styleable.smali',
                        'R.smali'
                        ]
'''
file
    要修改的smali文件呢
isAddFixFuntion
    是否添加静态代码快，fixFunc()函数

'''
def modifySmaliFileMethod(file,isAddFixFuntion=False):
	try:
		#读取内容，同时写文件
		tmp=os.path.split(file)
		filename = tmp[1]
		if __isRFile(filename):
			return
		log.log_print("file:%s" % file)
		fd = open(file, 'r')
		lines = fd.readlines()
		tmpFile=tmp[0]+os.sep+"_tmp_"+tmp[1]
		outfd = open(tmpFile,'w')
		isInterFaceClass =False
		isAddMethod = True
		for line in lines:
			if is_match_reg(interface_class_reg_str,line):
				isInterFaceClass=True
				break
			# if is_match_reg(current_java_class_name,line):
			# 	java_class_filename = line.split(' ')[1].replace('"','')
			# 	log.log_print('current java class name :%s'%(java_class_filename))
			matchobj = re.match(constrant.METHOD_START, line.strip())
			if matchobj:
				if is_match_reg(static_method_reg_str,line):
					#这里添加 fixfunc的函数体
					log.log_print('isStaticMethod')
					isAddMethod=True
				elif  is_match_reg(abstract_method_reg_str,line) or is_match_reg(native_method_reg_str,line) or is_match_reg(constructor_reg_str,line):
					isAddMethod=True
				else:
					isAddMethod = False
					tmpMethod =  line.split(" ")
					tmpMethod.insert(2,'native')
					line =  ' '.join(tmpMethod)
					outfd.writelines(line)
			if re.match(constrant.METHOD_END, line.strip()):
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
找到<clinit>的位置，如果没有，那么在整体添加
如果找到，则需要插入对应的代码即可

'''
def add_fix_function_code(file):
	tmp=os.path.split(file)
	filename = tmp[1]
	if __isRFile(filename):
		return
	try:
		fd = open(file,'r')
		lines = fd.readlines()
		out_fd =open(file,"w+")
		tmpDict = found(static_method_reg_str,lines)
		if tmpDict == None:
			out_fd.writelines(lines)
			return
		if  tmpDict.get('method_index')== 0:
			# 说明，没有找到<clinit>方法
			mDict=found(constrant.METHOD_START,lines)
			#需要插入完整的方法体




		elif tmpDict.get('method_index') >0:
			# 说明，找到了<clinit>方法
		    #只需要插入部分代码


	except IOError as e:
		log.log_print('when add fix function code was occured an error',log.ERROR)
		log.log_print(e,log.ERROR)


'''
返回空对象,表示为interface类
反之，不为interface类
'''
def found(reg_patter,lines):
	tmpDict ={}
	for line in lines:
		if is_match_reg(interface_class_reg_str, line):
			# 判断是否是interface类，如果是，那么就不要修改
			break
		elif re.match('^\.class.*;$', line.strip()):
			clazz = line.split(' ')[2]
			tmpDict['clazz'] =clazz

		if is_match_reg(reg_patter, line):
			position = lines.index(line)
			tmpDict['method_index']=position
			log.log_print('found <clinit> position :%d' % (position))
			break
	return tmpDict



'''
过滤R文件和BuilConfig文件
'''
def __isRFile(filename):
	return  buildAndRfilelNameList.__contains__(filename)

'''
根据reg_pattern过滤

'''
def is_match_reg(reg_pattern,line):
	return  re.match(reg_pattern,line.strip())

'''
过滤方法 <clinit>
静态代码
(.*(<clinit>).*)
.method static constructor <clinit>()V
'''
# def __isStaticMethod(methodline):
# 	return re.match(static_method_reg_str,methodline.strip())
'''
<init>
构造函数

(.*(<init>).*)

.method public constructor <init>()V
'''
# def isConstructorMethod(methodline):
# 	return re.match(constructor_reg_str,methodline.strip())
'''
是否是native修饰函数
'''
# def __isNativeMethod(methodline):
# 	return re.match(native_method_reg_str,methodline.strip())

'''
是否是抽象修饰符修饰函数

正则：
.* (abstract).*
.method public abstract getAget()I
	ob1 = re.match(reg_str,mm) #从
	if ob1:
		print ob1.group(1)
'''
# def __isAbstractMethod(methodline):
# 	return re.match(abstract_method_reg_str,methodline.strip())
'''
接口类，不做处理
正则：
.* (interface).*

.class public interface abstract Litsec/parserelf/TestListener;

'''
# def __isInterfaceClass(classline):
# 	return  re.match(interface_class_reg_str,classline.strip())


















