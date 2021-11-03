####################################################################################################
# Function-script for recoding and summary variable creation for Need for Cognition                #                                                                  #
# Kristoffer Klevjer - github.com/klvr - klevjer(a)gmail.com                                       #
####################################################################################################

# Short-version (18 item) Need for Cognition -------------------------------------------------------
# Input: Column of responses (x)
# Arguments: Reversed items (revi; sequence of; defaults to items 3,4,5,7,8,9,12,16 & 17)
# Output: Summary score NfC
# Use: df[,x] <- recodeNFC(x = df[,c(x1:x18], revi = c(3,4,5,7,8,9,12,16,17)
recodeNFC <- function(x, revi = c(3,4,5,7,8,9,12,16,17)) {
 for (i in 1:ncol(x)) {
   x[,i] <- as.character(x[,i])
   x[,i] <- toupper(x[,i])
 }
  x <- x
  x <- replace(x, x=="EXTREMELY UNCHARACTERISTIC OF ME", 1)
  x <- replace(x, x=="SOMEWHAT UNCHARACTERISTIC OF ME", 2)
  x <- replace(x, x=="UNCERTAIN", 3)
  x <- replace(x, x=="SOMEWHAT CHARACTERISTIC OF ME", 4)
  x <- replace(x, x=="EXTREMELY CHARACTERISTIC OF ME", 5)
  x <- sapply(x, as.numeric)
  for (i in revi) {
   x[,i] <- (6 - x[,i])
  }
  x <- x
  x <- rowSums(x)
}