####################################################################################################
# Extracts, collects and summarises data from BoxTask / Pavlovia                                   #
# Input: Pavlovia raw data (only uses the log.gz-files)                                            #
# Output: Two CSV-files, raw DtD and choices in 'temp', and summary/recoded scores in 'processed'  #
# Meta-output: Outputs a meta-file on relevant data removed (e.g., due to multiple attempts)       #
# Kristoffer Klevjer - github.com/klvr - klevjer(a)gmail.com                                       #
####################################################################################################

# 00 Preparation -----------------------------------------------------------------------------------

# Clean up workspare
rm(list = ls())

# Source own functions
for (i in list.files("src/functions", full.names = TRUE)) {source(i)}

# Set up file for capture of data
boxTask <- NULL

# Set up meta file to capture data removal
metaBoxTask <- NULL

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

# 04 Output CSV-files for raw DtD and choices in 'temp' --------------------------------------------

write.csv(boxTask, "data/temp/pavlovia_students_2.csv")

# 05 Clean-up  -------------------------------------------------------------------------------------

# Record multiple attempts prior to removal
metaMultiAttempt <- c(sum(duplicated(boxTask[,1])), "Multiple attempts")
metaUniqeMultiAttempt <- c(length(unique(boxTask[duplicated(boxTask[,1]),1])),
                           "Participants with multiple attempts")
metaBoxTask <- rbind(metaMultiAttempt, metaUniqeMultiAttempt)
colnames(metaBoxTask) <- c("N", "Reason")

# Flagging of multiple attempts and only keep first (time-wise) attempt
boxTask$multipleAttempt <- as.numeric(duplicated(boxTask[,1]))
for (i in 1:length(boxTask$multipleAttempt)) { #Will throw error as the length decreases, disregard
  if (boxTask[i,10] == 1) {
    boxTask[i-1,10] <- 9
    boxTask <- boxTask[-i,]
    }
}
boxTask <- boxTask[!(boxTask$multipleAttempt==1),]
for (i in 1:length(boxTask$multipleAttempt)) {
  if (boxTask[i,10] == 9) {
    boxTask[i,10] <- 1
    }
}

# Set IDs as row names
row.names(boxTask) <- boxTask[,1]
boxTask <- boxTask[,-1]

# Recode choices into 1: correct, 0: incorrect
boxTask[,5] <- recodeSingle(boxTask[,5], c = "Keydown: j")
boxTask[,6] <- recodeSingle(boxTask[,6], c = "Keydown: k")
boxTask[,7] <- recodeSingle(boxTask[,7], c = "Keydown: k")
boxTask[,8] <- recodeSingle(boxTask[,8], c = "Keydown: j")

# Change all to numeric values
boxTask[,1] <- as.numeric(as.character(boxTask[,1]))
boxTask[,2] <- as.numeric(as.character(boxTask[,2]))
boxTask[,3] <- as.numeric(as.character(boxTask[,3]))
boxTask[,4] <- as.numeric(as.character(boxTask[,4]))

# 06 Ideal Observer thresholds ---------------------------------------------------------------------

# Observable sequences
seqTrial1 <- c(1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1)
seqTrial2 <- c(0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1)
seqTrial3 <- c(1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1)
seqTrial4 <- c(0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0)
## Reverse trial 2 and 3 as they had '0' as majority
seqTrial2 <- (seqTrial2 - 1) * -1
seqTrial3 <- (seqTrial3 - 1) * -1
## All collected
sequences <- c("seqTrial1","seqTrial2","seqTrial3","seqTrial4")

# Calculate thresholds
thresholdSequences <- NULL # Set-up data frame
for (i in sequences) {
  seq <- eval(parse(text = i)) # Read in sequences
  probl <- 8
  probh <- 8
  problow <- probl - cumsum(seq)
  probhigh <- probh - cumsum((seq*-1)+1)
  thresholdSeq <- probhigh / (probhigh+problow)
  thresholdSeq <- replace(thresholdSeq, thresholdSeq>1, 1)
  thresholdSequences <- cbind(thresholdSequences, thresholdSeq)
}
## Set row names
colnames(thresholdSequences) <- c("IO1","IO2","IO3","IO4")

# Add in IO to main data frame
## Add inn DtD duplicates to be replaced
boxTask <- cbind(boxTask, boxTask[,c(1,2,3,4)]) 
## Make zero-draws into NA for IO
boxTask[,c(10,11,12,13)] <- replace(boxTask[,c(10,11,12,13)], boxTask[,c(10,11,12,13)] == 0, NA)
## Replace DtD with IO in boxTask data frame
for (i in 1:nrow(boxTask)) {
  if (!is.na(boxTask[i,10])) {boxTask[i,10] <- thresholdSequences[boxTask[i,10],1]}
  if (!is.na(boxTask[i,11])) {boxTask[i,11] <- thresholdSequences[boxTask[i,11],2]}
  if (!is.na(boxTask[i,12])) {boxTask[i,12] <- thresholdSequences[boxTask[i,12],3]}
  if (!is.na(boxTask[i,13])) {boxTask[i,13] <- thresholdSequences[boxTask[i,13],4]}
}
## Convert NA's back to .50-probability for IO
boxTask[,c(10,11,12,13)] <- replace(boxTask[,c(10,11,12,13)], is.na(boxTask[,c(10,11,12,13)]), 0.5)

# 07 Variable creation -----------------------------------------------------------------------------

# Create 'DtD'-based exclusion criteria variables
## Trial wise DtD =< 2
boxTask$excludeDtD1 <- as.numeric(boxTask[,1]<3)
boxTask$excludeDtD2 <- as.numeric(boxTask[,2]<3)
boxTask$excludeDtD3 <- as.numeric(boxTask[,3]<3)
boxTask$excludeDtD4 <- as.numeric(boxTask[,4]<3)
## Overall mean trial wise exclusion (0: no trials to be excluded, 1: all trials to be excluded)
boxTask$excludeOverall <- rowMeans(boxTask[,c(14,15,16,17)])

# Create mean score variable (x2, with and without exclusion trials counted;
#                                             0: no correct, 1: all correct)
boxTask$overallScore <- rowMeans(boxTask[,c(5,6,7,8)], na.rm = TRUE)
boxTask$overallScoreE <- rowMeans(
  (replace(boxTask[,c(5,6,7,8)], boxTask[,c(14,15,16,17)] == 1, NA)), na.rm = TRUE)

# Create mean DtD variable (x2, with and without exclusion trials counted)
boxTask$overallDtD <- rowMeans(boxTask[,c(1,2,3,4)], na.rm = TRUE)
boxTask$overallDtDE <- rowMeans(
  (replace(boxTask[,c(1,2,3,4)], boxTask[,c(14,15,16,17)] == 1, NA)), na.rm = TRUE)

# Create mean IO variable (x2, with and without exclusion trials counted)
boxTask$overallIO <- rowMeans(boxTask[,c(10,11,12,13)], na.rm = TRUE)
boxTask$overallIOE <- rowMeans(
  (replace(boxTask[,c(10,11,12,13)], boxTask[,c(14,15,16,17)] == 1, NA)), na.rm = TRUE)

# Create 'reached certainty' variable (x2, with and without exclusion trials counted;
#                                           0: in no trials, 1: in all trials)
boxTask$reachcert <- rowMeans(boxTask[,c(10,11,12,13)]==1, na.rm = TRUE)
boxTask$reachcertE <- rowMeans(
  (replace(boxTask[,c(10,11,12,13)], boxTask[,c(14,15,16,17)] == 1, NA))==1, na.rm = TRUE)

# Create 'opened all boxes' variables (x2, with and without exclusion trials counted;
#                                           0: in no trials, 1: in all trials)
boxTask$allboxs <- rowMeans(boxTask[,c(1,2,3,4)]==15, na.rm = TRUE)
boxTask$allboxsE <- rowMeans(
  (replace(boxTask[,c(1,2,3,4)], boxTask[,c(14,15,16,17)] == 1, NA))==15, na.rm = TRUE)

# Create 'went with minority colour' variable (0: in no trials, 1: in all trials; without '0'-draws)
## Chosing minority, or majority when in observed minority (due to sequence) is counted.
trial1min <- ((boxTask[,5] -1)*-1)
trial1min <- replace(trial1min, boxTask[,1]==0, NA)
trial2min <- (((boxTask[,2]==2) + (boxTask[,2]==4)) == boxTask[,6]) 
trial2min <- replace(trial2min, boxTask[,2]==0, NA)
trial3min <- ((boxTask[,3]<5) == boxTask[,7])
trial3min <- replace(trial3min, boxTask[,3]==0, NA)
trial4min <- ((boxTask[,4]<5) == boxTask[,8])
trial4min <- replace(trial4min, boxTask[,4]==0, NA)
boxTask$wentMin <- rowMeans(cbind(trial1min, trial2min, trial3min, trial4min), na.rm = TRUE)

# Update metaFile with n incomplete data
## '0' draws
meta0drawtrials <- sum(boxTask[,c(1,2,3,4)]==0)
metaUnique0drawtrials <- sum(rowSums(boxTask[,c(1,2,3,4)]==0)>0)
## Missing response
metaMissingResp <- sum(is.na(boxTask[,c(5,6,7,8)]))
metaUniqueMissingResp <- sum(rowSums(is.na(boxTask[,c(5,6,7,8)])))
## Update meta
metaBoxTask <- rbind(metaBoxTask, c(meta0drawtrials, "Zero draw trials"), c(metaUnique0drawtrials, 
                     "Participants with zero draw trials"), c(metaMissingResp,
                      "Missing resp trials"), c(metaUniqueMissingResp, 
                      "Participants with missing resp trials"))

# 08 Output CSV-files for all data in 'processed' --------------------------------------------------

# Fix row-names to match that of other tasks
colnames(boxTask) <- c("boxDtD1", "boxDtD2", "boxDtD3", "boxDtD4", "boxScore1", "boxScore2",
                       "boxScore3", "boxScore4", "boxMultiAttempt", "boxIO1", "boxIO2", "boxIO3",
                       "boxIO4", "boxExcl1", "boxExcl2", "boxExcl3", "boxExcl4", "boxExclOverall",
                       "boxScoreOverall", "boxScoreOverallE", "boxDtDOverall", "boxDtDOverallE",
                       "boxIOOverall", "boxIOOverallE", "boxReachCert", "boxReachCertE",
                       "boxAllBoxs", "boxAllBoxsE", "boxWentMin")
row.names(metaBoxTask) <- NULL

# Remove course-only participant
metaCourse <- sum(row.names(boxTask)=="2334")
metaBoxTask <- rbind(metaBoxTask, c(metaCourse, "Participants excluded for science"))
boxTask <- boxTask[row.names(boxTask)!="2334",]

# Create summary-file
write.csv(boxTask[,-c(1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,19,21,23,25,27)],
          "data/processed/box-task_summary.csv")

# Create full-data file
write.csv(boxTask, "data/processed/box-task_full.csv")

# Create meta file
write.csv(metaBoxTask, "data/processed/meta_box-task.csv")