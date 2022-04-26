library("testit")
check =  "\U2713"

message("Testing Bloom Filter task")
source("src/bloomFilter.R")

message(check, " Found bloom filter code")

bf = BloomFilter$new(size=5000*8)
# bf$resetFilter()
bf$addElement("ACTGT")
bf$hashElement("ACTGT")

assert("Basic insertion", {
	(bf$testElement("ACTGT") == TRUE)
	(bf$testElement("TCGAT") == FALSE)
})

message(check, " Passed basic bloom filter tests")

message("  Advanced tests...")

# Generate random Kmers
nucleotides = c("A", "T", "G", "C")
randomKmers = replicate(5000, {
	paste0(nucleotides[sample(4, 12, replace=TRUE)], collapse="")
})

randomKmers2 = replicate(5000, {
	paste0(nucleotides[sample(4, 12, replace=TRUE)], collapse="")
})

for (kmer in randomKmers) {
	bf$addElement(kmer)
}

# True positive
truePos = sum(sapply(randomKmers, bf$testElement)) / length(randomKmers)

# False positive
falsePos = sum(sapply(randomKmers2, bf$testElement)) / length(randomKmers2)

# Full rate
fullRate = sum(bf$bfilt)/length(bf$bfilt)

message("  Your true positive rate is: ", truePos)
message("  Your false positive rate is: ", falsePos)
message("  Your full rate is: ", fullRate)

assert("True positive rate must be 100%", {
	(truePos == 1)
})

assert("False positive rate must be less than 10%", {
	(falsePos < 0.1)
})

message(check, " Passed advanced true/false positive tests")

if (falsePos < 0.05) {
	message(check, " BONUS! You achieved under 5% false positive rate")
}
