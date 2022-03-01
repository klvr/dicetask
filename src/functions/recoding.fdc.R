####################################################################################################
# Function-script for recoding and summary variable creation for Five Dimensions of Curiosity      #
# Kristoffer Klevjer - github.com/klvr - klevjer(a)gmail.com                                       #
####################################################################################################

# 25-item version of the Five Dimensions of Curiosity ----------------------------------------------
# Input: Columns of responses (x)
# Arguments: Joyous exploration items      (joyexp; sequence of; defaults to items 1-5)
#            Deprivation sensitivity items (depsen; sequence of; defaults to items 6-10)
#            Stress tolerance items        (stress; sequence of; defaults to items 11-15)
#            # Stress tolerance subscale is reverse-scored
#            Social Curiosity items        (social; sequence of; defaults to items 16-20)
#            Thrill seeking items          (thrill; sequence of: defaults to items 21-25)
# Output: Summary score for each sub-scale, joyexp, depsen, stress, social, thrill in that order
# Use: df[,x1:x5] <- recodeFDC(x = df[,x1:x25], args)
recodeFDC <- function(x, joyexp = c(1,2,3,4,5),
                         depsen = c(6,7,8,9,10),
                         stress = c(11,12,13,14,15),
                         social = c(16,17,18,19,20),
                         thrill = c(21,22,23,24,25)) {
  for (i in 1:ncol(x)) {
    x[,i] <- as.character(x[,i])
    x[,i] <- toupper(x[,i])
  }
  x <- x
  x <- replace(x, x=="DOES NOT DESCRIBE ME AT ALL (1)", 1)
  x <- replace(x, x=="(2)", 2)
  x <- replace(x, x=="(3)", 3)
  x <- replace(x, x=="(4)", 4)
  x <- replace(x, x=="(5)", 5)
  x <- replace(x, x=="(6)", 6)
  x <- replace(x, x=="COMPLETELY DESCRIBES ME (7)", 7)
  x <- sapply(x, as.numeric)
  xJoyexp <- rowSums(x[,joyexp])
  xDepsen <- rowSums(x[,depsen])
  xStress <- rowSums(8-x[,stress])
  xSocial <- rowSums(x[,social])
  xThrill <- rowSums(x[,thrill])
  x <- cbind(xJoyexp, xDepsen, xStress, xSocial, xThrill)
}