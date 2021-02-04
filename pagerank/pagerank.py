
input = [
	('A', ['C', 'F'], 0.166667),
	('B', ['D', 'E', 'F'], 0.166667),
	('C', ['A', 'B'], 0.166667),
	('D', ['A', 'B', 'C','E', 'F'], 0.166667),
	('E', ['F'], 0.166667),
	('F', ['B', 'C'], 0.166667) 
]

output = []

for node in input:	#e.g. node = (A, [C,F], 0.167)
	node_pagerank = 0
	outlinks = node[1] 	#[C, F]

	#Calculate A's pagerank
	for link in outlinks:	#e.g. iterate over [C,F]
		
		#info about C e.g. (C, [A, B], 0.166667)
		#link_info = find(lambda x: x[0] == link, input)	
		# alternative using filter:
		link_info = filter(lambda x: x[0] == link, input)[0]

		#then num_outlinks = 2
		num_outlinks = len(link_info[1])  

		#the link's pagerank e.g. 0.166667
		link_pagerank = link_info[2]

		#print '\t'+str(link)+', '+str(link_info)+', '+str(num_outlinks)

		node_pagerank = node_pagerank + (link_pagerank/num_outlinks)

	print str(node) + '-> Page rank = ' + str(node_pagerank)



