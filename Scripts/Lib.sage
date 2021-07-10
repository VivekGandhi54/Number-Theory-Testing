# --- List of function signatures ---
#
#	--- General functions ---
#		def pf(num, primeList):
#		def is2n(num):
#		def divisibilityOf(a, b):
#		def log2(num):
#		def aMinusB(a, b):
#		def removeDuplicates(duplicateList):
#
#	--- Totient functions ---
#		def totientInverse(num):
#		def phiInverse(num):
#		def phi(num):
#		def nthPhi(num):
#
#	--- Prime functions ---
#		def nPrimes(num):
#		def primesUnder(num):
#
#	--- Composite functions ---
#		def nthComposite(n):
#		def nComposites(n):
#		def compositesUnder(n):
#
#	--- Other functions ---
#		def files():
#		def attachedFiles():
#		def getPrinter(fileName):
#		def getReader(fileName):
#		def deleteDataFile(fileName):
#		def editFile(fileName):
#		def viewGraph():

# ==========================================================================
# Imports

from sage.rings.all import Integer
import webbrowser
import os

# ==========================================================================
# ===						General functions							 ===
# ==========================================================================

# Returns the prime factorization of num using sage factor function
# primeList = True returns [[list of prime factors], 'string factorization']
# primeList = False returns 'string factorization'
#
# 1 = 1
# 24 = (2**3) x 3
# 525 = 3 x (5**2) x 7
#
# pf(525, True) = [[3, 5, 7], '525 = 3 x (5**2) x 7']
# pf(525, False) = '525 = 3 x (5**2) x 7'

def pf(num, primeList = False):
	if num == 1:
		if primeList:
			return [[1], '1 = 1']
		return '1 = 1'

	primeFactors = []

	retVal = f'{num} = '

	for each in factor(num):
		primeFactors.append(each[0])

		if each[1] == 1:
			retVal += f'{each[0]} x '
		else:
			retVal += f'({each[0]}**{each[1]}) x '

	retVal = retVal.rstrip(' x ')

	if primeList:
		return [primeFactors, retVal]

	return retVal

# ==========================================================================
# Returns true if num = 2**n for some integer n

def is2n(num):
	while num > 1:
		if num & 0x1 == 1:
			return False

		num = num >> 1

	return True

# ==========================================================================
# How many times can b divide a?

def divisibilityOf(a, b):
	div = 0

	if b == 1:
		return 1

	while a%b == 0:
		a = a//b
		div += 1

	return div

# ==========================================================================
# What power of 2 is a? Thows AssertionError if a != 2**n

def log2(a):
	div = 0
	while a > 1:
		if a & 0x1 == 1:
			raise AssertionError('Not power of 2')

		a = a >> 1
		div += 1

	return div

# ==========================================================================
# Return difference of two sets a and b (a - b)
# For all elements in (a - b), element in a but not b.
#
# a = [2, 4, 6, 8, 10, 12]
# b = [1, 2, 3, 4, 5, 6]
# c = aMinusB(a,b) = [8, 10, 12]
# print c -> [8, 10, 12]

def aMinusB(a, b):
	return [each for each in a if each not in b]

# ==========================================================================
# removeDuplicates([1, 1, 1, 2, 3, 4, 4]) = [1, 2, 3, 4]
# Works for unhashable types too, unlike other methods

def removeDuplicates(duplicateList):
	return list(set(duplicateList))

# ==========================================================================
# ===						Totient functions							 ===
# ==========================================================================

# Returns finite list of integers whose totient value = num

def totientInverse(num):

	if num == 1:
		return [2]

	# phi(n) is always even
	if num%2 == 1:
		return []

	# ----------------------------------------------------------------------

	prime = 2
	product = 2

	# Find upper limit
	# For all numbers over product, phi(number) > num

	while euler_phi(product) < num:
		prime = next_prime(prime)
		product = product * prime

	# upper limit product is the smallest product of consequetive primes
	# such that product bounds phiInverse(num)

	# ----------------------------------------------------------------------

	# list of values under upper limit where phi(value) = num

	retList = [i for i in xsrange(num + 1, product + 1) if euler_phi(i) == num]

	return retList

# ==========================================================================
# Alternate totientInverse notation

def phiInverse(num):
	return totientInverse(num)

# ==========================================================================
# Alternate euler_phi notation

def phi(num):
	return euler_phi(num)

# ==========================================================================
# Returns [value, n] for first value = phi**n(num) where value is a power of 2
# Phi**n(num) reaches a power of 2 surprisingly quickly

def nthPhi(num):
	power = 0

	while not is2n(num):
		num = euler_phi(num)
		power += 1

	return [num, power]

# ==========================================================================
# ===						Prime functions								 ===
# ==========================================================================

# Returns first n non-even primes
#
# nPrimes(2)	= [3, 5]
# nPrimes(4)	= [3, 5, 7, 11]
# nPrimes(6)	= [3, 5, 7, 11, 13, 17]
# nPrimes(8)	= [3, 5, 7, 11, 13, 17, 19, 23]
# nPrimes(10)	= [3, 5, 7, 11, 13, 17, 19, 23, 29, 31]

def nPrimes(num):
	retList = primes_first_n(num + 1)
	retList.remove(2)

	return retList

# ==========================================================================
# Returns complete list of primes under n
#
# primesUnder(10)	= [3, 5, 7]
# primesUnder(20)	= [3, 5, 7, 11, 13, 17, 19]
# primesUnder(30)	= [3, 5, 7, 11, 13, 17, 19, 23, 29]

def primesUnder(num):
	return prime_range(3, num + 1)

# ==========================================================================
# ===						Composite functions							 ===
# ==========================================================================

# nthComposite(1) = 4
# nthComposite(2) = 6
# nthComposite(3) = 8
# nthComposite(4) = 9
# nthComposite(5) = 10

def nthComposite(n):
	num = 3

	while n > 0:
		if not is_prime(num):
			n -= 1

		num += 1

	return num - 1

# ==========================================================================
# Returns first n composite numbers
#
# nComposites(2)	= [4, 6]
# nComposites(4)	= [4, 6, 8, 9]
# nComposites(6)	= [4, 6, 8, 9, 10, 12]
# nComposites(8)	= [4, 6, 8, 9, 10, 12, 14, 15]
# nComposites(10)	= [4, 6, 8, 9, 10, 12, 14, 15, 16, 18]

def nComposites(n):
	composites = []
	num = 3

	while n > 0:
		if not is_prime(num):
			composites.append(num)
			n -= 1
		num += 1

	return composites

# ==========================================================================
# Returns list of composite numbers under n
#
# compositesUnder(10) = [4, 6, 8, 9, 10]
# compositesUnder(20) = [4, 6, 8, 9, 10, 12, 14, 15, 16, 18, 20]
# compositesUnder(30) = [4, 6, 8, 9, 10, 12, 14, 15, 16, 18, 20, 21, 22, 24, 25, 26, 27, 28, 30]

def compositesUnder(n):

	return [num for num in xsrange(4, n + 1) if not is_prime(num)]

# ==========================================================================
# Print list of sage scripts and files of collected data

def files():

	scriptsPath = os.getcwd()
	dataPath = os.getcwd().replace('Scripts', 'OutputData')

	#	--- Script files ---

	if len(os.listdir(scriptsPath)) > 0:
		print('\n Script Files:')

	for each in os.listdir(scriptsPath):
		if each.endswith('.sage'):
			print('   ' + each)

	#	--- Output data files ---

	if len(os.listdir(dataPath)) > 0:
		print('\n Data locations:	')

	for each in os.listdir(dataPath):
		print('   ' + each)

	print('')

# ==========================================================================
# Print list of files attached to sage session

def attachedFiles():
	import sage.repl.attach as af

	for each in af.attached_files():
		print(each)

# ==========================================================================
# Convert list to string

def printList(item):
	return '[' + ', '.join(map(str,item)) + ']'

# ==========================================================================
# Returns printer to write to file
#
# printer = getPrinter('fileName.ext')
# printer.write('...')
# printer.write('...')
#
# printer.close()

def getPrinter(fileName):
	outputPath = os.getcwd().replace('Scripts', 'OutputData/')

	return open(outputPath + str(fileName), 'w+')

# ==========================================================================
# Returns reader for file
#
# reader = getReader('fileName.ext')
#
# fileData = reader.read() [string]
#
# lineReader = reader.readlines()
# for line in lineReader:
# 	print(line)

def getReader(fileName):
	outputPath = os.getcwd().replace('Scripts', 'OutputData/')

	return open(outputPath + str(fileName), 'r')

# ==========================================================================
# Delete file from OutputData names 'fileName.ext'

def deleteDataFile(fileName):
	path = os.getcwd().replace('Scripts', 'OutputData/') + fileName

	try:
		os.remove(path)
		return True

	except:
		return False

# ==========================================================================
# Opens fileName in Sublime Text 3

def editFile(fileName):

	path = os.getcwd().replace('/home/sage/', 'C:/Users/vgand/') + '/'

	if fileName.endswith('.sage'):
		path += fileName

	path = '"' + path + '"'

	os.system('"C:/Program Files/Sublime Text/sublime_text.exe" ' + path)

# ==========================================================================
# Graph.html reads data.js, where data.js contains 3 variables
#	var limits = [x limit, y limit];				--- Scale used to draw on graph. Origin for graph is (0,0)
#	var gridlines = true/false;						--- true to draw approx 1 inch x 1 inch gridlines
#	var data = [[x1, y1], [x2, y2], ... [xn, yn]];	--- Some n points of scatter-plot data, pre-scaled to fit the graph

def viewGraph():
	fileName = 'Graph.html'

	path = os.getcwd().replace('Scripts', 'OutputData/')

	if 'data.js' not in os.listdir(path):
		print('No data file found!')
	else:
		webbrowser.open_new(path + fileName + ('' if fileName.endswith('.html') else '.html' ))

# ==========================================================================
