import xlrd
import xlwt
import os
import time
from datetime import datetime
from xlrd import xldate_as_tuple
import json



def read_file(file_path):
    data = xlrd.open_workbook(file_path)
    print(data.sheets())
    base_info_table = data.sheets()[0]
    education_exp = data.sheets()[1]
    work_exp = data.sheets()[2]

    # base_info_row_num = get_max_row_num(base_info_table)
    # education_row_num = get_max_row_num(education_exp)
    # work_row_num = get_max_row_num(work_exp)
    # print('row_num:'+str(base_info_row_num))

    base_info_data = handle_base_info(base_info_table)
    education_data = handle_education_info(education_exp,5)
    work_exp_data = handle_education_info(work_exp,4)
    
    for row_data in base_info_data :
        for edu in education_data.keys():
            for work in work_exp_data.keys():
                if row_data[0] == edu == work:
                    data_dict = {}
                    name = data_dict['name'] = row_data[0]
                    birthday = data_dict['birthDay'] = row_data[1]
                    birthPlace = data_dict['birthPlace'] = row_data[2]
                    gender = data_dict['gender'] = row_data[3]
                    bloodGroup = data_dict['bloodGroup'] = row_data[4]
                    data_dict['philosophy'] = row_data[5]
                    data_dict['awards'] = row_data[6]
                    data_dict['edu_exp'] = education_data[edu]
                    data_dict['work_exp'] = work_exp_data[work]
                    
                    make_json(data_dict,name,birthday,birthPlace,gender,bloodGroup)
                    




def handle_base_info(table):
    # data_dict = {}
    rows_num = table.nrows
    cols_num = table.ncols
    all_content = []
    print(rows_num,'rows',' ',cols_num,'cols')
    for i in range(1,rows_num):
        row_content = []
        for j in range(cols_num):
            ctype = table.cell(i,j).ctype
            cell = table.cell_value(i,j)
            try:
                cell = cell.strip()
            except:
                pass
            # print('ctype:',ctype,' cell:',cell)
            if ctype == 2 and cell % 1 == 0:  # ???????????????
                cell = int(cell)
            elif ctype == 3:
                # ??????datetime??????
                date = datetime(*xldate_as_tuple(cell, 0))
                cell = date.strftime('%Y/%m/%d')
            elif ctype == 4:
                cell = True if cell == 1 else False
            # if '???' in str(cell) or cell == '' or '???' in str(cell):
            #     continue
            row_content.append(cell)
                
        all_content.append(row_content)
        
    return all_content


def handle_education_info(table,length):
    rows_num = table.nrows
    cols_num = table.ncols
    all_content = {}
    current_name = ''
    print(rows_num,'rows',' ',cols_num,'cols')
    p = True
    # flag = False
    for i in range(1,rows_num):
        row_content = []
        if '???' in table.cell_value(i,0):
            continue
        for j in range(cols_num):
            # p = True

            if j == 3 and table.cell_value(i,j):# ???????????????????????????
                current_school = table.cell_value(i,j)

            if j == 0 and table.cell_value(i,j) == current_name:# ???????????????????????????????????????
                p = False

            # if j == 0 and current_name == table.cell_value(i,j)
            if j == 0 and table.cell_value(i,j) and '???' not in table.cell_value(i,j) and '???' not in table.cell_value(i,j) and p:
                # one_person_list=[]
                current_name = table.cell_value(i,j)
                all_content[current_name] = []
            else:
                pass
          
            
            ctype = table.cell(i,j).ctype
            cell = table.cell_value(i,j)
            try:
                cell = cell.strip()
            except:
                pass
            # print('ctype:',ctype,' cell:',cell)
            if ctype == 2 and cell % 1 == 0:  # ???????????????
                cell = int(cell)
            elif ctype == 3:
                # ??????datetime??????
                date = datetime(*xldate_as_tuple(cell, 0))
                cell = date.strftime('%Y/%d/%m')
            elif ctype == 4:
                cell = True if cell == 1 else False
            # row_content.pop(0)
            if '???' in str(cell) or cell == '' or '???' in str(cell):
                continue
            row_content.append(cell)
        print(row_content)
        if len(row_content):#?????????????????????????????????
            if row_content[0] == current_name: #?????????????????? ??????????????????
                row_content.pop(0)

            if length == 5 and len(row_content) == 4:
                row_content.insert(2,current_school)
        
        all_content[current_name].append(row_content)
    pop_times = 0
    for i in all_content[current_name]: #??????????????????
        if len(i) == 0:
            # all_content[current_name].pop(-1)
            pop_times += 1
    for i in range(pop_times):
        all_content[current_name].pop(-1)

    # print(all_content)
    return all_content





def make_json(data_dict,name,birthday,birthPlace,gender,bloodGroup):
    
    json_data = json.dumps(data_dict,ensure_ascii=False)
    save_json_data(json_data,name,birthday,birthPlace,gender,bloodGroup)


def save_json_data(data,name,birthday,birthPlace,gender,bloodGroup):
    birthday = str(birthday).replace('/','~',10)
    birthPlace = str(birthPlace).replace('/','~',10)
    bloodGroup = str(bloodGroup).replace('/','*',10)
    try:
        with open('./json_files/'+name+'-'+str(birthday)+'-'+birthPlace+'-'+gender+'-'+bloodGroup+'.json','w') as f:
            f.write(data)
    except:
         print('err')
   




def run():
    files_list = ['/Users/chentianbo/Desktop/?????????????????????','/Users/chentianbo/Desktop/??????????????????-????????????']
    

    for file_list in files_list:
        files = os.listdir(file_list)
        if '.DS_Store' in files:
            files.pop(files.index('.DS_Store'))
        for file1 in files:
            new_file_path = file_list+'/'+file1
            folder_path = os.listdir(new_file_path)
            for path in folder_path:
                file_path = new_file_path+'/'+path     
                if file_path.split('.')[1] == 'xlsx' and '$' not in file_path:
                    print(file_path)
                    read_file(file_path)      

                   



run()



