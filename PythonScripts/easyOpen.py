import os
import re

DataPath = os.path.expanduser('/Users/afuglem/Books/201hw/')


indicies = []
values = []
count = 0

for root, dirs, files in os.walk(DataPath):
    for file in files:
        if file.endswith(".pdf"):
            # print(file + '--------')
            pattern = r'[\d]+'
            single = re.search(pattern, file)

            if single is not None:
                # print(single[0])
                values.append(os.path.join(DataPath, file))
                indicies.append(single[0])

                count += 1
        fileDict = dict(zip(indicies, values))


# print(fileDict)

sortedKeys = []
for key, value in fileDict.items():
    sortedKeys.append(key)
    pass

sortedKeys = sorted(sortedKeys)
for i in sortedKeys:
    print('  ' + i)

# print("  {}  ".format(int(key)))

numberToOpen = input(" Which homework number? ")
if numberToOpen not in fileDict:
    raise KeyError('Invalid key :(')

os.system("open "+fileDict[numberToOpen])
