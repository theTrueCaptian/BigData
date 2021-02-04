import re

@outputSchema('tokenize: bag{t:(token:chararray)}')
def tokenize(toTokenize):
	'''Tokenize with custom delimiters'''
	tokens = re.split('#|-|,|:| ',toTokenize)
	bag = []
	for token in tokens:
		bag.append(token)
	return bag

@outputSchema('word: chararray')
def groupByLowercase(word):
	''' return the lowercase '''
	return word.lower()

@outputSchema('word: int')
def isWordInSearchTerms(wordcountPair):
	word = wordcountPair
	searchTerm = ['hackathon', 'Java', 'Chicago', 'Dec']
	for i in range(len(searchTerm)):
		if word.lower() == searchTerm[i].lower():
			return i
	return -1

@outputSchema('word: chararray')
def groupByTerms(word):
	''' return the term otherwise return -1 '''
	searchTerm = ['hackathon', 'Java', 'Chicago', 'Dec']
	index = isWordInArray(word, searchTerm)
	if index != -1:
		return searchTerm[index]
	return -1

@outputSchema('wordcount: bag{t:( token:chararray, count:int)}')
def targetTerm(wordcount):
	'''Count target terms from wordcount'''
	counter = [('hackathon', 0), ('Java', 0), ('Chicago', 0), ('Dec', 0)]	
	searchTerm = ['hackathon', 'Java', 'Chicago', 'Dec']
	for (count, word) in wordcount:
		indexInTargetArr = isWordInArray(word, searchTerm)
		#If found, then add the counter
		if indexInTargetArr!=-1:
			counter[ indexInTargetArr] = (counter[ indexInTargetArr][0], counter[ indexInTargetArr][1] + count)
			
	return counter

	

def isWordInArray(word, arr):
	for i in range(len(arr)):
		if word.lower() == arr[i].lower():
			return i
	return -1

def test():
	print 'tokenize()'
	print tokenize('hackathons are awesome')
	print 'targetTerm()'
	print targetTerm([('hackathon', 3), ('Java', 4), ('Chicago', 5), ('Dec', 2), ('Maeda', 0), ('test', 1), ('yes', 0), ('Hackathon', 1)])

'''test()'''
