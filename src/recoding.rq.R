####################################################################################################
# Function-script for recoding and summary variable creation for RQ-items                          #                                                                  #
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

# Spesific multi-response items --------------------------------------------------------------------

# Cups and die item - Probability matching
# Input: 10 columns of responses (Blue cup, Yellow cup)
# Arguments: With or without heuristic response conding (i.e., probability matching)
# Use: df[,pm1] <- recodeProbabilityMatching(df[,c(pm1:pm10)]
recodeProbabilityMatching <- function(pm, hc = "FALSE") {
  convert <- function(a) {
    if (a == "Blue cup") {a <- 1} else {a <- 0}
    }
  if (hc) {
  } else {
    for (i in pm) {
      lapply(pm[,i], convert)
    }
  }
  print(pm)
}