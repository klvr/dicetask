####################################################################################################
# Function-script for recoding and summary variable creation for RQ-items                          #
# Kristoffer Klevjer - github.com/klvr - klevjer(a)gmail.com                                       #
####################################################################################################

# Single items -------------------------------------------------------------------------------------

# Single item recoding
# Input: Column of responses (x)
# Arguments: Correct response (c; not case sensitive), heuristic response (h; if applicable)
# Output: 1: Correct, 0: Incorrect, -1: Heuristic (if applicable), NA: No response
# Use: df[,x] <- recodeSingle(x = df[,x], c = "correct response", h = "heuristic response") 
recodeSingle <- function(x, c, h = "heuristic") {
  x <- as.character(x)
  x <- toupper(x)
  c <- toupper(c)
  h <- toupper(h)
  for (i in 1:length(x)) {
    if (x[i] == c) {
      x[i] <- 1
    } else if (x[i] == h) {
      x[i] <- -1
    } else if (x[i] == "") {
      x[i] <- ""
    } else {
      x[i] <- 0
    }
  }
  x <- as.numeric(x)
}

# Specific multi-response items --------------------------------------------------------------------

# Cups and die item - Probability matching
# Input: 10 columns of responses (Blue cup, Yellow cup)
# Arguments: Heuristic coding on/off (hc), majority colour (maj; not case sensitive)
# Output: 1: Correct, 0: Incorrect, -1: Probability matching (if TRUE), NA: No response
# Use: df[,pm1] <- recodeProbabilityMatching(pm = df[,c(pm1:pm10)], maj = "Blue cup", hc = "FALSE")
recodeProbabilityMatching <- function(pm, maj = "Blue cup", hc = "FALSE") {
  maj <- toupper(maj)
  for (i in 1:ncol(pm)) {
    pm[,i] <- as.character(pm[,i])
    pm[,i] <- toupper(pm[,i])
  }
  pm <- pm
  pm <- replace(pm, pm==maj, 1)
  pm <- replace(pm, pm=="", NA)
  pm <- replace(pm, pm>1, 0)
  pm <- sapply(pm, as.numeric)
  pm <- rowSums(pm)
  if (hc == TRUE) {pm <- replace(pm, pm==7, -1)}
  pm <- replace(pm, pm==10, 1)
  pm <- replace(pm, pm>2, 0)
}