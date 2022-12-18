# -*- coding: utf-8 -*-
"""
データをプロットする
"""

import os,sys
import time
import datetime

from library import HttpRequestData

import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.utils import formatdate
from email.header import Header
#=====================================================#

TO_ADDRESS = 'aaa@gmail.com'
FROM_ADDRESS = 'bbb@gmail.com'
MY_PASSWORD = 'password'

def create_message(from_addr, to_addr, bcc_addrs, ubject, body):
	msg = MIMEMultipart()
	msg['From'] = from_addr
	msg['To'] = to_addr
	msg['Bcc'] = bcc_addrs
	msg['Date'] = formatdate()
	msg['Subject'] = (subject)
	body = MIMEText(body)
	msg.attach(body)
	return msg

def send(from_addr, to_addrs, msg):
	try:
		smtpobj = smtplib.SMTP('smtp.gmail.com', 587)
		##smtpobj.connect("smtp.gmail.com",587)
		smtpobj.ehlo()
		smtpobj.starttls()
		smtpobj.ehlo()
		smtpobj.login(FROM_ADDRESS, MY_PASSWORD)
		smtpobj.sendmail(from_addr, to_addrs, msg.as_string())
		print( 'Send Mail Success' )
	except Exception as e:
		print('SendMail Failed')
		print(e)
	finally:
		smtpobj.close()
	
#=====================================================#

if __name__ == "__main__":
	sendcount = 1
	getdata = HttpRequestData.HttpRequestData()
	oldip = ""
	failcount = 10
	sleeptime = 60*10
	while 1:
		# nowip = getdata.get_GlobalIP('http://ipcheck.ieserver.net')
		nowip = getdata.get_GlobalIP('https://res-gip.azurewebsites.net/')
		print(nowip)
		if isinstance(nowip, bytes):
			nowip = nowip.decode()
		if ( nowip != oldip ):
			failcount = failcount + 1
			# 3 min
			sleeptime = 60*3*1
			print( "failcount = " + str(failcount))
		else:
			failcount = 0
			# 3 hour
			sleeptime = 60*60*3
			print( "failcount = 0")
		if ( failcount > 3 ):
			oldip = nowip
			last_time =  datetime.datetime.now()
			to_addr = TO_ADDRESS
			BCC = ''
			subject = 'Global IP Chang ' + str(sendcount)
			sendcount = sendcount + 1
			body = 'グローバルIPは次のとおりです \n' + nowip + '\n\n'+ last_time.strftime("%Y/%m/%d %H:%M:%S")
			msg = create_message(FROM_ADDRESS, to_addr, BCC, subject, body)
			send(FROM_ADDRESS, to_addr, msg)
			last_time =  datetime.datetime.now()
		time.sleep(sleeptime)