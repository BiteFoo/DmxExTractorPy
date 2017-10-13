#-*- coding:UTF-8 -*-
'''
author:Loopher

date:2017-10-13

description: 
解析AndroidManifest.xml文件，读取package

'''
import xml.etree.cElementTree as ET
import constrant
import  os
import sys
import fileutils
from log import log
def getApkPackageName():
	log.log_print("getPackageNaem")
	manifestfile =constrant.SMALI_OUT_PATH+os.sep+"AndroidManifest.xml"
	#manifestfile ="D:\\Android\\worRecord\\Androidprotected\\extractDexFile\\smali\\AndroidManifest.xml"
	if not fileutils.checkFile(manifestfile):
		log.log_print("AndroidMainfest.xml is not file",log.ERROR)
		sys.exit(1)
	pacakgeName=""
	try:
		xmlTree = ET.ElementTree(file=manifestfile)
		if xmlTree == None:
			log.log_print("parse AndroidManifest.xml failed", log.ERROR)
			sys.exit(1)
		for items in xmlTree.iter():
			if items.tag == "manifest":
				pacakgeName = items.attrib.get('package')
	except Exception as e:
		log.log_print("Exception parse AndroidManifest.xml failed",log.ERROR)
		log.log_print(e,log.ERROR)
	return pacakgeName


if __name__=="__main__":
	print 'manifest.py'#getApkPackageName()


