#-*- coding:UTF-8 -*-
'''
author:Loopher
date:2017-10-12

提供外部调用接口

'''
import os,sys
from utils import fileutils,constrant
from utils import builder
from utils import mainfest
from utils import modifyer
from log import  log

#dex文件代码抽取工作对象
class ExtractorDex():

    def __init__(self,srcApk=None):
        self.Apk=srcApk#默认支持传递apk路径 ，如果没有会从指定路径读取
    	self.filelist =fileutils.scanFile(constrant.APK_PATH,suffix=constrant.APK_SUFFIX)
        self.modifyApk =None

    def copyApk(self):
        log.log_print("copy Apk")
        if self.Apk:
            self.modifyApk= fileutils.copyFile(self.Apk)
        else:
            self.modifyApk= fileutils.copyFile(self.filelist[0])
    def decodeApk(self):
        log.log_print("disassemble Apk")
        builder.decodeApk(self.modifyApk,constrant.SMALI_OUT_PATH)
    def makePatchDex(self):
        log.log_print("makePatchDex .. ")
        packageName=mainfest.getApkPackageName()
        mlist = fileutils.scanFile(constrant.SMALI_OUT_PATH+os.sep+packageName.replace('.',os.sep), suffix=constrant.SMALI_SUFFIX)
        log.log_print("modifySmaliFileMetho begin")
        for item in mlist:
            modifyer.modifySmaliFileMethod(item)
        log.log_print("modifySmaliFileMetho end")
    def buildApk(self):
        pass
    def release(self):
        pass


'''
提供两种方式：
1、提供app
2、没有app的情况。那么回去指定路径下读取
'''
def startWork(apk=None):
    #test apk
    extractor = ExtractorDex(srcApk=apk)
    extractor.copyApk()
    extractor.decodeApk()
    extractor.makePatchDex()
    #test smali
    # mlist = fileutils.scanFile(constrant.APK_PATH,suffix=constrant.SMALI_SUFFIX)
    # for item in mlist:
    #     modifyer.modifySmaliFileMethod(item)

    #
 #D:\Android\worRecord\Androidprotected\extractDexFile\utils\sample
#D:\Android\worRecord\Androidprotected\extractDexFile\sample
if __name__=='__main__':
    startWork()
