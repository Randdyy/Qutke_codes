class Animal:
    def __init__(self, name):
        
        self.name = name
    
    def Roar(self):
        print(f"i am {self.name}")



cat = Animal('猫')
cat.Roar()


