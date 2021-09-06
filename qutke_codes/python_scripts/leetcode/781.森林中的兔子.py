#
# @lc app=leetcode.cn id=781 lang=python3
#
# [781] 森林中的兔子
#
from collections import Counter
import math
# @lc code=start
class Solution:
    def numRabbits(self, answers) -> int:
        
# @lc code=end
        # x = (j/(i+1))*(i+1) for i, j in Counter(answers).items()
        # [math.ceil]
        # return sum()
        print(Counter(answers))

        return True

a = Solution()
a.numRabbits([1, 1, 2])

