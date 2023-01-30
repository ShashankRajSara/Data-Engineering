fileobj = open('futurense.txt', 'r')

# r, w, r+, w+, rb, rb+, wb, wb+, a, ab, ab+

# a+ => append & read

#read

data=fileobj.read()
fileobj.close()
print(data)

#write

fileobj1 = open('futurense1.txt', 'w')
fileobj1.write('New Contents added')
fileobj1.close()


#read & write

fileobj2 = open('futurense1.txt', 'r+')
data=fileobj2.read()
fileobj2.write(' new update')
fileobj2.close()

# seek changes the position of the cursor
fileobj.seek(0)

# returns the present position of the cursor
fileobj.tell()


#new way of file reading
with open('futurense.txt', 'r+') as fileobj:
    data=fileobj.readlines()
print(data)

#Binary
with open('filehandling/futurense.txt','w+') as obj:
    data = int(input("Enter a Number: "))
    print(data)
    obj.write(bin(data))
    # print(obj.read())