class Node:
    def __init__(self,initdata):
        self.__data = initdata
        self.__next = None 

    def get_data(self):
        return self.__data
    
    def set_data(self,data):
        self.__data = data

    def get_next(self):
        return self.__next
    
    def set_next(self,new_next):
        self.__next = new_next

class CyclList:
    def __init__(self):
        self.head = Node(None)
        self.head.set_next(self.head)

    def add(self,item):
        temp = Node(item)
        temp.set_next(self.head.get_next())
        self.head.set_next(temp)


    def remove(self,item):
        pass




# class Person:
#     def __init__(self,name):
#         self.__name = name 
#         self.name = name

#     def get_name(self):
#         return self.__name

#     def set_name(self,new_name):
#         if len(new_name) <=5:
#             print('名字长度需要大于5')

#         else:
#             self.__name = new_name

# P =Person('aab')
# print(P.get_name())

# # print(P.name)
# P.set_name('bbc')
# print(P.get_name())
# P.set_name('asdfasdfasdf')
# print(P.get_name())





# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
    
#     def __repr__(self):
#         l = []
#         this = self
#         while this:
#             l.append(this.val)
#             this = this.next
#         return str(l)

# l1 = ListNode(4)
# l2 = ListNode(2)
# l3 = ListNode(1)
# l4 = ListNode(3)
# l3.next = l4
# l2.next = l3
# l1.next = l2

# class Solution:
#     def insertionSortList(self, head: ListNode) -> ListNode:
#         result = ListNode(0)
#         result.next = head
#         last = head
#         curr = head.next
#         # print(head, last, curr)
#         while curr:
#             if last.val <= curr.val:
#                 last = last.next
#             else:
#                 prev = result
#                 while prev.next.val <= curr.val:
#                     prev = prev.next
#                 last.next = curr.next
#                 curr.next = prev.next
#                 prev.next = curr
#             curr = last.next

#         return result.next

# b = Solution()
# a= b.insertionSortList(l1)
# print(a)