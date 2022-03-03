####################################################################################################
# Function-script for recoding and setting ambiguity threshold in the Dynamic Ellsberg task        #
# Kristoffer Klevjer - github.com/klvr - klevjer(a)gmail.com                                       #
####################################################################################################

# 17-item Dynamic / titration variant of Ellsberg paradow ------------------------------------------
# Input: Columns of responses (x)
# Arguments: Output in percentage (perc) or bipolar scale (bipolar; default)
# Output: Ambiguity thresolds
#         Percentage:    At what percentage the ambiguity (objectivly .50) is valued. Higher number
#                        (above 0.50) is ambiguity seeking, lower number (below 0.50) is avoidant.
#         Bipolar scale: Scale from -1: Highly ambiguity avoidant, 0: Indifferent, to 1: Ambiguity
#                        seeking.
# Use: df[,x1] <- recodeEllsDyn(x = df[,x1:x17], args)
recodeEllsDyn <- function(x, output = "bipolar") {
ambig <- x
ambig <- ambig[,-c(1:7)]
ambig[,9] <- replace(ambig[,9], ambig[,9] == "Urn A", 0.95)
ambig[,9] <- replace(ambig[,9], ambig[,9] == "Urn B", 0.90)
ambig[,1] <- replace(ambig[,1], ambig[,1] == "Urn B", 0.80)
ambig[,1] <- replace(ambig[,1], ambig[,1] == "Urn A", 0) # These make choices in ambig[,9]
ambig[,2] <- replace(ambig[,2], ambig[,2] == "Urn A", 0.75)
ambig[,2] <- replace(ambig[,2], ambig[,2] == "Urn B", 0.70)
ambig[,3] <- replace(ambig[,3], ambig[,3] == "Urn A", 0.65)
ambig[,3] <- replace(ambig[,3], ambig[,3] == "Urn B", 0.60)
ambig[,4] <- replace(ambig[,4], ambig[,4] == "Urn A", 0.55)
ambig[,4] <- replace(ambig[,4], ambig[,4] == "Urn B", 0.50)
ambig[,5] <- replace(ambig[,5], ambig[,5] == "Urn A", 0.45)
ambig[,5] <- replace(ambig[,5], ambig[,5] == "Urn B", 0.40)
ambig[,6] <- replace(ambig[,6], ambig[,6] == "Urn A", 0.35)
ambig[,6] <- replace(ambig[,6], ambig[,6] == "Urn B", 0.30)
ambig[,7] <- replace(ambig[,7], ambig[,7] == "Urn A", 0.25)
ambig[,7] <- replace(ambig[,7], ambig[,7] == "Urn B", 0.20)
ambig[,8] <- replace(ambig[,8], ambig[,8] == "Urn A", 0.15)
ambig[,8] <- replace(ambig[,8], ambig[,8] == "Urn B", 0) # These make choices in ambig[,10]
ambig[,10] <- replace(ambig[,10], ambig[,10] == "Urn A", 0.10)
ambig[,10] <- replace(ambig[,10], ambig[,10] == "Urn B", 0.05)
for (i in 1:ncol(ambig)) {
  ambig[,i] <- as.numeric(ambig[,i])
}
ambig[,1] <- rowSums(ambig, na.rm = TRUE)
ambig <- ambig[,1]
if (output == "bipolar") {
  ambig <- (ambig-0.5)*2
}
}
