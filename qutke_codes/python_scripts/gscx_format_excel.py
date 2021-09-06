import xlrd
import xlwt
import os
import time


def get_max_row_num(table):
    x = 0
    try:
        while table.row_values(x)[1]:
            x+=1
    except:
        print(x,' rows')
    return x
        

def read_data(file_path):
    data = xlrd.open_workbook(file_path)
    table = data.sheets()[0]
    row_num = get_max_row_num(table)
    new_rows_list = []

    
    # zqda_col_num = 0 # 证券档案列数
    # jycs_col_num = 0 # 交易场所列数
    subject_code = 0   # 估值系统编码投资账号 以下都指列数
    subject_name = 0    # 估值系统编码名称
    amount = 0          # 数量
    unit_cost = 0       # 单位成本（本币）
    cost = 0            # 成本（本币）
    cost_ratio = 0      # 成本（本币）占净值
    price = 0           # 市价（本币）
    balance = 0         # 市值（本币）
    balance_ratio = 0   # 市值（本币）占净值
    x = True    
    trade_place = 0
    invest_account = 0
    stock_code = 0
    stock_name = 0
    for i in range(row_num): 
        row_data = table.row_values(i)
        
        if i == 0 :
            if '证券档案' in row_data:
                zqda_col_num = row_data.index('证券档案')
                # print(zqda_col_num)
            
            else:
                x = False
                
            # print(row_data)
            # if '交易场所' in row_data:
            #     jycs_col_num = row_data.index('交易场所')
            # if '估值系统编码投资账号' in row_data:
            #     subject_code = row_data.index('估值系统编码投资账号')
            #     print('估值系统编码投资账号')
            
            if '交易场所' in row_data:
                trade_place = row_data.index('交易场所')

            if '估值系统编码' in row_data:
                subject_code = row_data.index('估值系统编码')

            if '估值系统编码名称' in row_data:
                subject_name = row_data.index('估值系统编码名称')
            if '数量' in row_data:
                amount = row_data.index('数量')
            if '单位成本(本币)' in row_data:
                unit_cost = row_data.index('单位成本(本币)')
            if '成本(本币)' in row_data:
                cost = row_data.index('成本(本币)')
            if '成本(本币)占净值(%)' in row_data:
                cost_ratio = row_data.index('成本(本币)占净值(%)')
            if '市价(本币)'	in row_data:
                price = row_data.index('市价(本币)')
            if '市值(本币)' in row_data:
                balance = row_data.index('市值(本币)')
            if '市值(本币)占净值(%)' in row_data:
                balance_ratio = row_data.index('市值(本币)占净值(%)')
            if '投资账号' in row_data:
                invest_account = row_data.index('投资账号')

            if '证券代码' in row_data:
                stock_code = row_data.index('证券代码')

            if '证券名称' in row_data:
                stock_name = row_data.index('证券名称')
            

        if not x:
            zqda_col_num = len(row_data)
            row_data.append('')

        if stock_code and row_data[subject_code]:
            row_data[subject_code] = str(row_data[subject_code]) + row_data[stock_code]
            # print('1:'+row_data[subject_code])
        
        if stock_name and row_data[stock_name]:
            row_data[subject_name] = row_data[stock_name]

        if row_data[zqda_col_num] and len(str(row_data[zqda_col_num]).split(' '))>1:
            row_data[subject_code] = str(row_data[subject_code]) + str(row_data[zqda_col_num].split(' ')[0])
            # print('2:'+row_data[subject_code])

            row_data[subject_name] = str(row_data[zqda_col_num]).split(' ')[1]
            

        if row_data[invest_account] and invest_account:
            row_data[subject_code] = row_data[subject_code] + row_data[invest_account]
            # print('3:'+row_data[subject_code])

        if trade_place and row_data[trade_place]:
                row_data[subject_code] = str(row_data[trade_place]) + str(row_data[subject_code])
                # print('4:'+row_data[subject_code])

        
        new_rows_list.append(row_data)
    
    for i in range(len(new_rows_list)):
        # if i == 0:
            # print(new_rows_list[0])
        new_son_list = []
        # if subject_code and new_rows_list[i][2]:
        new_son_list.append(new_rows_list[i][2])

        if subject_name:
            new_son_list.append(new_rows_list[i][subject_name])
        if amount:
            new_son_list.append(new_rows_list[i][amount])
        if unit_cost:
            new_son_list.append(new_rows_list[i][unit_cost])
        if cost:
            new_son_list.append(new_rows_list[i][cost])
        if cost_ratio:
            new_son_list.append(new_rows_list[i][cost_ratio])
        if price:
            new_son_list.append(new_rows_list[i][price])
        if balance:
            new_son_list.append(new_rows_list[i][balance])
        if balance_ratio:
            new_son_list.append(new_rows_list[i][balance_ratio])
        new_rows_list[i] = new_son_list

        # print(i)
        # time.sleep(5)
        # i.pop(zqda_col_num)
    # new_rows_list[0].insert(0,'估值系统编码投资账号')
    # new_rows_list[0].pop(1)

    
    # print(new_rows_list[0])
    return new_rows_list


def write_new_excel(data,new_table):
    row_num = 0
    for i in data:
        col_num = 0
        for j in i:
            # print(j)
            new_table.write(row_num,col_num,str(j))
            col_num+=1
        row_num+=1



def run():
    # try:
    desktop_path = '20217月rscxctpt'

    trigger = 1 # trigger=1 为单层目录 trigger 为双层目录
    if not os.path.exists('/Users/chentianbo/Desktop/'+desktop_path+'-New'):
        os.mkdir('/Users/chentianbo/Desktop/'+desktop_path+'-New')

    file_list = os.listdir('/Users/chentianbo/Desktop/'+ desktop_path)
    # print(file_list)
    
    if '.DS_Store' in file_list:
        file_list.pop(file_list.index('.DS_Store'))
    print(len(file_list))
    time.sleep(2)

    if trigger == 1:
        single(file_list,desktop_path)
    elif trigger == 2 :
        double(file_list,desktop_path)

def single(file_list,desktop_path):
    for i in file_list:
        print(i)
        if '.DS_Store' in i:
            continue

        # 单层目录
        new_path = '/Users/chentianbo/Desktop/'+desktop_path+'/'+i #源目录路径
        new_data = xlwt.Workbook()
        new_table = new_data.add_sheet("new")
        file_path = new_path
        print(file_path)
        data = read_data(file_path)
        write_new_excel(data,new_table)
        new_data.save('/Users/chentianbo/Desktop/'+desktop_path+'-New/'+i)
        # break

def double(file_list,desktop_path):
    for i in file_list:
        os.mkdir('/Users/chentianbo/Desktop/'+desktop_path+'-New/'+i)
    for i in file_list:
        print(i)
        if '.DS_Store' in i:
            continue
        # 双层目录
        new_path = '/Users/chentianbo/Desktop/'+desktop_path+'/'+i+'/'
        print(new_path)
        file_name = os.listdir(new_path)
        for j in file_name:
            new_data = xlwt.Workbook()
            new_table = new_data.add_sheet("new")

            file_path = new_path+j
            print(file_path)
            

            data = read_data(file_path)
            write_new_excel(data,new_table)
            a = file_path.split('/')
            a[4] = desktop_path+'-New'
            new_data.save(str('/'.join(a)))
            print('Done')



















run()


