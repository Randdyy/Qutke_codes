#
# @lc app=leetcode.cn id=1 lang=python3
#
# [1] 两数之和
#

# @lc code=start
class Solution:
    def twoSum(self, nums, target) :
# @lc code=end

        if int(target/2) == target/2 and  len(list(filter(lambda x: x==int(target/2),nums)))==2:
            print(list(filter(lambda x: x==int(target/2),nums)))
            first = nums.index(target/2)
            second = nums.index(target/2,first+1)
            print(first,second)
            return [first,second]
           
        else:
            for i  in nums:
                if target-i in nums and nums.index(i) != nums.index(target-i) :
                    return [nums.index(i),nums.index(target-i)]

a = Solution()
a.twoSum([3,3],6)