####################################################################################################
# Function-script for recoding and summary variable creation for Intolerance of Uncertainty        #
# Kristoffer Klevjer - github.com/klvr - klevjer(a)gmail.com                                       #
####################################################################################################

# Short-version (12 item) Intolerance of Uncertainty -----------------------------------------------
# Input: Columns of responses (x)
# Arguments: Prospective items (prosp; sequence of; defaults to items 1, 2, 3, 4, 5, 6 & 7)
#            Inhibatory items (inhib; sequence of; defaults to items 8, 9, 10, 11, 12)
# Output: Summary score for intolerance of uncertainty, and each sub-scale 
#         (prospective and inhibatory) in that order.
# Use: df[,x1:x3] <- recodeIUS(x = df[,x1:x12], args)

recodeIUS <- function(x, prosp = c(1,2,3,4,5,6,7),
                       inhib = c(8,9,10,11,12)) {
  for (i in 1:ncol(x)) {
    x[,i] <- as.character(x[,i])
    x[,i] <- toupper(x[,i])
  }
  x <- x
  x <- replace(x, x=="NOT AT ALL CHARACTERISTIC OF ME", 1)
  x <- replace(x, x=="MOSTLY NOT CHARACTERISTIC OF ME", 2)
  x <- replace(x, x=="NEITHER OR", 3)
  x <- replace(x, x=="MOSTLY CHARACTERISTIC OF ME", 4)
  x <- replace(x, x=="ENTIRELY CHARACTERISTIC OF ME", 5)
  x <- sapply(x, as.numeric)
  xTotal <- rowSums(x)
  xProsp <- rowSums(x[,prosp])
  xInhib <- rowSums(x[,inhib])
  x <- cbind(xTotal, xProsp, xInhib)
}