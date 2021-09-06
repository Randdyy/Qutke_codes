#
# @lc app=leetcode.cn id=1439 lang=python3
#
# [1439] 有序矩阵中的第 k 个最小数组和
#

# @lc code=start
class Solution:
    def kthSmallest(self, mat, k: int) -> int:
# @lc code=end
        res = [0]
        flag = 0 
        for row in mat:
            flag+=1
            print(flag)
            # x = [ x+r for x in row for r in res ]
            # print(x)
            res = sorted([ x+r for x in row for r in res ])[:k]
            # print(res)
        print(res)
        return res[-1]
      

        # for row in mat:
        #     print(row)
        #     print(sorted([ x+r for x in row for r in res ])[:k])
        # print(res)


a= Solution()
a.kthSmallest([[1,10,10],[1,4,5],[2,3,6]], k = 7)