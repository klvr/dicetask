####################################################################################################
# Function-script for recoding gender                                                              #
# Kristoffer Klevjer - github.com/klvr - klevjer(a)gmail.com                                       #
####################################################################################################

# Gender -------------------------------------------------------------------------------------------
# Input: Column with gender
# Output: 1: Female, 0: Male, -1: Other/non-binary, NA: Missing
# Use: df[,x] <- recodeGender(x = df[,x])
recodeGender <- function(x) {
  x <- sapply(x, as.character)
  x <- sapply(x, toupper)
  x <- replace(x, x=="FEMALE", 1)
  x <- replace(x, x=="MALE", 0)
  x <- replace(x, x=="", NA)
  x <- replace(x, x>3, -1)
  x <- x
}