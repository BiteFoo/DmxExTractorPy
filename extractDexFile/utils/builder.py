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

def rebuildApk(smalipath):
	try:
		cmd ="java -jar %s b %s -o %s"%()
	except Exception as e:
		log.log_print("when rebuild apk was occured error",log.ERROR)
		log.log_print(e,log.ERROR)
def makePatchDexData(baseApk,modifyApk):
	pass
