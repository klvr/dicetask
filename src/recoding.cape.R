####################################################################################################
# Function-script for recoding and summary variable creation for CAPE                              #
# Kristoffer Klevjer - github.com/klvr - klevjer(a)gmail.com                                       #
####################################################################################################

# Full version (42 item) Community Assessment of Psychic Experiences -------------------------------
# Input: Columns of responses (x)
# Arguments: Positive items   (pos; sequence of; defaults to items 2, 5, 6, 7, 10, 11, 13, 15, 17,
#                              20, 23, 25, 27, 29, 31, 33, 35, 36, 44 & 45)
#            Negative items   (neg; sequence of; defaults to items 3, 4, 8, 16, 18, 22, 24, 26, 28,
#                              30, 34, 37, 38 & 39)
#            Depressive items (dep; sequence of; defaults to items 1, 9, 12, 14, 19, 40, 41 & 42)
#            Control items    (con; sequence of; defaults to items 21, 32 & 43)
# Output: Summary score for each sub-scale (pos, neg, dep), and control items, in that order
# Use: df[,x1:x4] <- recodeCAPE(x = df[,x1:x45], args)
# If no control items, adjust accordingly, df[,x1:x3] (one less) <- recodeCAPE(df[,x1:x42]) (3 less)
recodeCAPE <- function(x, pos = c(2,5,6,7,10,11,13,15,17,20,23,25,27,29,31,33,35,36,44,45),
                          neg = c(3,4,8,16,18,22,24,26,28,30,34,37,38,39),
                          dep = c(1,9,12,14,19,40,41,42),
                          con = c(21,32,43)) {
  for (i in 1:ncol(x)) {
    x[,i] <- as.character(x[,i])
    x[,i] <- toupper(x[,i])
  }
  x <- x
  x <- replace(x, x=="NEVER", 1)
  x <- replace(x, x=="SOMETIMES", 2)
  x <- replace(x, x=="OFTEN", 3)
  x <- replace(x, x=="NEARLY ALWAYS", 4)
  x <- sapply(x, as.numeric)
  xPos <- rowSums(x[,pos])
  xNeg <- rowSums(x[,neg])
  xDep <- rowSums(x[,dep])
  xCon <- rowSums(x[,con])
  x <- cbind(xPos, xNeg, xDep, xCon)
}