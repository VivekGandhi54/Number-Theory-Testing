# --- List of functions tested ---
#
#		def pf(num, primeList):
#		def is2n(num):
#		def divisibilityOf(a, b):
#		def log2(num):
#		def aMinusB(a, b):
#		def removeDuplicates(duplicateList):
#		def totientInverse(num):
#		def nthPhi(num):
#		def nPrimes(num):
#		def primesUnder(num):
#		def nthComposite(n):
#		def nComposites(n):
#		def compositesUnder(n):
#		def getPrinter(fileName):
#		def deleteDataFile(fileName):
#
# ==========================================================================

# Imports

attach('Lib.sage')

import os

# ==========================================================================

def LibTests():

	template = ' '*2 + '{0:25} --- {1:6}'

	print('-'*40)
	print('  TESTING Lib.sage')
	print('-'*40)

	print(template.format('is2n',				'passed' if test_is2n()				else 'failed'))
	print(template.format('pf',					'passed' if test_pf()				else 'failed'))
	print(template.format('divisibilityOf',		'passed' if test_divisibilityOf()	else 'failed'))
	print(template.format('log2',				'passed' if test_log2()				else 'failed'))
	print(template.format('aMinusB',			'passed' if test_aMinusB()			else 'failed'))
	print(template.format('removeDuplicates',	'passed' if test_removeDuplicates()	else 'failed'))
	print(template.format('totientInverse',		'passed' if test_totientInverse()	else 'failed'))
	print(template.format('nthPhi',				'passed' if test_nthPhi()			else 'failed'))
	print(template.format('nPrimes',			'passed' if test_nPrimes()			else 'failed'))
	print(template.format('primesUnder',		'passed' if test_primesUnder()		else 'failed'))
	print(template.format('nthComposite',		'passed' if test_nthComposite()		else 'failed'))
	print(template.format('nComposites',		'passed' if test_nComposites()		else 'failed'))
	print(template.format('compositesUnder',	'passed' if test_compositesUnder()	else 'failed'))
	print(template.format('getPrinter',			'passed' if test_getPrinter()		else 'failed'))
	print(template.format('getReader',			'passed' if test_getReader()		else 'failed'))
	print(template.format('deleteDataFile',		'passed' if test_deleteDataFile()	else 'failed'))

	print('-'*40)

# ==========================================================================

def assertTest(inputVal, output):
	return inputVal == output

# ==========================================================================

def test_is2n():

	testsPassed = True

	testsPassed = testsPassed and assertTest(is2n(1024), True)
	testsPassed = testsPassed and assertTest(is2n(2**14), True)
	testsPassed = testsPassed and assertTest(is2n(1), True)
	testsPassed = testsPassed and assertTest(is2n(2048), True)
	testsPassed = testsPassed and assertTest(is2n(1000), False)

	return testsPassed

# --------------------------------------------------------------------------

def test_pf():

	testsPassed = True

	testsPassed = testsPassed and assertTest(pf(1, True),[[1], '1 = 1'])
	testsPassed = testsPassed and assertTest(pf(127, True),[[127], '127 = 127'])
	testsPassed = testsPassed and assertTest(pf(1024),'1024 = (2**10)')
	testsPassed = testsPassed and assertTest(pf(1024, False),'1024 = (2**10)')
	testsPassed = testsPassed and assertTest(pf(1024, True),[[2],'1024 = (2**10)'])

	return testsPassed

# --------------------------------------------------------------------------

def test_divisibilityOf():

	testsPassed = True

	testsPassed = testsPassed and assertTest(divisibilityOf(1024, 2), 10)
	testsPassed = testsPassed and assertTest(divisibilityOf(1023, 2), 0)
	testsPassed = testsPassed and assertTest(divisibilityOf(1000, 5), 3)
	testsPassed = testsPassed and assertTest(divisibilityOf(104, 104), 1)
	testsPassed = testsPassed and assertTest(divisibilityOf(12, 13), 0)

	return testsPassed

# --------------------------------------------------------------------------

def test_log2():

	testsPassed = True

	testsPassed = testsPassed and assertTest(log2(1024), 10)
	testsPassed = testsPassed and assertTest(log2(2), 1)
	testsPassed = testsPassed and assertTest(log2(1), 0)

	try:
		assertTest(log2(1023), 2)
		testsPassed = False
	except:
		testsPassed = testsPassed and True

	try:
		assertTest(log2(20),4)
		testsPassed = False
	except:
		testsPassed = testsPassed and True

	return testsPassed

# --------------------------------------------------------------------------

def test_aMinusB():

	testsPassed = True

	testsPassed = testsPassed and assertTest(aMinusB([1, 2, 3, 4, 5], [1, 3, 5]), [2, 4])
	testsPassed = testsPassed and assertTest(aMinusB([2, 4, 6, 8, 10], [4, 8, 12]), [2, 6, 10])
	testsPassed = testsPassed and assertTest(aMinusB(['a', 'b', 'c', 'd', 'e'], ['a', 'c', 'e']), ['b', 'd'])
	testsPassed = testsPassed and assertTest(aMinusB(['a', 'b', 'c', 'd', 'e'], ['c', 'd', 'e', 'f']), ['a', 'b'])
	testsPassed = testsPassed and assertTest(aMinusB(['a', 'b', 'c', 'd', 'e'], ['a', 'a', 'a']), ['b', 'c', 'd', 'e'])

	return testsPassed

# --------------------------------------------------------------------------

def test_removeDuplicates():

	testsPassed = True

	testsPassed = testsPassed and assertTest(removeDuplicates([1, 1, 2, 3, 5]), [1, 2, 3, 5])
	testsPassed = testsPassed and assertTest(removeDuplicates(['a', 'b', 'c']), ['a', 'b', 'c'])
	testsPassed = testsPassed and assertTest(removeDuplicates(['a', 'b', 'c', 'c']), ['a', 'b', 'c'])
	testsPassed = testsPassed and assertTest(removeDuplicates([[1, 2], [2, 4], [3, 6], [3, 6]]),[[1, 2], [2, 4], [3, 6]])
	testsPassed = testsPassed and assertTest(removeDuplicates([['a', 'a'], ['a', 'a']]),[['a', 'a']])

	return testsPassed

# --------------------------------------------------------------------------

def test_totientInverse():

	testsPassed = True

	testsPassed = testsPassed and assertTest(totientInverse(100), [101, 125, 202, 250])
	testsPassed = testsPassed and assertTest(totientInverse(48), [65, 104, 105, 112, 130, 140, 144, 156, 168, 180, 210])
	testsPassed = testsPassed and assertTest(totientInverse(1), [2])
	testsPassed = testsPassed and assertTest(totientInverse(2), [3, 4, 6])
	testsPassed = testsPassed and assertTest(totientInverse(11), [])

	return testsPassed

# --------------------------------------------------------------------------

def test_nthPhi():

	testsPassed = True

	testsPassed = testsPassed and assertTest(nthPhi(20), [8, 1])
	testsPassed = testsPassed and assertTest(nthPhi(49), [4, 3])
	testsPassed = testsPassed and assertTest(nthPhi(1024), [1024, 0])
	testsPassed = testsPassed and assertTest(nthPhi(1025), [128, 3])
	testsPassed = testsPassed and assertTest(nthPhi(1000), [64, 3])

	return testsPassed

# --------------------------------------------------------------------------

def test_nPrimes():

	testsPassed = True

	testsPassed = testsPassed and assertTest(nPrimes(0), [])
	testsPassed = testsPassed and assertTest(nPrimes(1), [3])
	testsPassed = testsPassed and assertTest(nPrimes(4), [3, 5, 7, 11])
	testsPassed = testsPassed and assertTest(nPrimes(8), [3, 5, 7, 11, 13, 17, 19, 23])
	testsPassed = testsPassed and assertTest(len(nPrimes(4000)), 4000)

	return testsPassed

# --------------------------------------------------------------------------

def test_primesUnder():

	testsPassed = True

	testsPassed = testsPassed and assertTest(primesUnder(3), [3])
	testsPassed = testsPassed and assertTest(primesUnder(2), [])
	testsPassed = testsPassed and assertTest(primesUnder(10), [3, 5, 7])
	testsPassed = testsPassed and assertTest(primesUnder(11), [3, 5, 7, 11])
	testsPassed = testsPassed and assertTest(primesUnder(14), [3, 5, 7, 11, 13])

	return testsPassed

# --------------------------------------------------------------------------

def test_nthComposite():

	testsPassed = True

	testsPassed = testsPassed and assertTest(nthComposite(2), 6)
	testsPassed = testsPassed and assertTest(nthComposite(1), 4)
	testsPassed = testsPassed and assertTest(nthComposite(10), 18)
	testsPassed = testsPassed and assertTest(nthComposite(11), 20)
	testsPassed = testsPassed and assertTest(nthComposite(15), 25)

	return testsPassed

# --------------------------------------------------------------------------

def test_nComposites():

	testsPassed = True

	testsPassed = testsPassed and assertTest(nComposites(1), [4])
	testsPassed = testsPassed and assertTest(nComposites(10), [4, 6, 8, 9, 10, 12, 14, 15, 16, 18])
	testsPassed = testsPassed and assertTest(nComposites(7), [4, 6, 8, 9, 10, 12, 14])
	testsPassed = testsPassed and assertTest(nComposites(8), [4, 6, 8, 9, 10, 12, 14, 15])
	testsPassed = testsPassed and assertTest(len(nComposites(160)), 160)

	return testsPassed

# --------------------------------------------------------------------------

def test_compositesUnder():

	testsPassed = True

	testsPassed = testsPassed and assertTest(compositesUnder(4), [4])
	testsPassed = testsPassed and assertTest(compositesUnder(3), [])
	testsPassed = testsPassed and assertTest(compositesUnder(11), [4, 6, 8, 9, 10])
	testsPassed = testsPassed and assertTest(compositesUnder(15), [4, 6, 8, 9, 10, 12, 14, 15])
	testsPassed = testsPassed and assertTest(compositesUnder(20), [4, 6, 8, 9, 10, 12, 14, 15, 16, 18, 20])

	return testsPassed

# --------------------------------------------------------------------------

def test_getPrinter():

	printer = getPrinter('test_file.txt')
	printer.write('Random data	---\n')
	printer.write('Random data2	---\n')
	printer.close()

	outputPath = os.getcwd().replace('Scripts', 'OutputData')
	outputFiles = os.listdir(outputPath)

	if 'test_file.txt' not in outputFiles:
		return False

	return True

# --------------------------------------------------------------------------

def test_getReader():

	testsPassed = True

	reader = getReader('test_file.txt')
	testsPassed = testsPassed and assertTest(reader.read(), 'Random data	---\nRandom data2	---\n')

	reader = getReader('test_file.txt')
	lines = reader.readlines()
	testsPassed = testsPassed and assertTest(lines[0], 'Random data	---\n')
	testsPassed = testsPassed and assertTest(lines[1], 'Random data2	---\n')

	return testsPassed

# --------------------------------------------------------------------------

def test_deleteDataFile():

	deleteDataFile('test_file.txt')

	outputPath = os.getcwd().replace('Scripts', 'OutputData/')
	outputFiles = os.listdir(outputPath)

	if 'test_file.txt' in outputFiles:
		return False

	return True

# ==========================================================================

LibTests()
