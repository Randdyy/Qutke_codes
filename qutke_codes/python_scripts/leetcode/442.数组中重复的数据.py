#
# @lc app=leetcode.cn id=442 lang=python3
#
# [442] 数组中重复的数据
#
from collections import Counter

# @lc code=start
class Solution:
    def findDuplicates(self, nums) :
        final_list = []
        for i,j in Counter(nums).items():
            print(i,j)
            if j == 2:
                final_list.append(i)
        print(final_list)
        return final_list
        # print(Counter(nums))
# @lc code=end

a  = Solution()
a.findDuplicates([4,3,2,7,8,2,3,1])