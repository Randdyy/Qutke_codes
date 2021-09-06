
class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None
class Solution:
    def getMinimumDifference(self, root) -> int:
        self.res = float('inf')
        self.tmp = -1
        print('root:',root)
        def dfs(root):
            if not root:
                print(root ,'is not root')
                return
            dfs(root.left)
            if self.tmp == -1:
                print('tmp = val:',str(self.tmp)+'='+str(root.val))
                self.tmp = root.val
            else:
                print('res:'+str(self.res),' root.val:'+str(root.val),' self.tmp:'+str(self.tmp))
                self.res = min(self.res, abs(root.val - self.tmp))
                self.tmp = root.val
            dfs(root.right)
        print('start')
        dfs(root)
        return self.res


node1 = TreeNode(1)
node3 = TreeNode(3)
node2 = TreeNode(2)

node1.right = node3
# node3.left = node2
a = Solution()
a.getMinimumDifference(node1)