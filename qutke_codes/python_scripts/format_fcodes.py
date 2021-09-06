list1 = []
with open('/Users/chentianbo/Desktop/大家保险f_codes.txt','r') as f:

    lines = f.readlines()
    # print(lines)
    for i in lines:
        list1.append(i.strip())


    print(list1)


print(len(list1))

print(len(list(set(list1))))