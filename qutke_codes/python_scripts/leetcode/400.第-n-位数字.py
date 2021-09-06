#
# @lc app=leetcode.cn id=400 lang=python3
#
# [400] 第 N 位数字
#

# @lc code=start
class Solution:
    def findNthDigit(self, n: int) -> int:
        cnt = 1
        num = 9
        '''
        1  - 9  一共 9 个整数 9*1 个数
        10 - 99 一共 90 个整数，90*2 个数
        100 - 999 一共 900 个整数， 900*3 个数
        '''
        while n>num*cnt:
            n-=num*cnt  # 需要减去前面的数
            print(n)
            cnt+=1      # 位数加一
            num*=10     # 整数个数加十
            print(cnt,num)
        print(cnt,num)


        target = num//9+(n-1)//cnt # 锁定到第几个整数 
        index = (n-1)%cnt           # 锁定到整数的第几位
        print(str(target)[index] )
        return str(target)[index]  
a = Solution()
a.findNthDigit(1244)





