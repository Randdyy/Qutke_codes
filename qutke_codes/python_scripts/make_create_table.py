with open('./test.txt','r') as f:
    lines = f.readlines()

list1 = []
for i in lines:
    list1.append(i.strip())

table_name = list1[:20]

table_type = list1[20:]

print(len(table_name))
print(len(table_type))

final_list = []
for i in range(len(table_name)):
    print('comment on column ftuser.libra_subject_info.'+table_type[i]+ ' is ' + "\'"+table_name[i]+"\'"+';')

# print(final_list)

# for i in final_list:
#     print(i)
