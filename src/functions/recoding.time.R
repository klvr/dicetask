####################################################################################################
# Function-script for recoding of time spent                                                       #
# Kristoffer Klevjer - github.com/klvr - klevjer(a)gmail.com                                       #
####################################################################################################

# Time spent per page ------------------------------------------------------------------------------
# Input: Columns of first click, last click, page submit and click-count
# Output: Overall time on page, time from first action to submit, time from last action to submit,
#         Number of clicks above minimum (e.g., 15items, 17 clicks = 2 clicks above minimum)
# Use: df[,c(x1:x4)] <- recodeTime(x = df[,c(x1:x4])
recodeTime <- function(x) {
  for (i in 1:ncol(x)) {
    x[,i] <- as.character(x[,i])
    x[,i] <- as.numeric(x[,i])
  }
  x <- x
  xOT <- (x[,3])
  xFS <- (x[,3] - x[,1])
  xLS <- (x[,3] - x[,2])
  xCM <- (x[,4] - min(x[,4], na.rm = TRUE))
  x <- cbind(xOT, xFS, xLS, xCM)
}