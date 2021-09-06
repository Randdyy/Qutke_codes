class Solution:
    def maxSumRangeQuery(self, nums, requests) :
        n = len(nums)
        nums.sort()
        print(nums)
        s = [0]*(n+1)
        print(s)
        times = [0]*(n+1)
        print(times)
        for x,y in requests:
            s[x] += 1
            s[y+1] -= 1
        print(s)
        for i in range(1,n+1):
            print('i:'+str(i),times[i-1],s[i-1])
            times[i] = times[i-1] + s[i-1]
            
        times.sort()
        res = 0
        for i in range(n):
            res += nums[i] * times[i+1]
        return res%1000000007

a = Solution()
x= a.maxSumRangeQuery(nums = [1,2,3,4,5,10],requests = [[0,2],[1,3],[1,1]])
print(x)



# class Solution:
#     def maxSumRangeQuery(self, nums: List[int], requests: List[List[int]]) -> int:
#         n = len(nums)
#         # 对nums进行排序
#         nums.sort()
#         # s为差分数组，s的前缀和数组为times
#         s = [0]*(n+1)
#         # times[i]表示对下标i的查询次数
#         times = [0]*(n+1)
#         # 每个查询，对[x,y]中每个数字都查询一次，相当于对times[x]到times[y]所有数＋1
#         # 使用差分数组只需对s[x]和s[y+1]进行修改即可
#         for x,y in requests:
#             s[x] += 1
#             s[y+1] -= 1
#         # 对差分数组进行求前缀和
#         for i in range(1,n+1):
#             times[i] = times[i-1] + s[i-1]
#         # 对times次数数组进行排序
#         times.sort()
#         res = 0
#         # 出现次数最多的下标，应该为nums中最大的数字，以此类推，出现次数最小的下标应该为nums中最小的数字...
#         # 只求乘积之和res即可
#         for i in range(n):
#             res += nums[i] * times[i+1]
#         return res%1000000007