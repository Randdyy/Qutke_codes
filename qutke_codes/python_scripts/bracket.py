class Solution:
    def isValid(self, s: str) -> bool:
        left_little = 0
        left_middle = 0
        left_big = 0 
        right_little = 0
        right_middle = 0
        right_big = 0
        flag1 = flag2 = flag3 = False

        for i in list(s):
            if i == '(':
                left_little += 1
            if i == '[':
                left_middle += 1
            if i == '{':
                left_big += 1 
        for i in list(s):
            if i == ')':
                right_little += 1
            if i == ']':
                right_middle += 1
            if i == '}':
                right_big += 1 

        # if left_little>right_little or left_big >right_big or left_middle>right_middle:
        #     print('false')
        # if list(str).index('(') > list(str).index(')') or list(str).index('[') > list(str).index(']')  or list(str).index('{') > list(str).index('}'):
        #     print('false')

        if left_little == right_little and left_big == right_big and left_middle == right_middle:
            little_index=0
            middle_index=0
            big_index = 0
            little_list = middle_list = big_list = []
            for i in range(left_little):
                if list(s).index('(',little_index,len(list(s))) < list(s).index(')',little_index,len(list(s))) and list(s).index(')',little_index,len(list(s))) not in little_list:
                    little_index = list(s).index('(',little_index,len(list(s)))
                    little_list.append(list(s).index(')',little_index,len(list(s))))
                    continue
                else:
                    flag1 = False
                    break
            else:
                flag1 = True
                
            for i in range(left_middle):
                if list(s).index('[',middle_index,len(list(s))) < list(s).index(']',middle_index,len(list(s))) and list(s).index(']',middle_index,len(list(s))) not in middle_list:
                    middle_index = list(s).index('[',middle_index,len(list(s)))
                    middle_list.append(list(s).index(']',middle_index,len(list(s))))
                    continue
                else:
                    flag2 = False
                    break
                    
            else:
                flag2 = True
            for i in range(left_big):
                if list(s).index('{',big_index,len(list(s))) < list(s).index('}',big_index,len(list(s))) and list(s).index('}',big_index,len(list(s))) not in big_list:
                    big_index = list(s).index('{',big_index,len(list(s)))
                    big_list.append(list(s).index('}',big_index,len(list(s))))
                    continue
                else:
                    flag3 = False
                    break
            else:
                flag3=True
    
        if flag1 and flag2 and flag3:
            print('true')
            
        if not (flag1 and flag2 and flag3):
            print('false')


        
a = Solution()
a.isValid("([)]")