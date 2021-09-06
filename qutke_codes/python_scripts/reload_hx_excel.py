import xlrd
import xlwt
import os
import time
from datetime import datetime
from xlrd import xldate_as_tuple
import json
import shutil

def read_file(file_path,save_path):
    try:
        data = xlrd.open_workbook(file_path)
    except:
        shutil.move(file_path,'/Users/chentianbo/Desktop/error/'+file_path.split('/')[-1])
        print('move:',file_path.split('/')[-1])

    # print(data.sheets())
    base_info_table = data.sheets()[0]
    base_info_data = handle_base_info(base_info_table)

    # print(base_info_data)


    new_data = xlwt.Workbook()
    new_table = new_data.add_sheet("new")
    row_num = 0
    for i in base_info_data:
        col_num = 0
        for j in i:
            # print(j)
            new_table.write(row_num,col_num,str(j))
            col_num+=1
        row_num+=1
    save_path = save_path + '/' + file_path.split('/')[-1]
    print('1111',save_path)
    new_data.save(save_path)


def handle_base_info(table):
    # data_dict = {}
    rows_num = table.nrows
    final_rows = []
    # print(rows_num)
    for i in range(0,rows_num):
        final_rows.append(table.row_values(i))

    return final_rows




def run():
    path = '/Users/chentianbo/Desktop/易方达FOF'
    file_list = os.listdir(path)
    save_path = path + 'New'
    os.mkdir(save_path)
    for i in file_list:
        file_path = path+'/'+i

        try:
            read_file(file_path,save_path)
        except:
            continue


run()


