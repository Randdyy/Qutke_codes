class Solution:
    '''暴力解'''
    def containsNearbyAlmostDuplicate(self, nums:[], k: int, t: int) -> bool:
        if len(list(set(nums)))!= len(nums) and t==0 and len(nums)>k:
            for i in range(len(nums)):
                if len(list(set(nums[i:i+k+1]))) == len(nums[i:i+k+1]):
                    pass
                    # print(i,len(list(set(nums[i:i+k+1]))),len(nums[i:i+k+1]))
                else:
                    # print("true")
                    return True
                if  len(nums[i:i+k]) < k:
                    # print(len(nums[i:i+k]))
                    # print(1,"false")
                    return False
            else:
                # print("2","false")
                return False
        if len(list(set(nums))) == len(nums) and t==0:
            return False
        for i in range(len(nums)):
            flag = 1
            for j in range(i+1,len(nums)):
                if flag > k:
                    break
                else :
                    flag+=1
                if abs(nums[i]-nums[j])<=t:
                    print('True')
                    print(i,j)
                    return True
                else:
                    continue
        else:

            print('False')

            return False

x = Solution()

x.containsNearbyAlmostDuplicate([1,2,3,1],3,0)



        