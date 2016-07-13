import re

f = open('remove.log', 'r')
s = ""
for i in f:
	s += i + '\n'

s = re.sub(':.*?', '', s)
s = re.sub(r'\([^)]*\)', '', s)
s = re.sub(',', '', s)
s = re.sub('amd64', '', s)

f = open('replaced.txt', 'w')
f.write(s)
