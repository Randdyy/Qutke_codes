# class Person():
#     age = 20
#     name = []

# p1 = Person()
# p2 = Person()

# p1.name.append('xiaoming')
# Person.age = 22

# print(p1.name,p1.age)
# print(p2.name,p2.age)

class Person:
    name = []
    age = 20

p1 = Person()
p2 = Person()
Person.age = 22

print(id(Person.name),id(p1.name),id(p2.name),id(["xiaoming"]))
p1.name.append("xiaoming")
print(id(Person.name),id(p1.name),id(p2.name),id(["xiaoming"]))
#print(id(Person.age),id(22))

#print(p1.name,p1.age)
#print(p2.name,p2.age)