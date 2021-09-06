table_names = ['ASHAREBALANCESHEET.txt','ASHARECASHFLOW.txt','ASHAREINCOME.txt','HS300IEODPRICES.txt','CBONDDESCRIPTION.txt']

for table_name in table_names:
    qutke_cols = []
    hx_cols = []
    len_qutke = 0 
    len_hx = 0
    missed_list = []
    final_list = []
    with open ('./sqls/qutke/'+table_name) as qutke_f:
        lines = qutke_f.readlines()
        for i in range(len(lines)):
            lines[i] = lines[i].strip().split(' ')[0]
        # print(lines)
        # print(len(lines))
        len_qutke = len(lines)
        qutke_cols = lines
    
    with open ('./sqls/hx/'+table_name) as hx_f:
        lines = hx_f.readlines()
        for i in range(len(lines)):
            lines[i] = lines[i].strip().split(' ')[0]
        # print(lines)
        # print(len(lines))
        len_hx = len(lines)
        hx_cols = lines
    print('\n表 wind.'+table_name.split('.')[0]+' 相差了 '+ str(len_qutke-len_hx)+' 个字段')
    with open('./sqls/missed/'+table_name,'w') as w:
        for i in qutke_cols:
            if i not in hx_cols:
                # print(i)
                final_list.append(i)
                w.write(i+'\n')
        print(final_list)
    
        for i in hx_cols:
            if i not in qutke_cols:
                print('hx:'+i)    

