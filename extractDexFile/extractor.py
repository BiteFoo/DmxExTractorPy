#-*- coding:UTF-8 -*-
'''
author:Loopher
date:2017-10-12

提供外部调用接口

com.xx.xxx.A

A.fix(clasname)

'''
import os,sys
import  shutil
import time
import hashlib
from utils import fileutils,constrant
from utils import builder
from utils import mainfest
from utils import modifyer
from log import  log

#dex文件代码抽取工作对象
class ExtractorDex():
    def __init__(self,srcApk=None):
        fileutils.deletDirs(constrant.TMP_ROOT_DIR) #开始清除所有缓存
        self.Apk=srcApk#默认支持传递apk路径 ，如果没有会从指定路径读取
    	self.filelist =fileutils.scanFile(constrant.APK_PATH,suffix=constrant.APK_SUFFIX)
        self.copyBaseApk =None
        self.disaCodePath=None
    def copyApk(self):
        log.log_print("copy Apk")
        if self.Apk:
            self.copyBaseApk= fileutils.copyFile(self.Apk, constrant.TMP_ROOT_DIR + os.sep + constrant.TMP_COPY_APK)
        else:
            self.copyBaseApk= fileutils.copyFile(self.filelist[0], constrant.TMP_ROOT_DIR + os.sep + constrant.TMP_COPY_APK)
    def decodeApk(self):
        log.log_print("disassemble Apk")
        builder.decodeApk(self.copyBaseApk, constrant.SMALI_OUT_PATH)
    def makePatchDex(self):
        log.log_print("makePatchDex .. ")
        packageName=mainfest.getApkPackageName()
        log.log_print("packageName:%s"%packageName)
        self.disaCodePath=constrant.SMALI_OUT_PATH+os.sep+'smali'+os.sep+packageName.replace('.',os.sep)
        mlist = fileutils.scanFile(self.disaCodePath, suffix=constrant.SMALI_SUFFIX)
        log.log_print("modifySmaliFileMetho begin")
        print "mlist",mlist
        for item in mlist:
            modifyer.modifySmaliFileMethod(item)
        log.log_print("modifySmaliFileMetho end")
        self.buildApk()
    def buildApk(self):
        log.log_print("build apk")
        builder.rebuildApk(constrant.SMALI_OUT_PATH,constrant.TMP_APK_PATH+os.sep+constrant.BASE_METHOD_MODIFY_APK)
    def doPatch(self):
        builder.makePatchDexData(self.copyBaseApk, constrant.TMP_APK_PATH + os.sep + constrant.BASE_METHOD_MODIFY_APK)
        log.log_print('dopatch ok ')
    def release(self):
        try:
            time_stamp=self.get_time_hash(time.strftime('%Y%m%d%H%M%S',time.localtime()))
            fileutils.copyDirs(constrant.SRC_ANDFIX_PATH, constrant.DST_ANDFIX_PATH) #复制添加的文件目录
            mlist = fileutils.scanFile(constrant.PATCH_APK_DEX, suffix=constrant.PATCH_DEX_SUFFIX)
            if not os.path.isdir(constrant.APP_ASSETS_DIR):
                os.makedirs(constrant.APP_ASSETS_DIR)
            out_patch_file = constrant.APP_ASSETS_DIR + os.sep + 'out.apatch'
            shutil.copyfile(mlist[0], out_patch_file)
            for file in fileutils.scanFile(self.disaCodePath, suffix=constrant.SMALI_SUFFIX):
                modifyer.add_fix_function_code(file)
            log.log_print('build release apk ... ')
            builder.rebuildApk(constrant.SMALI_OUT_PATH, constrant.RELEASE_APK_NAME+time_stamp+'.apk')
            log.log_print('release apk path:%s'%(constrant.RELEASE_APK_NAME+time_stamp+'.apk'))
        except Exception as e:
            log.log_print("when build release apk was occured an error ",log.ERROR)
            log.log_print(e,log.ERROR)
    def get_time_hash(self,timestamp):
        hash =hashlib.md5()
        hash.update(timestamp)
        return hash.hexdigest()
'''
提供两种方式：
1、提供app
2、没有app的情况。那么回去指定路径下读取
'''
def startWork(apk=None):
    extractor = ExtractorDex(srcApk=apk)
    extractor.copyApk()
    extractor.decodeApk()
    extractor.makePatchDex()
    extractor.doPatch()
    extractor.release()
if __name__=='__main__':
    startWork()
