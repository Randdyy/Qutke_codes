Pyname = "Python教程"
Pyadd = "http://c.biancheng.net/python/"
def text():
    #局部变量
    Shename = "shell教程"
    Sheadd= "http://c.biancheng.net/shell/"
    print("函数内部的 locals:")
    print(locals())
text()
print("函数外部的 locals:")
print(locals())