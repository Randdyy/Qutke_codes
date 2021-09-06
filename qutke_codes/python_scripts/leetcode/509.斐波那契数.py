#
# @lc app=leetcode.cn id=509 lang=python3
#
# [509] 斐波那契数
#

# @lc code=start
class Solution:
    def fib(self, n: int) -> int:
# @lc code=end
        target = [0,1]
        for i in range(n-1):
            target.append(target[-1]+target[-2])
        print(target[-1])
        return target[-1]


a = Solution()
a.fib(3)