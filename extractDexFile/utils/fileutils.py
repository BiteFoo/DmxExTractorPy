#-*- coding:UTF-8 -*-
'''
author:Loopher
date:
文件工具
'''
import sys,os
import shutil
from log import log

'''
logging 打印级别
(DEBUG, INFO, WARNING, ERROR, CRITICAL).
'''
def copyFile(apk):
	if not os.path.isfile(apk):
		log.log_print("%s is not file"%apk,log.ERROR)
		return
	tmp = os.path.split(apk)
	modifyApk = tmp[0]+os.sep+"modify_"+tmp[1]
	deleteFile(modifyApk)
	shutil.copyfile(apk,modifyApk)
	log.log_print("copy %s is ok" % modifyApk,log.DEBUG)
	return modifyApk

'''
根据文件名，返回文件路径
'''
def getFilePath(path,filename):
	return os.path.join(sys.path[0]+os.sep+path,filename)

def checkDirs(path):
	return os.path.isdir(path)
def checkFile(file):
	return os.path.isfile(file)

def createDirs(path):
	if not checkDirs(path):
		os.makedirs(path)

def deletDid(path):
	if checkDirs(path):
		shutil.rmtree(path)
def deleteFile(apk):
	try:
		if os.path.isfile(apk):
			os.remove(apk)
	except Exception as e:
		raise  e
def renameFile(src,dst):
	try:
		os.rename(src,dst)
	except Exception as e:
		log.log_print("when rename file was occured error",log.ERROR)
		log.log_print(e,log.ERROR)

def scanFile(rootPath,preffix =None,suffix=None,isScanFile=False):
	filelist=[]
	for root,dirs,files in os.walk(rootPath):
		# log.log_print(files,log.DEBUG)
		for file in files:
			name = os.path.basename(file)
			if suffix:
				if name.endswith(suffix):
					filelist.append(os.path.join(root,file))
			if preffix:
				if name.startswith(preffix):
					filelist.append(os.path.join(root,file))
	return filelist

def writeFile():
	pass
def readFile():
	pass