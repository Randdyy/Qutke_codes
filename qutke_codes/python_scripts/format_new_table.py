import xlrd
import xlwt
import os
import time
import calendar


def judge_year(year):
    try:
        check_year = calendar.isleap(year)
        if check_year:
            return True
            # print('{0}是闰年'.format(year))
        else:
            return False 
            # print('{0}不是闰年'.format(year))
    except ValueError:
        print('您输入的年份无法识别，请输入正确的年份（整数）。')

def judge_month(year,month):
    month_31_days = ['01','03','05','07','08','10','12']
    month_30_days = ['04','06','09','11']
    if month in month_31_days:
        return 31
    if month in month_30_days:
        return 30
    if judge_year(year) and month == '02':
        return 29
    if not judge_year(year) and month == '02':
        return 28
    

def read_file(file_path):
    data = xlrd.open_workbook(file_path)
    print(data.sheets())
    table = data.sheets()[0]
    rows_num = table.nrows
    cols_num = table.ncols
    print(rows_num)

    all_content=[]
    for i in range(1,rows_num):
        row_content = []
        for j in range(cols_num):

            cell = table.cell_value(i,j)
            # print(cell)
            row_content.append(cell)
        row_content.pop(1)
        row_content.insert(0,'000906.SH')
        row_content[1],row_content[2] = row_content[2],row_content[1]
        old_date = row_content[2]
        year = old_date[0:4]
        month = old_date[4:6]
        day = judge_month(year,month)
        row_content[2]= row_content[2][0:6]+str(day)

        print(i)
        all_content.append(row_content)
    
    # print(all_content)
    return all_content


def write_file(data,new_table):
    row_num = 0
    for i in data:
        col_num = 0
        for j in i:
            # print(j)
            new_table.write(row_num,col_num,str(j))
            col_num+=1
        row_num+=1



data = read_file('/Users/chentianbo/Desktop/csi800.xlsx')
new_data = xlwt.Workbook()
new_table = new_data.add_sheet("new")
write_file(data,new_table)
new_data.save('/Users/chentianbo/Desktop/csi800_formated_2.xlsx')




