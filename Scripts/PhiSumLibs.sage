
# --- List of function signatures ---
#
#	def returnLists(largeSum, power, numAs, primeCases, multipleVals):
#	def recursiveReturnLists(largeSum, power, numAs, primeCases, multipleVals):	
#	def getListOfAs(numberOfAs, denominator, primeCases, retVal):
#	def returnGCD(n, denominator, printSummary, numberOfAs, primeCases, retVal, multipleVals):
#	def printLists(n, primeVals):

# =========================================================================

# Imports

attach('Lib.sage')

from sage.rings.all import Integer

# =========================================================================
# Outer function for recursiveReturnLists.

def returnLists(largeSum, power, numAs = 2, primeCases = True, multipleVals = True):

	ans = recursiveReturnLists(largeSum, power, numAs, primeCases, multipleVals)

	# Postprocessing -> Easier than making recursive function more complicated
	for each in ans:
		if 0 in each:
			ans.remove(each)

		each.sort() # Helps eliminate duplicates too

	# Once they're sorted, some duplicates show up
	ans = removeDuplicates(ans)

	# ans			 = [[7, 11], [5, 13], [1, 17]]
	# ans.reverse()	 = [[1, 17], [5, 13], [7, 11]]
	# Smaller cases first, easier to read
	ans.reverse()

	return ans

# =========================================================================

def recursiveReturnLists(largeSum, power, numAs, primeCases, multipleVals):

	# ---------------------------------------------------------------------
	# ---		Deal with base cases									---
	# ---------------------------------------------------------------------

	if numAs < 1:
		return []

	if numAs == 1:
		if largeSum == 1:
			return [[1]]

		try:
			smallRoot = largeSum.nth_root(power)

			if not primeCases or (is_prime(smallRoot) and smallRoot != 2):
				return [[smallRoot]]
			else:
				return []	# If primeCases and root is composite
		except:
			return []	# If diff is not an integer nth root

	# ---------------------------------------------------------------------
	# ---		Eliminate impracticable cases							---
	# ---------------------------------------------------------------------

	# Cases where largeSum is too small to be viable
	# Ensure no errors when generating prime ranges

	if multipleVals and largeSum < numAs:
		return []

	elif not multipleVals:
		if not primeCases and largeSum < 1 + 2**power:
			return []

		if primeCases and largeSum < 1 + 3**power:
			return []

	# ---------------------------------------------------------------------
	# ---		Find upper and lower BigRoot limits						---
	# ---------------------------------------------------------------------


	# largeSum = a**n + b**n + ...
	# let a >= b...
	# largeSum <= numAs * a**n
	# largeSum/numAs <= a**n
	# (largeSum/numAs)**1/n <= a

	# Upper and lower limits are prime
	if primeCases:

		# Largest possible prime nth-root
		upperLimit = next_prime(floor(largeSum**(1/power)))

		if upperLimit == 2:
			upperLimit = 3
	
		# Smallest possible large prime in the tuple
		try:
			bigRoot = previous_prime(ceil((largeSum/numAs)**(1/power)))

			if bigRoot == 2:
				bigRoot = 1

		except:
			bigRoot = 1

	else:
		upperLimit = ceil(largeSum**(1/power))
		bigRoot = floor((largeSum/numAs)**(1/power))

	# ---------------------------------------------------------------------
	# ---		Find roots for when numAs > 1							---
	# ---------------------------------------------------------------------

	retVal = []

	while bigRoot < upperLimit:

		# Calculate the larger part of the sum
		largeVal = bigRoot**power

		# Leftover smaller part of the sum
		diff = largeSum - largeVal

		if diff > 0:

			# if diff == 1, the rest MUST be [1, 1, 1, 1, ...]
			if multipleVals and diff == numAs - 1:
				appendVal = [1 for i in range(diff)]
				appendVal.append(bigRoot)
				retVal.append(appendVal)

			# Limit recursive calls to bare minimum
			elif (multipleVals and largeVal >= largeSum/numAs) or (not multipleVals and largeVal > largeSum/numAs):
				ans = recursiveReturnLists(diff, power, numAs - 1, primeCases, multipleVals)

				for littleRoots in ans:
					if multipleVals or (bigRoot not in littleRoots):
						littleRoots.append(bigRoot)
						retVal.append(littleRoots)

		if primeCases:
			bigRoot = next_prime(bigRoot)
			if bigRoot == 2:
				bigRoot = next_prime(bigRoot)
		else:
			bigRoot += 1

	return retVal

# =========================================================================
# Create list of relevant ais for the given parameters
# Returns list of length (numberOfAs)
# primeCases = True implies all Ais are prime
# gcd(denominator, ai) = 1 for all ais

def getListOfAs(numberOfAs, denominator, primeCases):

	if denominator == 1:
		raise Exception("Denominator can't be 1")

	# Inner function that checks if any a is relevant
	def check(a):
		if a == 1:
			return True

		if gcd(a,denominator) != 1:
			return False

		if primeCases:
			if is_prime(a) and a != 2:
				return True
			return False

		return True

	listOfAs = []
	a = 1

	while numberOfAs > 0:
		if check(a):
			listOfAs.append(a)
			numberOfAs -= 1

		a += 1

	return listOfAs

# =========================================================================
# printSummary = 0: Print everything
# printSummary = 1: Print everything w/o lists
# printSummary = 2: Print only header and footer
# printSummary = 3: Print only header and footer w/o lists
# printSummary = 4: Print only test cases
# printSummary = 5: Print nothing

# primeCases = True implies that ai is always prime
# primeCases = False implies that ai may be prime or composite

# retVal = 'gcdPhis' returns gcd(phi(weightedSums)) [default return value]
# retVal = 'gcdtots' returns gcd(Primes - 1)
# retVal = 'sums' returns list of sorted_tuples

# multipleVals = True implies that [a, a] is a testing case
# multipleVals = False implies that [a, a] cannot be a testing case

def returnGCD(n = 2, denominator = 2, printSummary = 0, numberOfAs = 16, primeCases = True, retVal = 'gcdPhis', multipleVals = False): #, logLimit = 63):

	# ---------------------------------------------------------------------

	# --- GENERATE DATA ---

	power = phi(denominator) * n

	# If denominator is so large that there are inadequate number of cases
	if numberOfAs < denominator + 2:
		numberOfAs = denominator + 2

	# ---------------------------------------------------------------------

	# --- PRINT HEADER ---

	if printSummary < 4:
		print('\n\n ------ HEADER ------ ')
		print(' n		--- ' + str(n))
		print(' Denominator	--- ' + str(denominator))
		print(' Power		--- ' + str(power))
		print(' ais are prime	--- ' + str(primeCases))
		print('\n ' + '-'*20)

	template = ' {0:12}	|  {1:16}  |   {2:30}'

	if printSummary in [0, 1, 4]:
		print('\n' + '-'*65)

		print(template.format('[ais]', 'phi(weightedSum)', 'sum(ai**n)/denominator'))

		print('-'*65)

	# ---------------------------------------------------------------------

	# get sized list of appropriate As, gcd(a,denominator) = 1, and whether or
	# not As are only prime

	listOfAs = getListOfAs(numberOfAs, denominator, primeCases)

	# ---------------------------------------------------------------------
	
	# given power = 3
	# listOfRaisedAs = {a1: a1**3,
	#					a2: a2**3,
	#					... }

	# Raise list of As for computational efficiency
	
	listOfRaisedAs = {each : each**power for each in listOfAs}

	# ---------------------------------------------------------------------

	# Uncomment if code is clogging
	# Not fully worked out yet, haven't needed it really

	# for each in listOfAs:
	# 	if  (p * power * (log(each,2).n())) > logLimit: # Log_2 of each prime**power
	# 		listOfAs.remove(each)

	# ---------------------------------------------------------------------

	c = Combinations(listOfAs,denominator)

	# casesDict = {	0: [3,5],
	#				1: [3,7],
	#				2: [3,11],
	#				... , }

	# Unwrap Combinations into casesDict

	casesDict = dict(enumerate(c))
	casesDict_len = len(casesDict)

	if multipleVals:
		for i in xsrange(len(listOfAs)):
			casesDict[casesDict_len + i] = [listOfAs[i], listOfAs[i]]

	# =====================================================================

	# valuesDict = {	0: weightedSum(casesDict[0]) = weightedSum([3,5]) = (3**power + 5**power)/denominator,
	#					1: weightedSum(casesDict[1]) = weightedSum([3,7]) = (3**power + 7**power)/denominator,
	#					2: weightedSum(casesDict[2]) = weightedSum([3,11]) = (3**power + 11**power)/denominator,
	#					... , }	

	# Inner function
	def weightedItems(ais):
		weightedSum = 0

		for ai in ais:
			weightedSum += listOfRaisedAs[ai]

		return weightedSum//denominator

	# =====================================================================

	valuesDict = {key: weightedItems(ais) for key, ais in casesDict.items()}

	# ---------------------------------------------------------------------

	# This has to be done because lists are unhashable types
	# {[a1, a2]: weightedSum(a1,a2), ... } cannot exist

	# sort valuesDict based on the weightedSum, not index
	# sorted_tuples = [(0, valuesDict[0]), (1, valuesDict[1]), (2, valuesDict[2]), ...]

	sorted_tuples = sorted(valuesDict.items(), key=operator.itemgetter(1))

	# ---------------------------------------------------------------------

	uniquePrimes = []
	phis = []

	for each in sorted_tuples:
		
		# primeData	= [list of prime factors, string factorization]
		#			= [[p1, p2, p3], 'weighted sum = (p1**2) x p2 x p3']

		primeData = pf(each[1],True)
		phiVal = phi(each[1])

		# find list of unique phi values
		if phiVal not in phis:
			phis.append(phiVal)

		# print output summary for each case
		if printSummary in [0, 1, 4]:

			print(template.format(str(casesDict[each[0]]), str(phiVal), primeData[1]))

		# list of unique prime factors of weighted sum
		for prime in primeData[0]:
			if prime not in uniquePrimes:
				uniquePrimes.append(prime)

	uniquePrimes.sort()
	phis.sort()

	# ---------------------------------------------------------------------

	# given uniquePrimes 	= [3, 5, 7, 13, ...]
	# totinetValues 		= [phi(3), phi(5), phi(7), phi(13), ...]
	#						= [3-1, 5-1, 7-1, 13-1, ...]
	#						= [2, 4, 6, 12, ...]

	totientValues = [each - 1 for each in uniquePrimes]

	gcdtots = gcd(totientValues)
	gcdPhis = gcd(phis)

	# ---------------------------------------------------------------------

	# --- PRINT FOOTER ---

	if printSummary in [0, 1, 4]:
		print('\n' + '-'*60)

	if printSummary < 4:
		print('\n\n ------ FOOTER ------ ')
		print(' n			---  ' + str(n))
		print(' Denominator		---  ' + str(denominator))
		print(' ais are prime		---  ' + str(primeCases))
		print(' No. of cases		---  ' + str(len(valuesDict)))

		if printSummary in [0, 2, 4]:
			print('\n List of As		---  ' + printList(listOfAs) + '\n')
			print(' Unique Primes		---  ' + printList(uniquePrimes) + '\n')
			print(' Primes - 1		---  ' + printList(totientValues) + '\n')
			print(' Unique Totients	---  ' + printList(phis) + '\n')

		print(' GCD(Primes - 1)	---  ' + str(gcdtots))
		print(' GCD(Totients)		---  ' + str(gcdPhis))
		print('-'*30 + '\n')

	# ---------------------------------------------------------------------
	#							 HYPOTHESIS SPACE
	# ---------------------------------------------------------------------

	# HYPOTHESIS 1 --- Adherance to prime %2*n = 1 depends on how divisible n is of 2

	# count = 0
	# for each in totientValues:
	# 	count += 1 if each%(2*n) == 0 else 0

	# print('  {0[0]}	---  {0[1]} : {0[2]}	---  {0[3]} %'.format(map(str,[	n,
	# 																		count,
	# 																		len(totientValues),
	# 																		(count/len(totientValues)*100).round()
	# 																	])))


	# HYPOTHESIS 2 --- see Notes


	# print('\n\n' + '-'*47 + '\n\n')

	# print(len([i for i in totientValues if i%(2*n) == 0]))
	# print(len(totientValues))

	# ratio = 0
	# largeTotientValues = totientValues[floor(ratio * len(totientValues)) : len(totientValues)]
	# gcdLarge = gcd(largeTotientValues)

	# print(' n ---  ' + str(n))
	# print(' Larger GCD(Primes - 1) ---  ' + str(gcdLarge))
	# print(' Hypothesis ---  ' + str(gcdLarge == 2*n))


	# ---------------------------------------------------------------------

	if retVal == 'gcdtots':
		return gcdtots

	if retVal == 'sums':
		return [each[1] for each in sorted_tuples]

	return gcdPhis

# =========================================================================

def printLists(n, primeVals = True, den = 2):

	# --- PRINT HEADER ---

	num = 12
	if n == 2:
		num = 40
	if n == 1:
		num = 120

	template = ' {0:' + str(num) + '}	|  {1:16}  |   {2:30}'

	header = template.format('[ais]', 'phi(weightedSum)', 'sum(ai**n)/denominator')

	print('\n' + '-'*len(header))
	print(header)
	print('-'*len(header))


	# --- GET WEIGHTED SUMS ---

	a = returnGCD(n, denominator = den, printSummary = 3, primeCases = primeVals, retVal = 'sums')

	a = removeDuplicates(a)

	for each in a:

		# --- GET LISTS FOR KNOWN WEIGHTED SUMS ---

		listVals = returnLists(den*each, phi(den)*n,numAs = den, primeCases = primeVals)

		if len(listVals) == 1:
			print(template.format(listVals[0], str(phi(each)), pf(each)))
		else:
			print(template.format(listVals, str(phi(each)), pf(each)))

	print('\n' + '-'*len(header) + '\n')

# =========================================================================
