library(dplyr)
library(ggplot2)

# This function will convert a new.env()
# hash table to a vanilla R table
#
# all that is required is you pass in a
# native R hash table ( new.env(hash=TRUE) )
.hashTableToTable = function(htab) {
  vtab <- c()
  for( v in ls(htab) ) {
    vtab[v] <- htab[[v]]
  }
  return (vtab)
}

# This function counts Kmers in a given string
#
# @param str A character vector
# @param k The k, or length of the kmer, you wish to count
# @returns This function should return a table of kmer counts,
# 		   indexed by kmer name
countKmers = function(str, k) {
  # init hash table
  htab <- new.env(hash=TRUE)
  
  # iterate through all possible k-mers
  # and map to hash table
  for (i in seq(nchar(str) - k+1)) {
    kmer <- substr(str, i, i+k-1)
    if(exists(kmer, htab)) {
      htab[[kmer]] = htab[[kmer]] + 1
    } else {
      htab[[kmer]] = 1
    }
  }
  
  vtab <- .hashTableToTable(htab)
  return (vtab)
}

# This function is a small wrapper to
# read in a fasta file into one long string
#
# pass the path to the file in and it will
# strip the meta data and return the fasta
# sequence
.readFasta <- function(filepath) {
  rawLines <- readLines(filepath)
  str <- do.call(paste0, as.list(rawLines[2:length(rawLines)]))
  return (str)
}

# read in files
files <- list.files(
  path="fasta", 
  pattern="*.fa", 
  full.names=TRUE,
  recursive=FALSE
)

# construct matrix and replace all NA
# with 0's
counts.frame = data.frame()
for (file in files) {
  # skip all.fa
  if(grepl( "all.fa", file, fixed = TRUE)) {
    next
  }
  counts.frame <- bind_rows(counts.frame, countKmers(.readFasta(file), 4))
}
counts.frame[is.na(counts.frame)] <- 0

# run PCA
pc <- prcomp(
  counts.frame,
  center=TRUE,
  scale=TRUE
)

ggplot(as.data.frame(pc$x), aes(x=PC1, y=PC2)) + geom_point()



