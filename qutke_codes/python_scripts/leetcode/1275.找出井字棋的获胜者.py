#
# @lc app=leetcode.cn id=1275 lang=python3
#
# [1275] 找出井字棋的获胜者
#

# @lc code=start
class Solution:
    def tictactoe(self, moves) -> str:
        
# @lc code=end
        lines = [['', '', ''], 
                 ['', '', ''],
                 ['', '', '']]
        
        # chess1 = 'A'
        # chess2 = 'B'
        trigger = False
        for i in moves:
            trigger = not trigger
            if trigger:
                chess = 'A'
            else:
                chess = 'B'
            lines[i[0]][i[1]]=chess
        print(lines)
        flag = False
        
        if lines[0][0] == lines[0][1] == lines[0][2] != '':
            winner = lines[0][0]
            flag = True
        elif lines[1][0] == lines[1][1] == lines[1][2] != '':
            winner = lines[1][0]
            flag = True
        elif lines[2][0] == lines[2][1] == lines[2][2] != '':
            winner = lines[2][0]
            flag = True
        elif lines[0][0] == lines[1][0] == lines[2][0] != '':
            winner = lines[0][0]
            flag = True
        elif lines[0][1] == lines[1][1] == lines[2][1] != '':
            winner = lines[0][1]
            flag = True
        elif lines[0][2] == lines[1][2] == lines[2][2] != '':
            winner = lines[0][2]
            flag = True
        elif lines[0][0] == lines[1][1] == lines[2][2] != '':
            winner = lines[0][0]
            flag = True
        elif lines[0][2] == lines[1][1] == lines[2][0] != '':
            winner = lines[0][2]
            flag = True
        
        if flag == False and len(moves)==9:
            return "Draw"
        if flag == False and len(moves)<9:
            return 'Pending'
        if flag == True:
            return winner




        

a  = Solution()
moves = [[0,0],[1,1]]

result = a.tictactoe(moves)
print(result)