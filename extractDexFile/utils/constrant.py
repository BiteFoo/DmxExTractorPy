#-*- coding:UTF-8 -*-
'''
author:Loopher

date:2017-11-13

description: 
常量工具，这里作为一个配置使用

'''

import sys,os

APK_PATH=sys.path[0]+os.sep+"sample" #apk存放路径

APK_SUFFIX = '.apk'#原始apk名称

PATCH_SUFFIX ='.apatch' #差分包后缀

SMALI_SUFFIX ='.smali' #smali文件

SMALI_OUT_PATH=sys.path[0]+os.sep+"outsmali" #解包后smali路径

RELEASE_PATH = sys.path[0]+os.sep+"release" #最后输出路径



PATCH_APK="patch"  #大差分包的使用

RELEASE = 'release'#输出apk使用 会在输出包中添加静态代码


LOG_FILE ="record.log" #日志文件名称

#######################################################
#提供给方法做正则使用
#method templete
#.method xxx

METHOD_START=r'^\.method.*'

METHOD_END =r'^\.end method$'


##########################test############################
TEST_SMALI_FILE=APK_PATH+os.sep+"MainActivity.smali"
