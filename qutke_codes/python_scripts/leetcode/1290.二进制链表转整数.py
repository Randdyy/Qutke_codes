#
# @lc app=leetcode.cn id=1290 lang=python3
#
# [1290] 二进制链表转整数
#

# @lc code=start
# Definition for singly-linked list.
class ListNode:
    def __init__(self, x):
        self.val = x
        self.next = None

class Solution:
    def getDecimalValue(self, head) -> int:
        final_str = ''
        while head:
            final_str += str(head.val)
            head = head.next
        print(int(final_str,2))
        return int(final_str,2)



        # bin_num  = ''
        # ret = str(head)
        # for i in ret:
        #     if i.isdigit():
        #         bin_num +=i
        # print(int(bin_num,2))
        # return int(bin_num,2)


node1 = ListNode(1)
node2 = ListNode(0)
node3 = ListNode(1)

node1.next = node2
node2.next = node3
node3.next = None


x = Solution()

x =x.getDecimalValue(node1)