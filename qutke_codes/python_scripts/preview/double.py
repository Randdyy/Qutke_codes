class Node1:
    def __init__(self, initdata):
        self.__data = initdata
        self.__next = None

    def getData(self):
        return self.__data

    def getNext(self):
        return self.__next

    def setData(self, newdata):
        self.__data = newdata

    def setNext(self, newnext):
        self.__next = newnext

class SinCycLinkedlist:
    def __init__(self):
        self.head = Node1(None)
        self.head.setNext(self.head)

    def add(self, item):
        temp = Node1(item)
        temp.setNext(self.head.getNext())
        self.head.setNext(temp)