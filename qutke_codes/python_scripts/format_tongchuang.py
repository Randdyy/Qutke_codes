import xlrd
import xlwt
import os
import time

length0 = []

def get_max_row_num(table):
    x = 0
    try:
        while table.row_values(x)[1]:
            x+=1
    except:
        print(x,' rows')
    
    return x

    
def read_data(file_path):
    new_rows_list2 = []
    data = xlrd.open_workbook(file_path)
    # print(data)
    table = data.sheets()[0]
    # print(table)
    row_num = table.nrows


    new_rows_list = []


    code = 0
    name = 0
    number= 0
    cost= 0
    market_pirce = 0
    market_value = 0
    percent = 0
    appreciation = 0
    date = 0
    for i in range(row_num): 
        row_data = table.row_values(i)
      
        
       

        new_row_data = []
        

        date = file_path.split('.')[0][-8:]
        if '估值表' in date:
            date = file_path.split('.')[0][-11:-3]
        



            

        if i == 3 :
            for j in range(len(row_data)):
                row_data[j] =  row_data[j].strip()
                
            if '科目代码' in row_data:
                code = row_data.index('科目代码')
            
            if '科目名称' in row_data:
                name = row_data.index('科目名称')
            
            if '数量' in row_data:
                number = row_data.index('数量')

            if '单位成本' in row_data:
                cost = row_data.index('单位成本')

            if '市价' in row_data:
                market_pirce = row_data.index('市价')

            if '市值' in row_data:
                market_value = row_data.index('市值')

            if '市值占净值%' in row_data:
                percent = row_data.index('市值占净值%')

            if '估值增值' in row_data:
                appreciation = row_data.index('估值增值')
            if file_path == '/Users/chentianbo/Desktop/同创2期/80500081707NB0072同创2期私募证券投资基金20170731.xls':
                print(number,cost)


        if row_data[code][:6] == '110201' or row_data[code][:6] == '110231':
        
            new_row_data.append(date)
            new_row_data.append(row_data[code][-6:])
            new_row_data.append(row_data[name])
            new_row_data.append(row_data[number])
            new_row_data.append(row_data[cost])
            new_row_data.append(row_data[market_pirce])
            new_row_data.append(row_data[market_value])
            new_row_data.append(row_data[percent])
            new_row_data.append(row_data[appreciation])
            # print(new_row_data)
            
        new_rows_list.append(new_row_data)
    

    if not date:
        print(2111,file_path)
    for i in new_rows_list:
        if len(i)>0:
            new_rows_list2.append(i)

        # print(new_rows_list)
    
    
    
    if len(new_rows_list2) == 0 :
        print(file_path)
    for i in new_rows_list2:
        if i[1] == '110201' or  i[1] == '110231' or  i[1] == '11020101' or  i[1] == '11023101' :
            new_rows_list2.remove(i)
  
    print(file_path+':'+str(len(new_rows_list2)))
    return new_rows_list2

def write_new_excel(row_num,data,new_table):
    
    for i in data:
        col_num = 0
        for j in i:
            # print(j)
            new_table.write(row_num,col_num,str(j))
            col_num+=1
        row_num+=1
        # print(row_num)
    row_num+=1

             
def run():
   
    full_data=[]

    row_num=0
    length = 0
    new_data = xlwt.Workbook()
    new_table = new_data.add_sheet("new")
    path = '/Users/chentianbo/Desktop/同创2期/'
    filelist = os.listdir(path)
    for i in filelist:
        data_path = path+i
        full_data  += read_data(data_path)
        length = len(full_data)
    full_data.insert(0,['日期','证券代码', '名称', '数量', '单位成本', '市价', '市值', '市值占净值%', '估值增值'])
    write_new_excel(row_num,full_data,new_table)
    print('length:',length)
    new_data.save('/Users/chentianbo/Desktop/formated.xls')

run()

print(len(length0))