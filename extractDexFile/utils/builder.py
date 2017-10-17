#-*- coding:UTF-8 -*-
'''
author:Loopher

date:2017-10-12
描述：
apk操作工具
'''
import os
from log import log
from utils import fileutils
from  utils import  constrant
apktool_jar =fileutils.getFilePath('tools','apktool_2.3.0.jar')
apkpatch_jar=fileutils.getFilePath('tools','apkpatch-1.0.3.jar')
def decodeApk(apk,smaliPath):
	try:
		cmd = 'java -jar %s d %s -o %s'%(apktool_jar,apk,smaliPath)
		# log.log_print("disassemble cmd:%s"%cmd)
		os.system(cmd)
	except Exception as e:
		log.log_print("when disassemble apk was occured error",log.ERROR)
		log.log_print(e,log.ERROR)

def rebuildApk(smalipath,outpath):
	try:
		cmd ="java -jar %s b %s -o %s"%(apktool_jar,smalipath,outpath)
		os.system(cmd)
	except Exception as e:
		log.log_print("when rebuild apk was occured error",log.ERROR)
		log.log_print(e,log.ERROR)

'''
差分数据包
java -jar .\apkpatch-1.0.3.jar -f .\sign_new.apk -t .\sign_old.apk -o patch -k release.keystore -p testres -a testres -e testres
'''
def makePatchDexData(baseApk,modifyApk):
	try:
		cmd ='java -jar %s -f %s -t %s -o %s -k %s -p testres -a testres -e testres '%(apkpatch_jar,baseApk,modifyApk,constrant.PATCH_APK_DEX,constrant.KEY_STORE_PATH)
		os.system(cmd)
	except Exception as e:
		log.log_print("makePatchDexData exception",log.ERROR)
		log.log_print(e,log.ERROR)
