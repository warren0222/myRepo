import unittest
import os
import time
from xml.dom.minidom import parse
import xml.dom.minidom

path = os.path.abspath('C:/Users/dell/Desktop/') 
data_path = os.path.join(path,'abbr.xml') #获取xml文件地址

DOMTree = xml.dom.minidom.parse(data_path) 
data = DOMTree.documentElement

def get_attrvalue(node, attrname):
   return node.getAttribute(attrname)

def get_data_vaule(style, valuename):
  nodelist = data.getElementsByTagName(style)
  for node in nodelist: 
    node_name = node.getElementsByTagName(valuename)
    value = node_name[0].childNodes[0].nodeValue
    print(value)
  return


text = get_data_vaule('Abbr','Name')
print(text)
