library("testit")
icon = list(
	success = "\U2713",
	fail = "\U2717"
)

message("Testing K-mer counting task")
source("src/countKmers.R")

testString1 = "ACTGTCAACTGTCAACTGTCAACTGTCAACTGTCAACTGTCA"
countTable1 = countKmers(testString1, 4)

message("  Testing countKmers function with basic tests...")

assert("Basic counts", {
	(countTable1["TCAA"] == 5)
	(countTable1["TGTC"] == 6)
	(is.na(countTable1["AAAA"]))
})

message(icon$success, " Passed basic countKmers tests!")
message("  Testing countKmers function with advanced tests...")
rawLines = readLines("fasta/jun.fa")
testString2 = do.call(paste0, as.list(rawLines[2:length(rawLines)]))
countTable2 = countKmers(testString2, 5)
countTable2_3 = countKmers(testString2, 3)

ans = read.table("tests/jun_3mers.tsv")

for (i in seq_len(nrow(ans))) {
	assert(paste0("Counts correct for k-mer ", ans[i,"r"]), {
		(countTable2_3[ans[i,"r"]] == ans[i,"Freq"])
	})
}
assert("Larger counts", {
	(countTable2["CTAGC"] == 3)
	(countTable2["TTTGT"] == 7)
	(is.na(countTable1["AAAA"]))
})
message(icon$success, " Passed advanced countKmers tests!")

message(icon$success, " All countKmers tests passed!")
