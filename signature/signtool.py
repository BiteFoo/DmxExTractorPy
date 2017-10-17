# -*- coding:UTF-8 -*-

'''
author: Loopher
data:2017-10-11
description
自动签名工具
'''

import os,sys
def sign(apk):
	old_apk = sys.path[0]+os.sep+apk
	name = 'sign_'+os.path.basename(old_apk)
	new_apk=sys.path[0]+os.sep+name
	keystore=sys.path[0]+os.sep+"release.keystore"
	signjar =sys.path[0]+os.sep+"apksign.jar"
	password ="testres"
	alais = password
	apPassword =  password
	cmd = 'java -jar %s -k  %s  -p %s -a %s -ap %s -i %s  -o %s  '%(signjar,keystore,password,alais ,apPassword,old_apk,new_apk) 
	print 'cmd: %s '%(cmd)
	try:
		os.system(cmd)
	except Exception as e:
		raise e

if __name__ == '__main__':
	if sys.argv.__len__() < 2:
		print 'please enter the apk !'
		sys.exit(1)
	sign(sys.argv[1])
