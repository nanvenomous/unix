import numpy as np

# quicksort has the following orders
#	- O(nlog(n)) average case
#	- O(n^2) worst case
# this is in place sorting (no extra space needed)

def singleSort(x):
	i = 0
	swapIndex = 0
	lastElem = x[-1]
	while i < (len(x) - 1): # iterate to the 2nd to last elem
		curElem = x[i]
		if (curElem < lastElem):
			# swap elements
			x[swapIndex], x[i] = curElem, x[swapIndex]
			swapIndex += 1
		i += 1
	x[swapIndex], x[-1] = lastElem, x[swapIndex]
	# cases to address subproblems recursively
	if (swapIndex > 1):
		singleSort(x[:swapIndex - 1])
	lowestIndexToContinue = len(x) - 2
	if (swapIndex < lowestIndexToContinue):
		singleSort(x[swapIndex + 1:])

# this script will use quicksort to sort the following array
x = np.array([11, 16, 2, 8, 1, 9, 4, 7])

singleSort(x)

print(x)