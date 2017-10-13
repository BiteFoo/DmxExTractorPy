#-*- coding:UTF-8 -*-
'''
author:Loopher
date:

dex文件内容修改器
主要删除dex文件内的方法体，同时添加上native修饰，

通过包名，搜集所有代码块

2.读取包名下所有文件，读取报名下
3.分析smali文件，g根据函数模板，删除对应的smali文件中的方法体
4.

'''
import os
from utils import mainfest
from utils import  fileutils
from utils import  constrant
class Method():
	def __init__(self):
		self.apkPackage =mainfest.getApkPackageName()
		self.smaliFileList=fileutils.scanFile(self.apkPackage.replace('.',os.sep),suffix=constrant.SMALI_SUFFIX)
	def deleteMethodStruct(self):
		pass
	def createMethodTemplate(self):
		pass
	def fileterMethod(self):
		pass


