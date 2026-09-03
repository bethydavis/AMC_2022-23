testobs <- c(1,2,3,4)

# Test for how to variable-ize an RDS save
path1 <- "test/for/RDS"
dir.create(path1, showWarnings = FALSE, recursive = TRUE)

name <- "test.RDS"
out <- paste(path1, name, sep = "/")

saveRDS(testobs, out)

# Worked!

out2 <- paste(path1, "name2.RDS", sep = "/")
saveRDS(testobs, out2)

# Also worked