class Solution:
    def predictPartyVictory(self, senate: str) -> str:
        dota_list = list(senate)

        while 1:            
            if "R" not in dota_list:
                return "Dire"
            if "D" not in dota_list:
                return "Radiant"
            flag = 0
            for i in dota_list:
                flag += 1 
                if i == 'D':

                    dota_list.pop(dota_list.index('R'))
                    if "R" not in dota_list:
                        return "Dire"
                    if "D" not in dota_list:
                        return "Radiant"
                    print("i='D'",dota_list)
                elif i == 'R':
                    dota_list.pop(dota_list.index('D'))
                    if "R" not in dota_list:
                        return "Dire"
                    if "D" not in dota_list:
                        return "Radiant"
                    print("i='R'",dota_list)
            print("2:",dota_list)

a = Solution()
print("     ",list("DRRDRDRDRDDRDRDR"))
a.predictPartyVictory("DRRDRDRDRDDRDRDR")

