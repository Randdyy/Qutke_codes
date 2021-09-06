a=[1,2,3,4,5,10]
a = sorted(a,reverse=True)
print(a)
b=[1,3,2,1,0,0]
index=(0,1,2,3,4,5)
d = 0*len(a)
for i,j in zip(a,list(zip(*sorted(zip(b,index),reverse=True)))[1]) :
    d[j] = i



# print(zip(b,index))
# print(sorted(zip(b,index),reverse=True))
# print(zip(*sorted(zip(b,index),reverse=True)))[1]



print(d)