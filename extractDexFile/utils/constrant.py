#-*- coding:UTF-8 -*-
'''
author:Loopher

date:2017-11-13

description: 
常量工具，这里作为一个配置使用

'''

import sys,os

#所有临时文件目录
TMP_ROOT_DIR= sys.path[0] + os.sep + "tmp"

APK_PATH=sys.path[0]+os.sep+"sample" #apk存放路径

APK_SUFFIX = '.apk'#apk的后缀

#打差分包使用
BASE_METHOD_MODIFY_APK="base_method_modify.apk" #方法体被删除的后重打包的apk名称

#输出包使用
BASE_RELEASE_APK='base_release.apk' #最后输出的文件，

SMALI_SUFFIX ='.smali' #smali文件后缀

SMALI_OUT_PATH= TMP_ROOT_DIR + os.sep + "outsmali" #解包后smali路径
#
TMP_COPY_APK= "tmp_base_copy.apk"  #复制apk的名称

TMP_APK_PATH= TMP_ROOT_DIR + os.sep + "tmpapk" #临时apk存放路径 ,用这个路径下的apk做差分包

RELEASE_APK_NAME = TMP_ROOT_DIR + os.sep + "release_" #最后输出路径

PATCH_APK_DEX= TMP_ROOT_DIR + os.sep + "patch"  #差分包使用

PATCH_DEX_SUFFIX='.apatch'  #差分包文件后缀

LOG_FILE ="record.log" #日志文件名称
APP_ASSETS_DIR=SMALI_OUT_PATH+os.sep+'assets'

ADD_FIX_FUNCTION_CODE_PATH=sys.path[0]+os.sep+'tools'+os.sep+'code'+os.sep+'fixcode'


#签名文件
KEY_STORE_PATH=sys.path[0]+os.sep+"tools"+os.sep+"signkey"+os.sep+"release.keystore"

#################################################
##复制文件夹  dst目录，在复制调用的时候，需要注意，不能存在对应的目录，否则会出现异常，WindowsError: [Error 183]
SRC_ANDFIX_PATH=sys.path[0]+os.sep+'tools'+os.sep+'code'+os.sep+'com'+os.sep+'alipay'+os.sep+"euler"
DST_ANDFIX_PATH=SMALI_OUT_PATH+os.sep+'smali'+os.sep+'com'+os.sep+'alipay'+os.sep+"euler"

#######################################################
#提供给方法做正则使用
#method templete
#.method xxx

METHOD_START=r'^\.method.*' #方法体的开始
METHOD_END =r'^\.end method$' #方法体结束

##########################test############################
#BaseTest MainActivity
TEST_SMALI_FILE=APK_PATH+os.sep+"BaseTest.smali"  #测试文件 用于测试smali文件中的方法体被删除
