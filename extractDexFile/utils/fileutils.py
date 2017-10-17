#-*- coding:UTF-8 -*-
'''
author:Loopher
date:
文件工具
'''
import sys,os
import shutil
from log import log
from utils import constrant

'''
logging 打印级别
(DEBUG, INFO, WARNING, ERROR, CRITICAL).
'''
def copyFile(srcfile,dstfile):
	if not os.path.isfile(srcfile):
		log.log_print("%s is not file" % srcfile, log.ERROR)
		return
	createDirs(constrant.TMP_ROOT_DIR) #预先创建
	copyFile = dstfile
	deleteFile(copyFile)
	shutil.copyfile(srcfile, copyFile)
	log.log_print("copy %s is ok" % copyFile,log.DEBUG)
	return copyFile

def copyDirs(src,dst):
	log.log_print(os.path.isdir(src))
	log.log_print(os.path.isdir(dst))
	if not checkDirs(src) :
		log.log_print("copy dirs error,%s  not directory"%(src),log.ERROR)
		sys.exit(1)
	try:
		shutil.copytree(src=src,dst=dst,symlinks=True) #注意，dst目录要不在，如果已经存在，则需要删除才能复制
	except Exception as e:
		log.log_print("copy dirs occurred exception",log.ERROR)
		log.log_print(e,log.ERROR)
		sys.exit(1)

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

def deletDirs(path):
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