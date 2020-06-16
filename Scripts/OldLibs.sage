
# --- FUNCTION SIGNATURES ---
#
# def length(denominator, i):
# def quotient(denominator, i, numerator):
# def inexplicableRatio():
# def evenLs(num, baseLimit):
# def oddLs(num, baseLimit):

# -- TO DO --
#
# def ratioPerNum
#	Even : odd = (2^k - 1) : 1
#

attach('Lib.sage')

# ==========================================================================
# WAY faster than the older method

length = lambda denominator, i: Mod(i, denominator).multiplicative_order()

# ==========================================================================
# returns length of repeating decimal expansion for 1/denominator in base i

def length2(denominator, i = 10):
	if gcd(denominator, i) != 1:
		raise AssertionError('GCD must be 1')

	if denominator == 1:
		raise AssertionError('Denominator can\'t be 1')

	retLength = 0
	remainder = 1

	# Exit control while loop
	while True:
		retLength += 1
		remainder = (remainder * i) % denominator

		# Exit condition
		if remainder == 1:
			break

	return retLength

# ==========================================================================

def quotient(denominator, i = 10, numerator = 1):

	gcd_val = gcd(denominator, numerator)
	denominator = denominator//gcd_val
	numerator = numerator//gcd_val

	remainder = numerator
	retVal = '0.'

	if i <= 36:

		#	switchDict = {	10: 'a',
		#					11: 'b',
		#					...
		#					35: 'z' }
		switchDict = {i - ord('a') + 10 : chr(i) for i in xsrange(ord('a'), ord('a') + 26)}

		# Exit control while loop
		while True:
			remainder = remainder * i
			append = floor(remainder/denominator)

			if append >= 10:
				retVal +=  switchDict[append]
			else:
				retVal += str(append)

			remainder = remainder % denominator

			# Exit condition
			if remainder == numerator:
				break
	else:

		# Exit control while loop
		while True:
			remainder = remainder * i
			retVal += str(floor(remainder/denominator)) + ' '
			remainder = remainder % denominator

			# Exit condition
			if remainder == numerator:
				break

	return retVal.strip()

# ==========================================================================

def inexplicableRatioS1():
	printerA = getPrinter('Temp9_1.txt')
	printerB = getPrinter('Temp10_1.txt')
	printerC = getPrinter('Temp11_1.txt')
	printerD = getPrinter('Temp12_1.txt')

	n1 = 9
	n2 = 10
	n3 = 11
	n4 = 12

	try:
		for i in xsrange(2, 3126):
			x1 = [0]*n1
			x2 = [0]*n2
			x3 = [0]*n3
			x4 = [0]*n4

			y = 0
			prime = 3
			count = 1

			while count <= 5000:
				if gcd(prime, i) == 1:
					
					lenVal = length(prime, i)

					x1[lenVal%n1] += 1
					x2[lenVal%n2] += 1
					x3[lenVal%n3] += 1
					x4[lenVal%n4] += 1

					count += 1

				prime = next_prime(prime)

			outputStr = str(i) + ' --- ' + ' : '.join(map(str, x1))
			outputStr1 = str(i) + ', ' + ', '.join(map(str, x1))
			outputStr2 = str(i) + ', ' + ', '.join(map(str, x2))
			outputStr3 = str(i) + ', ' + ', '.join(map(str, x3))
			outputStr4 = str(i) + ', ' + ', '.join(map(str, x4))

			print(outputStr)
			printerA.write(outputStr1 + '\n')
			printerB.write(outputStr2 + '\n')
			printerC.write(outputStr3 + '\n')
			printerD.write(outputStr4 + '\n')

	except KeyboardInterrupt:
		printerA.close()
		printerB.close()
		printerC.close()
		printerD.close()
	except:
		printerA.close()
		printerB.close()
		printerC.close()
		printerD.close()

	printerA.close()
	printerB.close()
	printerC.close()
	printerD.close()

# ==========================================================================

def inexplicableRatio(n = 2):

	printer = getPrinter('Temp.txt')

	try:
		for i in xsrange(2, 3000):
			x = [0]*n
			y = 0
			prime = 3
			count = 1

			while count <= 1000:
				if gcd(prime, i) == 1:
					
					lenVal = length(prime, i)%n
					x[lenVal] += 1

					count += 1

				prime = next_prime(prime)

			outputStr = str(i) + ' --- ' + ' : '.join(map(str, x))
			outputStr2 = str(i) + ', ' + ', '.join(map(str, x))

			print(outputStr)
			printer.write(outputStr2 + '\n')

	except KeyboardInterrupt:
		printer.close()
	except:
		printer.close()

	printer.close()

# ==========================================================================

def evenLs(num, baseLimit):
	even = 0

	for i in xsrange(2, baseLimit):
		if gcd(num, i) == 1:
			l = length(num, i)

			if l%2 == 0:
				even += 1

	return even

# ---------------------------------

def oddLs(num, baseLimit):
	odd = 0

	for i in xsrange(2, baseLimit):
		if gcd(num, i) == 1:
			l = length(num, i)

			if l%2 != 0:
				odd += 1

	return odd

# ==========================================================================
# length(num, i) divides reducedTotient(num) for all gcd(num, i) = 1

def reducedTotient(num):
	from sage.arith.functions import LCM_list

	return LCM_list([(each[0] - 1) * (each[0]**(each[1] - 1)) for each in factor(num)])

# ==========================================================================
# My definition of composite : (a^1)*(b^1) for two primes a and b (not including 2)

def isComposite(num):

	factorization = factor(num)

	if len(factorization) != 2:
		return False

	for each in factorization:
		if each[1] != 1:
			return False

		if each[0] == 2:
			return False

	return True

# ==========================================================================

# def ratioPerNum(numLimit, baseLimit):
# ratioPerBase
