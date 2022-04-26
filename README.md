# Kmer counting

## Task 1: Implement countKmers function

Implement the `countKmers` function in [countKmers.R](src/countKmers.R). This function takes two arguments: 1) a character vector, and 2) a number, k. You should write a function that, for the given k, counts all the k-mers in the given string, and returns a table. The table you return should be able to retrieve the count of a k-mer using single-bracket item access notation: for example, if you counted all 5-mers, your result should provide the count of the `ATGCC` 5-mer like this: `result["ATGCC"]`. (30 pts)

### Note about package dependencies

You should implement this function using only base R or tidyverse packages. In particular, you may not use the Biostrings package, which contains a similar implementation.

## Task 2: Use PCA to explore relationships among sequences

For the second task, use your `countKmers` function to count all 4-mers for each of the sequences found in the [fasta](/fasta) folder. Build a matrix of 4-mer counts, with 1 row for each sequence and 1 column per 4-mer. Next, use PCA to reduce the dimensionality of the 4-mer matrix, and plot the first two principle components in a scatterplot using ggplot2.  (20 pts)

## Task 3: Construct a Bloom Filter to test for k-mer presence

Bloom filters are membership testers that can be used to test whether a given k-mer is present in a large dataset. They are efficient in both memory and speed. For this task, you will implement a Bloom Filter for k-mers. You should be able to insert k-mers into the Bloom Filter as short strings, and then test the filter for presence. 

Use the skeleton R class provided in [bloomFilter.R](src/bloomFilter.R). The outline has been provided for you; you will need to implement 4 methods on this class: `addElement` (15 pts), `testElement` (15 pts), `hashElement` (15 pts), and `resetFilter` (5 pts).

To test your work and see examples of how to use the class, consult [tests/testDriverBloom.R](tests/testDriverBloom.R). To pass the tests, your Bloom Filter must score 100% accuracy on true positives (all inserted elements should return TRUE when tested for membership), and must achieve lower than 10% false positive accuracy when a non-inserted element is tested for presence under the test conditions. If your hash functions are done well, theoretically, your bloom filter should be able to achieve 2% false positive rates under the conditions of the tests.

## Testing

You can test your work by running:

```
Rscript tests/testDriver.R
```

To test only the k-mer counting task:

```
Rscript tests/testDriverKmer.R
```

To test only the Bloom Filter task:

```
Rscript tests/testDriverBloom.R
```

