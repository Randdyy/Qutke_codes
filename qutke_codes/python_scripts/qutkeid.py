import json 
import os
def read(a,file_name,error_list):
    
    with open("/Users/chentianbo/Documents/Git_projects/my_own_codes/python_scripts/json_files/"+file_name,'r') as f:
    
        load_dict = json.load(f)
        print(type(load_dict))
        # print(load_dict)
        stock_list = load_dict['list']
        try:
            for i in stock_list :        
                a.write(i['name']+': '+i['_qutkeId']+'\n')
        except:
            a.write(i['name']+':'+'null'+'\n')
            error_list.append(i['name'])
    
def run():
    error_list = []
    with open("/Users/chentianbo/Documents/Git_projects/my_own_codes/python_scripts/json_files/final1.txt",'w') as a:
        file_list = os.listdir("/Users/chentianbo/Documents/Git_projects/my_own_codes/python_scripts/json_files/")
        print(file_list)
        for file_name in file_list:
            if 'json' in file_name:
                read(a,file_name,error_list)
                # a.write('-'*20+'\n')


    print(error_list)
        # read(a)
run()