
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

# reader = getReader('Multiplicative Order Ratios/Mod N = 11.csv')

# lineReader = reader.readlines()


# from sage.plot.scatter_plot import ScatterPlot

# points = []
# x = []
# y = []

# for line in lineReader:
# 	splitVal = list(map(int, [each.strip('\n') for each in line.split(',')]))

# 	num = splitVal[0]

# 	val = splitVal[1]/sum(splitVal[1:])

# 	points.append((num, val))
# 	x.append(val)

# 	if is_square(num):
# 		print('-'*20)

# 	if val < 0.04:
# 		print(pf(num))

# 	# 	y.append(float(splitVal[0]))


# # for each in points:
# # 	print(each[0], sqrt(int(each[0])))


# plot = scatter_plot(points, marker = 's')
# plot.show()
# # reader.close()

# --------------------------------------------------------------------------

# print('-'*30)
# print(' N	---	pf(gcd)')
# print('-'*30)

# for i in xsrange(2,20):
# 	gcd_val = returnGCD(n = i, printSummary = 5)

# 	div = divisibilityOf(gcd_val, i)

# 	printList = [str(i), str(i) + '^' + str(div) + '  ' + pf(gcd_val/(i**div))]


# 	# printList = map(str,[	i,
# 	# 						pf(gcd_val)
# 	# 					])

# 	print(' ' + '	---	'.join(printList))

# # 	# printer.write(','.join(printList) + '\n')

# --------------------------------------------------------------------------

print('-'*85)
print('N	---   gcd(Primes - 1)	--- 	   div(n,2)	---	     Hypothesis')
print('-'*85)

for i in xsrange(1,10):
	gcd_val = returnGCD(n = i, printSummary = 5, retVal = 'gcdtots')
	
	printList = map(str,[	i,
							gcd_val,
							divisibilityOf(i,2),
							gcd_val == (2**(divisibilityOf(i,2)+1) if i%2==0 else 1)
						])

	print('	---  		'.join(printList))

print('-'*85)

	#	gcdtots

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


# ------------------------------
#  N      ---     pf(gcd)
# ------------------------------
#  2      ---     2^2  1 = 1
#  3      ---     3^1  2 = 2
#  4      ---     4^1  2 = 2
#  5      ---     5^1  4 = (2**2)
#  6      ---     6^1  16 = (2**4)
#  7      ---     7^1  2 = 2
#  8      ---     8^1  2 = 2
#  9      ---     9^1  24 = (2**3) x 3
#  10     ---     10^1  8 = (2**3)
#  11     ---     11^1  4 = (2**2)
#  12     ---     12^1  32 = (2**5)
#  13     ---     13^1  4 = (2**2)
#  14     ---     14^1  16 = (2**4)
#  15     ---     15^2  32 = (2**5)
#  16     ---     16^1  2 = 2
#  17     ---     17^1  8 = (2**3)
#  18     ---     18^2  64 = (2**6)
#  19     ---     19^1  4 = (2**2)
#  20     ---     20^1  64 = (2**6)
#  21     ---     21^2  32 = (2**5)
#  22     ---     22^1  16 = (2**4)
#  23     ---     23^1  2 = 2
#  24     ---     24^1  64 = (2**6)
#  25     ---     25^2  16 = (2**4)
#  26     ---     26^1  32 = (2**5)
#  27     ---     27^2  16 = (2**4)
#  28     ---     28^1  32 = (2**5)
#  29     ---     29^1  8 = (2**3)
#  30     ---     30^2  9216 = (2**10) x (3**2)
#  31     ---     31^1  4 = (2**2)
#  32     ---     32^1  2 = 2
#  33     ---     33^3  64 = (2**6)
#  34     ---     34^1  32 = (2**5)
#  35     ---     35^2  192 = (2**6) x 3
#  36     ---     36^2  384 = (2**7) x 3
#  37     ---     37^1  8 = (2**3)
#  38     ---     38^1  16 = (2**4)
#  39     ---     39^3  64 = (2**6)
#  40     ---     40^1  128 = (2**7)
#  41     ---     41^1  4 = (2**2)
#  42     ---     42^2  6144 = (2**11) x 3
#  43     ---     43^1  2 = 2
#  44     ---     44^1  32 = (2**5)
#  45     ---     45^4  3072 = (2**10) x 3
#  46     ---     46^1  16 = (2**4)
#  47     ---     47^1  4 = (2**2)
#  48     ---     48^2  8 = (2**3)
#  49     ---     49^1  56 = (2**3) x 7
#  50     ---     50^2  1280 = (2**8) x 5
