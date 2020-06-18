
import matplotlib.pyplot as plt

reader = getReader('Multiplicative Order Ratios\\Mod N = 2.csv')

lineReader = reader.readlines()

points = []
x = []
y = []

for line in lineReader:
	splitVal = list(map(int, [each.strip('\n') for each in line.split(',')]))

	num = splitVal[0]

	val = splitVal[2]/sum(splitVal[1:])

	# if 0.5 < val < 0.69:
	points.append((num, val))
	x.append(val)
	y.append(num)
		# print(pf(num))

# print(sum(x)/len(x))

plot = scatter_plot(points, marker = 's')
plot.show()
