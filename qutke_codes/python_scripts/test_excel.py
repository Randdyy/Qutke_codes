path = '/Users/chentianbo/Desktop/投资经理信息-职业年金/华泰资产/华泰资产管理有限公司 - 固收2 - 张书毓.xlsx'
import xlrd
import xlwt
import os
import time
from datetime import datetime
from xlrd import xldate_as_tuple
import json


data = xlrd.open_workbook(path)
table = data.sheets()[0]
rows_num = table.nrows
cols_num = table.ncols

for i in range(rows_num):
    for j in range(cols_num):
        cell = table.cell_value(i,j)
        print('row:',i,'  col:',j,'  cell:',cell)


error = ['/Users/chentianbo/Desktop/投资经理信息库/华泰/华泰资产管理有限公司 - 固收1 - 姜超.xlsx', '/Users/chentianbo/Desktop/投资经理信息库/华泰/华泰资产管理有限公司 - 权益3 - 万永涛.xlsx', '/Users/chentianbo/Desktop/投资经理信息库/华泰/华泰资产管理有限公司 - 权益2 - 刘潇潇.xlsx', '/Users/chentianbo/Desktop/投资经理信息库/华泰/华泰资产管理有限公司 - 固收3 - 翟雨佳.xlsx', '/Users/chentianbo/Desktop/投资经理信息库/华泰/华泰资产管理有限公司 - 固收2 - 张书毓.xlsx', '/Users/chentianbo/Desktop/投资经理信息库/建信/建信养老+李宇璐.xlsx', '/Users/chentianbo/Desktop/投资经理信息库/建信/建信养老+张伟 .xlsx', '/Users/chentianbo/Desktop/投资经理信息库/建信/建信养老+宋加旺.xlsx', '/Users/chentianbo/Desktop/投资经理信息库/建信/建信养老+贲育.xlsx', '/Users/chentianbo/Desktop/投资经理信息库/建信/建信养老+徐烨.xlsx', '/Users/chentianbo/Desktop/投资经理信息库/嘉实/嘉实基金+各投资经理信息.xlsx', '/Users/chentianbo/Desktop/投资经理信息库/博时/博时基金+魏建.xlsx', '/Users/chentianbo/Desktop/投资经理信息库/博时/博时基金+程沅.xlsx', '/Users/chentianbo/Desktop/投资经理信息库/博时/博时基金+吴文庆.xlsx', '/Users/chentianbo/Desktop/投资经理信息库/博时/博时基金+施永辉.xlsx', '/Users/chentianbo/Desktop/投资经理信息库/长江/长江养老+丁张旭.xlsx', '/Users/chentianbo/Desktop/投资经理信息库/长江/长江养老+洪晔云.xlsx', '/Users/chentianbo/Desktop/投资经理信息库/长江/长江养老+邱琴.xlsx', '/Users/chentianbo/Desktop/投资经理信息库/长江/长江养老+杨胜.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/富国基金/富国基金+孙磊.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/富国基金/富国基金+赵峰.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/富国基金/富国基金+周宁.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/建信养老/建信养老+李宇璐.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/建信养老/建信养老+张伟 .xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/建信养老/建信养老+宋加旺.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/建信养老/建信养老+贲育.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/建信养老/建信养老+徐烨.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/嘉实基金/嘉实基金平安受托职业年金+各投资经理信息 (终).xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/华泰资产/华泰资产管理有限公司 - 权益2 - 辛欢.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/华泰资产/华泰资产管理有限公司 - 固收2 - 张书毓old.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/华泰资产/华泰资产管理有限公司 - 权益3 - 万永涛.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/华泰资产/华泰资产管理有限公司 - 固收3 - 翟雨佳.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/华泰资产/华泰资产管理有限公司 - 固收2 - 张书毓.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/华泰资产/华泰资产管理有限公司 - 固收1 - 李捷.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/长江养老/~$长江养老+满臻.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/长江养老/长江养老+丁杰文.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/太平养老/~$太平养老+傅梅望、李德清.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/太平养老/太平养老+傅梅望、李小强.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/太平养老/太平养老+周兵、石云峰.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/太平养老/太平养老+张炳炜、沈科.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/太平养老/太平养老+傅梅望、李德清.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/太平养老/~$太平养老+傅梅望、李小强.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/太平养老/太平养老+陆坚、汪剑峰.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/太平养老/太平养老+张飞帆、方昊.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/南方基金/南方基金-刘树坤.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/南方基金/南方基金-孙鲁闽.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/招商基金/招商基金管理有限公司+杨熙.xlsx', '/Users/chentianbo/Desktop/投资经理信息-职业年金/华夏基金/华夏基金管理有限公司＋孙彬.xlsx']


