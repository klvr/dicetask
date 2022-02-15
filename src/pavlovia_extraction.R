####################################################################################################
# Extracts and collects data from BoxTask / Pavlovia                                               #
# Input: Pavlovia raw data (only uses the log.gz-files)                                            #
# Output: Cleaned csv-file in 'temp' containing raw DtD and choices, to be summarised              #
# Kristoffer Klevjer - github.com/klvr - klevjer(a)gmail.com                                       #
####################################################################################################

# 00 Preparation -----------------------------------------------------------------------------------

# Clean up workspare
rm(list = ls())

# Set up file for capture of data
boxTask <- NULL

# 01 Load raw data ---------------------------------------------------------------------------------

pavFiles <- list.files("data/raw/pavlovia/students2/", pattern = "*.log.gz")
pavPath <- paste("data/raw/pavlovia/students2/", pavFiles, sep ="")

# 02 Extract data per participant ------------------------------------------------------------------

# Loop over each participant
for (i in pavPath) {

# Read in raw data
pavData <- read.delim(i, quote = "")

# Remove redundant set-up data
pavData <- pavData[-c(1:match("box_14: autoDraw = true", pavData[,3])),]

# Get ID
ID <- unlist(strsplit(unlist(strsplit(i, "/"))[length(unlist(strsplit(i, "/")))], "_"))[1]

# Get responses
pavTrail1Choice <- pavData[c(match("text: autoDraw = true", pavData[,3]):
                               match("text_2: autoDraw = true", pavData[,3])),]
pavTrail2Choice <- pavData[c(match("text_2: autoDraw = true", pavData[,3]):
                               match("text_3: autoDraw = true", pavData[,3])),]
pavTrail3Choice <- pavData[c(match("text_3: autoDraw = true", pavData[,3]):
                               match("text_4: autoDraw = true", pavData[,3])),]
pavTrail4Choice <- pavData[c(match("text_4: autoDraw = true", pavData[,3]):
                               match("end_message: autoDraw = true", pavData[,3])),]
pavTrail1Choice <- pavTrail1Choice[grep("Keydown:", pavTrail1Choice[,3]),3]
pavTrail2Choice <- pavTrail2Choice[grep("Keydown:", pavTrail2Choice[,3]),3]
pavTrail3Choice <- pavTrail3Choice[grep("Keydown:", pavTrail3Choice[,3]),3]
pavTrail4Choice <- pavTrail4Choice[grep("Keydown:", pavTrail4Choice[,3]),3]
## Remove empty (non-response) responses and double-responses
### Trial 1
if (length(pavTrail1Choice) > 1) { # If multiple responses
  jpressed <- (max(grepl("Keydown: j", pavTrail1Choice)>0))
  kpressed <- (max(grepl("Keydown: k", pavTrail1Choice)>0))
  if(jpressed==1) {pavTrail1Choice <- "Keydown: j"} # All 'j' or 'j' + empty, set to 'j'
  if(kpressed==1) {pavTrail1Choice <- "Keydown: k"} # All 'k' or 'k' + empty, set to 'k'
  if(jpressed+kpressed>1) {pavTrail1Choice <- NA} # Contains both, set to 'NA'
}
if (length(pavTrail1Choice) == 0) {pavTrail1Choice <- NA} # If no response, set to 'NA'
### Trial 2
if (length(pavTrail2Choice) > 1) { # If multiple responses
  jpressed <- (max(grepl("Keydown: j", pavTrail2Choice)>0))
  kpressed <- (max(grepl("Keydown: k", pavTrail2Choice)>0))
  if(jpressed==1) {pavTrail2Choice <- "Keydown: j"} # All 'j' or 'j' + empty, set to 'j'
  if(kpressed==1) {pavTrail2Choice <- "Keydown: k"} # All 'k' or 'k' + empty, set to 'k'
  if(jpressed+kpressed>1) {pavTrail2Choice <- NA} # Contains both, set to 'NA'
}
if (length(pavTrail2Choice) == 0) {pavTrail2Choice <- NA} # If no response, set to 'NA'
### Trial 3
if (length(pavTrail3Choice) > 1) { # If multiple responses
  jpressed <- (max(grepl("Keydown: j", pavTrail3Choice)>0))
  kpressed <- (max(grepl("Keydown: k", pavTrail3Choice)>0))
  if(jpressed==1) {pavTrail3Choice <- "Keydown: j"} # All 'j' or 'j' + empty, set to 'j'
  if(kpressed==1) {pavTrail3Choice <- "Keydown: k"} # All 'k' or 'k' + empty, set to 'k'
  if(jpressed+kpressed>1) {pavTrail3Choice <- NA} # Contains both, set to 'NA'
}
if (length(pavTrail3Choice) == 0) {pavTrail3Choice <- NA} # If no response, set to 'NA'
### Trial 4
if (length(pavTrail4Choice) > 1) { # If multiple responses
  jpressed <- (max(grepl("Keydown: j", pavTrail4Choice)>0))
  kpressed <- (max(grepl("Keydown: k", pavTrail4Choice)>0))
  if(jpressed==1) {pavTrail4Choice <- "Keydown: j"} # All 'j' or 'j' + empty, set to 'j'
  if(kpressed==1) {pavTrail4Choice <- "Keydown: k"} # All 'k' or 'k' + empty, set to 'k'
  if(jpressed+kpressed>1) {pavTrail4Choice <- NA} # Contains both, set to 'NA'
}
if (length(pavTrail4Choice) == 0) {pavTrail4Choice <- NA} # If no response, set to 'NA'

# Get opened boxes
## Trial 1
pavBox1 <- length(pavData[grep("box_1: fill", pavData[,3]),3])>0
pavBox2 <- length(pavData[grep("box_2: fill", pavData[,3]),3])>0
pavBox3 <- length(pavData[grep("box_3: fill", pavData[,3]),3])>0
pavBox4 <- length(pavData[grep("box_4: fill", pavData[,3]),3])>0
pavBox5 <- length(pavData[grep("box_5: fill", pavData[,3]),3])>0
pavBox6 <- length(pavData[grep("box_6: fill", pavData[,3]),3])>0
pavBox7 <- length(pavData[grep("box_7: fill", pavData[,3]),3])>0
pavBox8 <- length(pavData[grep("box_8: fill", pavData[,3]),3])>0
pavBox9 <- length(pavData[grep("box_9: fill", pavData[,3]),3])>0
pavBox10 <- length(pavData[grep("box_10: fill", pavData[,3]),3])>0
pavBox11 <- length(pavData[grep("box_11: fill", pavData[,3]),3])>0
pavBox12 <- length(pavData[grep("box_12: fill", pavData[,3]),3])>0
pavBox13 <- length(pavData[grep("box_13: fill", pavData[,3]),3])>0
pavBox14 <- length(pavData[grep("box_14: fill", pavData[,3]),3])>0
pavBox15 <- length(pavData[grep("box_15: fill", pavData[,3]),3])>0
pavBoxTrial1 <- pavBox1 + pavBox2 + pavBox3 + pavBox4 + pavBox5 + pavBox6 + pavBox7 + pavBox8 +
                pavBox9 + pavBox10 + pavBox11 + pavBox12 + pavBox13 + pavBox14 + pavBox15
## Trial 2
pavBox16 <- length(pavData[grep("box_16: fill", pavData[,3]),3])>0
pavBox17 <- length(pavData[grep("box_17: fill", pavData[,3]),3])>0
pavBox18 <- length(pavData[grep("box_18: fill", pavData[,3]),3])>0
pavBox19 <- length(pavData[grep("box_19: fill", pavData[,3]),3])>0
pavBox20 <- length(pavData[grep("box_20: fill", pavData[,3]),3])>0
pavBox21 <- length(pavData[grep("box_21: fill", pavData[,3]),3])>0
pavBox22 <- length(pavData[grep("box_22: fill", pavData[,3]),3])>0
pavBox23 <- length(pavData[grep("box_23: fill", pavData[,3]),3])>0
pavBox24 <- length(pavData[grep("box_24: fill", pavData[,3]),3])>0
pavBox25 <- length(pavData[grep("box_25: fill", pavData[,3]),3])>0
pavBox26 <- length(pavData[grep("box_26: fill", pavData[,3]),3])>0
pavBox27 <- length(pavData[grep("box_27: fill", pavData[,3]),3])>0
pavBox28 <- length(pavData[grep("box_28: fill", pavData[,3]),3])>0
pavBox29 <- length(pavData[grep("box_29: fill", pavData[,3]),3])>0
pavBoxUn <- length(pavData[grep("box: fill", pavData[,3]),3])>0 #Just named 'box'
pavBoxTrial2 <- pavBox16 + pavBox17 + pavBox18 + pavBox19 + pavBox20 + pavBox21 + pavBox22 + 
                pavBox23 + pavBox24 + pavBox25 + pavBox26 + pavBox27 + pavBox28 + pavBox29 + pavBoxUn
## Trial 3
pavBox30 <- length(pavData[grep("box_30: fill", pavData[,3]),3])>0
pavBox31 <- length(pavData[grep("box_31: fill", pavData[,3]),3])>0
pavBox32 <- length(pavData[grep("box_32: fill", pavData[,3]),3])>0
pavBox33 <- length(pavData[grep("box_33: fill", pavData[,3]),3])>0
pavBox34 <- length(pavData[grep("box_34: fill", pavData[,3]),3])>0
pavBox35 <- length(pavData[grep("box_35: fill", pavData[,3]),3])>0
pavBox36 <- length(pavData[grep("box_36: fill", pavData[,3]),3])>0
pavBox37 <- length(pavData[grep("box_37: fill", pavData[,3]),3])>0
pavBox38 <- length(pavData[grep("box_38: fill", pavData[,3]),3])>0
pavBox39 <- length(pavData[grep("box_39: fill", pavData[,3]),3])>0
pavBox40 <- length(pavData[grep("box_40: fill", pavData[,3]),3])>0
pavBox41 <- length(pavData[grep("box_41: fill", pavData[,3]),3])>0
pavBox42 <- length(pavData[grep("box_42: fill", pavData[,3]),3])>0
pavBox43 <- length(pavData[grep("box_43: fill", pavData[,3]),3])>0
pavBox44 <- length(pavData[grep("box_44: fill", pavData[,3]),3])>0
pavBoxTrial3 <- pavBox30 + pavBox31 + pavBox32 + pavBox33 + pavBox34 + pavBox35 + pavBox36 + 
                pavBox37 + pavBox38 + pavBox39 + pavBox40 + pavBox41 + pavBox42 + pavBox43 + pavBox44

## Trial 4
pavBox45 <- length(pavData[grep("box_45: fill", pavData[,3]),3])>0
pavBox46 <- length(pavData[grep("box_46: fill", pavData[,3]),3])>0
pavBox47 <- length(pavData[grep("box_47: fill", pavData[,3]),3])>0
pavBox48 <- length(pavData[grep("box_48: fill", pavData[,3]),3])>0
pavBox49 <- length(pavData[grep("box_49: fill", pavData[,3]),3])>0
pavBox50 <- length(pavData[grep("box_50: fill", pavData[,3]),3])>0
pavBox51 <- length(pavData[grep("box_51: fill", pavData[,3]),3])>0
pavBox52 <- length(pavData[grep("box_52: fill", pavData[,3]),3])>0
pavBox53 <- length(pavData[grep("box_53: fill", pavData[,3]),3])>0
pavBox54 <- length(pavData[grep("box_54: fill", pavData[,3]),3])>0
pavBox55 <- length(pavData[grep("box_55: fill", pavData[,3]),3])>0
pavBox56 <- length(pavData[grep("box_56: fill", pavData[,3]),3])>0
pavBox57 <- length(pavData[grep("box_57: fill", pavData[,3]),3])>0
pavBox58 <- length(pavData[grep("box_58: fill", pavData[,3]),3])>0
pavBox59 <- length(pavData[grep("box_59: fill", pavData[,3]),3])>0
pavBoxTrial4 <- pavBox45 + pavBox46 + pavBox47 + pavBox48 + pavBox49 + pavBox50 + pavBox51 + 
  pavBox52 + pavBox53 + pavBox54 + pavBox55 + pavBox56 + pavBox57 + pavBox58 + pavBox59

# Collect Box DtD & tie to responses
pavBoxPart <- cbind(pavBoxTrial1, pavBoxTrial2, pavBoxTrial3, pavBoxTrial4)
pavBoxPart <- c(ID, pavBoxPart, pavTrail1Choice, pavTrail2Choice, pavTrail3Choice, pavTrail4Choice)

# 03 Stitch together participant data --------------------------------------------------------------

boxTask <- rbind(boxTask, pavBoxPart) }

# Convert to data frame
boxTask <- as.data.frame(boxTask)

# Set column names
colnames(boxTask) <- c("ID", "DtD1", "DtD2", "DtD3", "DtD4",
                       "Choice1", "Choice2", "Choice3", "Choice4")

# 04 Save cleaned CSV-file -------------------------------------------------------------------------

write.csv(boxTask, "data/temp/pavlovia_students_2.csv")