library("digest")

# Reference class for a Bloom Filter object.
# For more information on R reference classes, see:
# http://adv-r.had.co.nz/R5.html
BloomFilter = setRefClass("BloomFilter", 
				fields=list(size="numeric", bfilt="logical"))

BloomFilter$methods(
	# Constructor for creating a new BloomFilter object
	initialize = function(size) {
		# You shouldn't need to modify this function
		size <<- size
		bfilt <<- rep(FALSE, size)
	},
	# This function should add an element to your bloom filter
	#
	# @param element 	Element you want to add
	addElement = function(element) {
		# Hint: This function should call hashElement()
	  .self$bfilt[.self$hashElement(element)] <- TRUE
	},
	# Tests a filter to see if it contains an element
	#
	# @param element 	Element you want to test
	# @return bool		TRUE/FALSE indicating element exists
	testElement = function(element) {
	 return(
	   all(.self$bfilt[.self$hashElement(element)])
	 )
	},

	# Removes all elements from filter
	resetFilter = function() {
	  bfilt <<- rep(FALSE, .self$size)
	},
	# Compute hash values for a given element
	#
	# This is the workhorse of the Bloom Filter. Your hashElement
	# function should be able to return a user-specified number of hash
	# values. 
	#
	# @param element	Element to hash
	# @param size		Length of vector of the filter
	# @param hashes		Number of hash values to return
	# @return vector[numeric]	A vector of length `hashes` that
	# 	with each value less than `size`.
	hashElement = function(element, hashes=3) {
	  # wrapper to compute an index
	  # to flip given a seed
	  .computeIndex = function(i) {
	    return (
	      as.numeric(
	        paste0("0x", digest(element, algo="murmur32", seed=i))
	        ) %% .self$size
	     )
	  }
	  return (
	    unlist(lapply(seq(hashes), .computeIndex))
	 )
	},
	# This function is used to print the object to screen
	# when a user inspects the object
	show = function() {
		# You shouldn't need to modify this function
		message("BloomFilter object of size ", .self$size)
		sumBFilt = sum(bfilt)
		message("Filled bits: ", sumBFilt, " (", 100*sumBFilt/length(bfilt), "%)")
	}
)