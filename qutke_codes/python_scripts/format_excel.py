import xlrd
import xlwt


source_path = '/Users/chentianbo/Desktop/source_data.xlsx' # 源excel路径

save_path ='/Users/chentianbo/Documents/formated_data.xls'   # 保存的新excel路径

row_quantity=10 #这里的10代表最后结果数据一行有多少列

source_quantity = 557 # 577 这是原始数据的行数 一共多少行这里就填多少

source_col = ['','','','','']# 这是原始数据一行有多少列['','','','','']原来数据一行五列  []里就有五个''

data = xlrd.open_workbook(source_path)


table = data.sheets()[0]

new_data = xlwt.Workbook()

new_table = new_data.add_sheet("new")


def read_row_data():
    new_row = []
    for i in range(source_quantity): 
        row_data = table.row_values(i)[:5]
        # print(row_data)
        if row_data != source_col: 
            new_row = new_row+row_data
    return new_row

def handel_data(new_row,new_table,group_num):
    row_num = 0
    for i in range(group_num):
        start = i*row_quantity
        end = (i+1)*row_quantity

        print('start:',start, "     end:",end)
        
        write_row = new_row[start:end]

        col_num = 0
        row_num +=2

        for j in write_row:
            new_table.write(row_num,col_num,j)
            col_num+=1

new_row = read_row_data()
# print(new_row)
print(len(new_row)/row_quantity)
group_num = int((len(new_row)/row_quantity))
handel_data(new_row,new_table,group_num)
new_data.save(save_path)


