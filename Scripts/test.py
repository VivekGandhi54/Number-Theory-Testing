import sympy as sp

prime, product = 3, 1

for i in range(100000000):
	product *= (prime - 1)/prime
	prime = sp.nextprime(prime)

	if i%1000000 == 0:
		print(product)

print(prime)
print(product)