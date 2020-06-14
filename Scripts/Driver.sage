
# Imports

attach('Lib.sage')
attach('PhiSumLibs.sage')

import os

# ==========================================================================

# --- SEEDS ---

n = 2
nthNum = 1
printSummary = 4
numberOfAs = 12
primeCases = True	# Is ai always prime?
denIsPrime = True	# Is the denominator prime?
# logLimit = 63 # Log upper limit


# fileName = 'temp'
# printer = getPrinter(fileName)


# --------------------------------------------------------------------------





# --------------------------------------------------------------------------

reader = getReader('IRatio - Lows.txt')

lineReader = reader.readlines()


from sage.plot.scatter_plot import ScatterPlot

points = []
x = []
y = []

for line in lineReader:
	splitVal = line.split(',')

	y2 = splitVal[3].strip('\n')
	y1 = splitVal[2]
	y0 = splitVal[1]

	num = splitVal[0]

	val = int(y1)/5000

	# if val > 0.3 and 0.37 > val:
	points.append((num, val))
	x.append(val)
	# 	y.append(float(splitVal[0]))
	# print(num)


# for each in points:
# 	print(each[0], sqrt(int(each[0])))


plot = scatter_plot(points, marker = 's')
plot.show()

# --------------------------------------------------------------------------

# print('-'*30)
# print(' N	---	pf(gcd)')
# print('-'*30)

# for i in xsrange(2,30):
# 	gcd_val = returnGCD(n = i, printSummary = 5)

# 	printList = map(str,[	i,
# 							pf(gcd_val)
# 						])

# 	print(' ' + '	---	'.join(printList))

	# printer.write(','.join(printList) + '\n')

# --------------------------------------------------------------------------

# print('-'*85)
# print('N	---   gcd(Primes - 1)	--- 	   div(n,2)	---	     Hypothesis')
# print('-'*85)

# for i in xsrange(1,10):
# 	gcd_val = returnGCD(n = i, printSummary = 5, retVal = 'gcdtots')
	
# 	printList = map(str,[	i,
# 							gcd_val,
# 							divisibilityOf(i,2),
# 							gcd_val == (2**(divisibilityOf(i,2)+1) if i%2==0 else 1)
# 						])

# 	print('	---  		'.join(printList))

# print('-'*85)

# 	#	gcdtots

# --------------------------------------------------------------------------

# Testing the difference between gcds for composite cases and prime cases
# They seem to be the same, usually


# print('N	---  gcd(comp)	---	gcd(primes) --- Different\n' + '-'*57)

# for N in xsrange(1,37):

# 	newGCDCompositeCases = returnGCD(n = N, printSummary = 5, primeCases = False)
# 	newGCDPrimeCases = returnGCD(n = N, printSummary = 5, primeCases = True)

# 	printList = map(str,[	N,
# 							newGCDCompositeCases,
# 							newGCDPrimeCases,
# 							newGCDPrimeCases != newGCDCompositeCases
# 						])

# 	print('	---	'.join(printList))

# --------------------------------------------------------------------------
