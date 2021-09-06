import os 
import shutil


def del_oldfiles():
    path = '/Users/chentianbo/Desktop/temp_file/'
    del_list = os.listdir(path)
    for i in del_list:
        os.remove(path+i)
    # path2 = '/Users/chentianbo/Desktop/haerbin/zips/'
    # del_list2 = os.remove(path2)
    # for j in del_list2:
    #     os.remove(path+'/'+j)

def get_files(file_path):
    file_list = os.listdir(file_path)
    dex = file_list.index('.DS_Store')
    file_list.pop(dex)
    # print(file_list)
    return file_list


def make_dir(file_path,file_list):
    name_list = []
    whole_path = file_path+"/"+file_list[0]
    name_demo = os.listdir(whole_path)
    print(name_demo)
    for name in name_demo:
        # if "(" in name:
        #     name1 = name.split('(')[2].split(')')[0]
        if "合并估值表" not in name :
            if '-' in name :
                name1 = name.split('-')[1].split('_')[0]
            else:
                name1 = name.split('_')[0]
            if name1 not in name_list:
                print('not in!!!')
                print(name1)
                name_list.append(name1)
    print(name_list)

    for i in name_list:
            os.mkdir("/Users/chentianbo/Desktop/temp_file/"+i)


def get_valuetables(file_path,file_list):
    for date_file in file_list:
        xls_path = file_path+date_file+'/'
        print(xls_path)
        value_tables = os.listdir(xls_path)
        print(value_tables)
        for table2 in value_tables:
            # if "(" in table2:
            #     x = table2.split('(')[2].split(')')[0]
            if "合并估值表" not in table2 :
                if '-' in table2:
                    x = table2.split('-')[1].split('_')[0]
                else:
                    x = table2.split('_')[0]
                shutil.move(xls_path+table2,'/Users/chentianbo/Desktop/temp_file/'+x+"/"+table2)

       



def run():
    # del_oldfiles()
    file_path = ("/Users/chentianbo/Desktop/haerbin/zips/")
    file_list = get_files(file_path)
    make_dir(file_path,file_list)
    get_valuetables(file_path,file_list)


run()