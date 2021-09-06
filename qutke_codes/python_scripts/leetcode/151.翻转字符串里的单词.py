#
# @lc app=leetcode.cn id=151 lang=python3
#
# [151] 翻转字符串里的单词
#

# @lc code=start
class Solution:
    def reverseWords(self, s: str) -> str:
# @lc code=end
        print(' '.join(s.split()[::-1]))


a = Solution()
a.reverseWords(s = "  Bob    Loves  Alice   ")
        

