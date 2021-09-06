import xlrd
import xlwt

data = xlrd.open_workbook('/Users/chentianbo/Desktop/whole_test.xlsx')

table = data.sheets()[0]

new_data = xlwt.Workbook()
new_table = new_data.add_sheet('new_data')



def read_row_data():
    new_row=[]
    for i in range(1030):
        row_data = table.row_values(i)[1:]
        if row_data != ['', '', '', '', '', '', '', '', '', '']:
            new_row = new_row+row_data
    return new_row
    

def handel_data(new_row,new_table):
    row_num = 0
    for i in range(96):
        start = i * 80
        end = (i+1)*80

        print('start:',start,"   end:",end)

        write_row = new_row[start:end]
        # write_data(write_row,new_table,row_num)
        col_num = 0
        row_num+=2
        for j in write_row:
            # print('col_num ：',col_num)
            new_table.write(row_num,col_num,j)
            col_num+=1


new_row = read_row_data()
print(len(new_row)/80)
handel_data(new_row,new_table)
new_data.save('/Users/chentianbo/Desktop/new_excel.xls')














    
