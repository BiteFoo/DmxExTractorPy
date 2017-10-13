#-*- coding:UTF-8 -*-
'''
author:Loopher

date:2017-10-13

description: 
日志记录对象
http://blog.csdn.net/chosen0ne/article/details/7319306 日志记录
'''
import logging
import logging.handlers
from utils import constrant

def baeselog(function):
	def init(msg):
		handler = logging.handlers.RotatingFileHandler(constrant.LOG_FILE, maxBytes=1024 * 1024, backupCount=5)
		fmt = '%(asctime)s - %(filename)s:%(lineno)s -%(name)s - %(message)s'
		formatter = logging.Formatter(fmt)
		handler.setFormatter(formatter)
		logger = logging.getLogger("extracoter")
		logger.addHandler(handler)
		return function(msg)
	return init
# @baeselog
'''
根据选择的level输出对应的日志
'''
DEBUG=1
ERROR=2
INFOR=3
WARNNING=4

def log_print(msg, level=1):
	if DEBUG == level:
		print '====' * 10
		print '[DEBUG]:',msg
		print '====' * 10
	elif ERROR== level:
		print '----'*10
		print '[ERROR]:' , msg
		print '----' * 10
	elif INFOR== level:
		print '****' * 10
		print '[INFOR]:' ,msg
		print '****' * 10
	elif WARNNING == level:
		print '++++' * 10
		print '[WARNNING]:' , msg
		print '++++' * 10

if __name__=='__main__':
	log_print('test')






