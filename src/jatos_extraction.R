####################################################################################################
# Extracts, collects and summarises data from Dice-task / JATOS                                    #
# Input: Jatos raw data                                                                            #
# Output: Two CSV-files, raw DtD and choices in 'temp', and summary/recoded scores in 'processed'  #
# Meta-output: Outputs a meta-file on relevant data removed (e.g., due to multiple attempts)       #
# Note: Section 00 to (and including) 04 runs automatically on all new data. From section 03 it's  #
#       experiment specific and must be adjusted for new experiments (not new data)                #
# Kristoffer Klevjer - github.com/klvr - klevjer(a)gmail.com                                       #
####################################################################################################

# 00 Preparation -----------------------------------------------------------------------------------

# Clean up workspare
rm(list = ls())

# Source own functions
for (i in list.files("src/functions", full.names = TRUE)) {source(i)}

# Set up file for capture of data
diceTask <- NULL

# Set up meta file to capture data removal
metaDiceTask <- NULL

# 01 Load raw data ---------------------------------------------------------------------------------

jatFiles <- list.files("data/raw/jatos", pattern = "*.txt", recursive = TRUE)
jatPath <- paste("data/raw/jatos/", jatFiles, sep ="")

# 02 Extract data per participant ------------------------------------------------------------------

# Read in experiment data
for (x in 1:length(jatPath)) {
jatData <- read.delim(jatPath[x], header = FALSE)

# Find individual participants
participants <- grep("studyId:*", jatData[,1])
participants <- c(participants, nrow(jatData)+1)

# Extract data-rows per participant
for (i in 1:(length(participants)-1)) {
jatPart <- as.data.frame(jatData[participants[i]:(participants[i+1]-1),])
diceMeta <- jatPart[1,] # Meta, such as study ID and participant ID
diceTrial1Pre <- jatPart[2,] # Preconcived loadnedness trial 1
dice1 <- jatPart[3,] # Throwing of dice 1
dice1Deb <- jatPart[4,] # Questionnaire assessing dice 1
dice2 <- jatPart[5,]
dice2Deb <- jatPart[6,]
dice3 <- jatPart[7,]
dice3Deb <- jatPart[8,]
dice4 <- jatPart[9,]
dice4Deb <- jatPart[10,]
diceTrial1End <- jatPart[11,] # End choice as to which was loaded in trial 1
diceTrial2Pre <- jatPart[12,]
dice5 <- jatPart[13,]
dice5Deb <- jatPart[14,]
dice6 <- jatPart[15,]
dice6Deb <- jatPart[16,]
dice7 <- jatPart[17,]
dice7Deb <- jatPart[18,]
dice8 <- jatPart[19,]
dice8Deb <- jatPart[20,]
diceTrial2End <- jatPart[21,]
## Catching of limited throws if they were administered not done!

# Extracting relevant data from each row
## Meta
diceMetaStudyID <- unlist(strsplit(diceMeta, ","))[ 
                   grep("studyId*", unlist(strsplit(diceMeta, ",")))] # Fetch row with StudyID
diceMetaStudyID <- unlist(strsplit(diceMetaStudyID, ":"))[2] # Only keep actual StudyID
diceMetaPartID <- unlist(strsplit(diceMeta, ","))[ 
                  grep("qualtricsID*", unlist(strsplit(diceMeta, ",")))] # Fetch row with partID
diceMetaPartID <- unlist(strsplit(diceMetaPartID, ":"))[2] # Only keep actual ParticipantID
## Throws before stopping
diceDtD1 <- length(unlist(strsplit(unlist(strsplit(unlist(strsplit(dice1,
                                                                   "\\["))[2], "\\]"))[1], ",")))
diceDtD2 <- length(unlist(strsplit(unlist(strsplit(unlist(strsplit(dice2,
                                                                   "\\["))[2], "\\]"))[1], ",")))
diceDtD3 <- length(unlist(strsplit(unlist(strsplit(unlist(strsplit(dice3,
                                                                   "\\["))[2], "\\]"))[1], ",")))
diceDtD4 <- length(unlist(strsplit(unlist(strsplit(unlist(strsplit(dice4,
                                                                   "\\["))[2], "\\]"))[1], ",")))
diceDtD5 <- length(unlist(strsplit(unlist(strsplit(unlist(strsplit(dice5,
                                                                   "\\["))[2], "\\]"))[1], ",")))
diceDtD6 <- length(unlist(strsplit(unlist(strsplit(unlist(strsplit(dice6,
                                                                   "\\["))[2], "\\]"))[1], ",")))
diceDtD7 <- length(unlist(strsplit(unlist(strsplit(unlist(strsplit(dice7,
                                                                   "\\["))[2], "\\]"))[1], ",")))
diceDtD8 <- length(unlist(strsplit(unlist(strsplit(unlist(strsplit(dice8,
                                                                   "\\["))[2], "\\]"))[1], ",")))
## Individual die questionnaire
dice1Load <- unlist(strsplit(unlist(strsplit(dice1Deb, "q1,value:"))[2], ""))[1]
dice1LoadCert <- unlist(strsplit(unlist(strsplit(dice1Deb, "q2,value:"))[2], "\\}"))[1]
if (dice1Load == "0") {dice1LoadWhat <- 
                      unlist(strsplit(unlist(strsplit(dice1Deb, "q3,value:"))[2], ""))[1]
                     } else {dice1LoadWhat <- NA} # Set loaded on what to NA if not indicated loaded
dice2Load <- unlist(strsplit(unlist(strsplit(dice2Deb, "q1,value:"))[2], ""))[1]
dice2LoadCert <- unlist(strsplit(unlist(strsplit(dice2Deb, "q2,value:"))[2], "\\}"))[1]
if (dice2Load == "0") {dice2LoadWhat <- 
                      unlist(strsplit(unlist(strsplit(dice2Deb, "q3,value:"))[2], ""))[1]
                     } else {dice2LoadWhat <- NA} # Set loaded on what to NA if not indicated loaded
dice3Load <- unlist(strsplit(unlist(strsplit(dice3Deb, "q1,value:"))[2], ""))[1]
dice3LoadCert <- unlist(strsplit(unlist(strsplit(dice3Deb, "q2,value:"))[2], "\\}"))[1]
if(dice3Load == "0") {dice3LoadWhat <- 
                      unlist(strsplit(unlist(strsplit(dice3Deb, "q3,value:"))[2], ""))[1]
                     } else {dice3LoadWhat <- NA} # Set loaded on what to NA if not indicated loaded
dice4Load <- unlist(strsplit(unlist(strsplit(dice4Deb, "q1,value:"))[2], ""))[1]
dice4LoadCert <- unlist(strsplit(unlist(strsplit(dice4Deb, "q2,value:"))[2], "\\}"))[1]
if(dice4Load == "0") {dice4LoadWhat <- 
                      unlist(strsplit(unlist(strsplit(dice4Deb, "q3,value:"))[2], ""))[1]
                     } else {dice4LoadWhat <- NA} # Set loaded on what to NA if not indicated loaded
dice5Load <- unlist(strsplit(unlist(strsplit(dice5Deb, "q1,value:"))[2], ""))[1]
dice5LoadCert <- unlist(strsplit(unlist(strsplit(dice5Deb, "q2,value:"))[2], "\\}"))[1]
if(dice5Load == "0") {dice5LoadWhat <- 
                      unlist(strsplit(unlist(strsplit(dice5Deb, "q3,value:"))[2], ""))[1]
                     } else {dice5LoadWhat <- NA} # Set loaded on what to NA if not indicated loaded
dice6Load <- unlist(strsplit(unlist(strsplit(dice6Deb, "q1,value:"))[2], ""))[1]
dice6LoadCert <- unlist(strsplit(unlist(strsplit(dice6Deb, "q2,value:"))[2], "\\}"))[1]
if(dice6Load == "0") {dice6LoadWhat <- 
                      unlist(strsplit(unlist(strsplit(dice6Deb, "q3,value:"))[2], ""))[1]
                     } else {dice6LoadWhat <- NA} # Set loaded on what to NA if not indicated loaded
dice7Load <- unlist(strsplit(unlist(strsplit(dice7Deb, "q1,value:"))[2], ""))[1]
dice7LoadCert <- unlist(strsplit(unlist(strsplit(dice7Deb, "q2,value:"))[2], "\\}"))[1]
if(dice7Load == "0") {dice7LoadWhat <- 
                      unlist(strsplit(unlist(strsplit(dice7Deb, "q3,value:"))[2], ""))[1]
                     } else {dice7LoadWhat <- NA} # Set loaded on what to NA if not indicated loaded
dice8Load <- unlist(strsplit(unlist(strsplit(dice8Deb, "q1,value:"))[2], ""))[1]
dice8LoadCert <- unlist(strsplit(unlist(strsplit(dice8Deb, "q2,value:"))[2], "\\}"))[1]
if(dice8Load == "0") {dice8LoadWhat <- 
                      unlist(strsplit(unlist(strsplit(dice8Deb, "q3,value:"))[2], ""))[1]
                     } else {dice8LoadWhat <- NA} # Set loaded on what to NA if not indicated loaded
## Color sequences (only observed, did not affect the outcomes)
dice1Col <- unlist(strsplit(unlist(strsplit(dice1, ",color:"))[2],""))[1]
dice2Col <- unlist(strsplit(unlist(strsplit(dice2, ",color:"))[2],""))[1]
dice3Col <- unlist(strsplit(unlist(strsplit(dice3, ",color:"))[2],""))[1]
dice4Col <- unlist(strsplit(unlist(strsplit(dice4, ",color:"))[2],""))[1]
dice5Col <- unlist(strsplit(unlist(strsplit(dice5, ",color:"))[2],""))[1]
dice6Col <- unlist(strsplit(unlist(strsplit(dice6, ",color:"))[2],""))[1]
dice7Col <- unlist(strsplit(unlist(strsplit(dice7, ",color:"))[2],""))[1]
dice8Col <- unlist(strsplit(unlist(strsplit(dice8, ",color:"))[2],""))[1]
## Preconceived loadedness
diceTrial1Pre <- unlist(strsplit(unlist(strsplit(diceTrial1Pre, "value:"))[2], "\\}"))[1]
diceTrial2Pre <- unlist(strsplit(unlist(strsplit(diceTrial2Pre, "value:"))[2], "\\}"))[1]
## Trial end decision
diceTrial1End <- unlist(strsplit(unlist(strsplit(diceTrial1End, "value:"))[2], "\\}"))[1]
diceTrial2End <- unlist(strsplit(unlist(strsplit(diceTrial2End, "value:"))[2], "\\}"))[1]
## Make a correct (1) or not (0) variable for Trial*End
diceTrial1EndCor <- dice3Col
if(diceTrial1EndCor == 'r') {diceTrial1EndCor <- 0} else if (diceTrial1EndCor == 'b') {
  diceTrial1EndCor <- 1} else if (diceTrial1EndCor == 'y') {diceTrial1EndCor <- 2} else if (
    diceTrial1EndCor == 'p') {diceTrial1EndCor <- 3}
diceTrial1EndCor <- as.numeric(diceTrial1EndCor == diceTrial1End)
diceTrial2EndCor <- dice6Col
if(diceTrial2EndCor == 'r') {diceTrial2EndCor <- 0} else if (diceTrial2EndCor == 'b') {
  diceTrial2EndCor <- 1} else if (diceTrial2EndCor == 'y') {diceTrial2EndCor <- 2} else if (
    diceTrial2EndCor == 'p') {diceTrial2EndCor <- 3}
diceTrial2EndCor <- as.numeric(diceTrial2EndCor == diceTrial2End)

# Stitch together per participant
diceParticipant <- cbind(diceMetaStudyID, diceMetaPartID, diceDtD1, diceDtD2, diceDtD3, diceDtD4,
                         diceDtD5, diceDtD6, diceDtD7, diceDtD8, diceTrial1End, diceTrial1EndCor,
                         diceTrial2End, diceTrial2EndCor, diceTrial1Pre, diceTrial2Pre, dice1Load, 
                         dice1LoadCert, dice1LoadWhat, dice2Load, dice2LoadCert, dice2LoadWhat, 
                         dice3Load, dice3LoadCert, dice3LoadWhat, dice4Load, dice4LoadCert,
                         dice4LoadWhat, dice5Load, dice5LoadCert, dice5LoadWhat, dice6Load, 
                         dice6LoadCert, dice6LoadWhat, dice7Load, dice7LoadCert, dice7LoadWhat, 
                         dice8Load, dice8LoadCert, dice8LoadWhat, dice1Col, dice2Col, dice3Col,
                         dice4Col, dice5Col, dice6Col, dice7Col, dice8Col)
diceParticipant <- as.data.frame(diceParticipant)

# 03 Stitch together participant data --------------------------------------------------------------

diceTask <- rbind(diceTask, diceParticipant)
}

# 04 Output CSV-files for raw DtD and choices in 'temp' --------------------------------------------

# Make a variable for each experiment / jatos-file
filename <- unlist(strsplit(unlist(strsplit(jatFiles[x], "/"))[2], ".txt"))
assign(filename, diceTask)

# Save cleaned raw-data in 'temp'
write.csv(diceTask, paste("data/temp/", filename, "_raw.csv", sep=""))

# Reset diceTask-variable
diceTask <- NULL          
}

# 05 Clean up --------------------------------------------------------------------------------------
## Flagging and removal of multiple attempts, and variable-class fix

# Record and remove data without ID's
## Recode 'null' to NA for one participant in Prolific_1
jatos_prolific_1[jatos_prolific_1$diceMetaPartID=='null'&!is.na(jatos_prolific_1$diceMetaPartID),
                 2] <- NA
## Fetch all NA ID's for meta-file
hamburgNAs <- c(sum(is.na(jatos_hamburg$diceMetaPartID)), "Missing ID", "Hamburg")
prolific_1NAs <- c(sum(is.na(jatos_prolific_1$diceMetaPartID)), "Missing ID", "Prolific_1")
prolific_2NAs <- c(sum(is.na(jatos_prolific_2$diceMetaPartID)), "Missing ID", "Prolific_2")
students_1NAs <- c(sum(is.na(jatos_students$diceMetaPartID)), "Missing ID", "Students_1")
students_2NAs <- c(sum(is.na(jatos_students_2$diceMetaPartID)), "Missing ID", "Students_2")
metaDiceTask <- as.data.frame(rbind(hamburgNAs, prolific_1NAs, prolific_2NAs, students_1NAs,
                                    students_2NAs))
## Remove them
jatos_hamburg <- jatos_hamburg[!is.na(jatos_hamburg$diceMetaPartID),]
jatos_prolific_1 <- jatos_prolific_1[!is.na(jatos_prolific_1$diceMetaPartID),]
jatos_prolific_2 <- jatos_prolific_2[!is.na(jatos_prolific_2$diceMetaPartID),]
jatos_students <- jatos_students[!is.na(jatos_students$diceMetaPartID),]
jatos_students_2 <- jatos_students_2[!is.na(jatos_students_2$diceMetaPartID),]

# Find duplicate attempts in students (unique ID's, see 'src/functions/duplicate.detective.R')
remove <- matrix(nrow = nrow(jatos_students), ncol = 1)
remove <- cbind(as.numeric(jatos_students$diceMetaPartID), remove)
keep <- (sapply(remove[,1], function(x) sum(as.numeric(x)==students_dice_remove))-1)*-1
remove[,2] <- (keep-1)*-1
## Find participants with multiple attempts to be flagged
included <- NULL
for (i in remove[remove[,2]==1,1]) {
  if (i %in% pair01) {included <- c(included,55931)}
  if (i %in% pair02) {included <- c(included,59154)}
  if (i %in% pair03) {included <- c(included,43509)}
  if (i %in% pair04) {included <- c(included,63989)}
  if (i %in% pair05) {included <- c(included,21324)}
  if (i %in% pair06) {included <- c(included,88398)}
  if (i %in% pair07) {included <- c(included,74989)}
  if (i %in% pair08) {included <- c(included,94207)}
  if (i %in% pair09) {included <- c(included,93120)}
  if (i %in% pair10) {included <- c(included,39597)}
  if (i %in% pair11) {included <- c(included,33985)}
  if (i %in% pair12) {included <- c(included,"pair12")}
  if (i %in% pair13) {included <- c(included,31930)}
  if (i %in% pair14) {included <- c(included,60561)}
  if (i %in% pair15) {included <- c(included,64825)}
  if (i %in% pair16) {included <- c(included,80003)}
  if (i %in% pair17) {included <- c(included,"pair17")}
  if (i %in% pair18) {included <- c(included,15604)}
  if (i %in% pair19) {included <- c(included,10392)}
  if (i %in% pair20) {included <- c(included,19892)}
  if (i %in% pair21) {included <- c(included,71035)}
  if (i %in% pair22) {included <- c(included,41672)}
  if (i %in% pair23) {included <- c(included,"pair23")}
  if (i %in% pair24) {included <- c(included,94878)}
  if (i %in% pair25) {included <- c(included,72936)}
  if (i %in% pair26) {included <- c(included,59674)}
  if (i %in% pair27) {included <- c(included,73560)}
  if (i %in% pair28) {included <- c(included,44690)}
  if (i %in% pair29) {included <- c(included,64622)}
  if (i %in% pair30) {included <- c(included,12546)}
  if (i %in% pair31) {included <- c(included,42738)}
  if (i %in% pair32) {included <- c(included,"pair32")}
  if (i %in% pair33) {included <- c(included,12837)}
  if (i %in% pair34) {included <- c(included,11551)}
}
## Flagging of first-attempts kept in
jatos_students$diceMetaMultiAtt <- 0
for (i in 1:nrow(jatos_students)) {
  if (as.numeric(jatos_students[i,2]) %in% included) {jatos_students[i,"diceMetaMultiAtt"] <- 1}
}
## Save removed to meta-file
metaDiceTask <- rbind(metaDiceTask, c(sum(keep==0), "Duplicate attempts removed", "Students_1"))
metaDiceTask <- rbind(metaDiceTask, c(length(unique(included)),
                                      "Participants with duplicate attempts", "Students_1"))
metaDiceTask <- rbind(metaDiceTask, c(sum(jatos_students$diceMetaMultiAtt),
                                      "Participants with first attempt kept", "Students_1"))
## Actual removal
jatos_students <- jatos_students[as.logical(keep),]

# Combine the two Prolific data sets
jatos_prolific <- rbind(jatos_prolific_1, jatos_prolific_2)

# Find duplicate attempts in prolific (based on identical ID)
## Find duplicate attempts
duplicates <- duplicated(jatos_prolific$diceMetaPartID)
## Flagging of first-attempts kept in
duplicateIDs <- unique(jatos_prolific[duplicates,2])
jatos_prolific$diceMetaMultiAtt <- 0
for (i in 1:nrow(jatos_prolific)) {
  if (jatos_prolific[i,2] %in% duplicateIDs) {jatos_prolific[i,"diceMetaMultiAtt"] <- 1}
}
## Save removed to meta-file
metaDiceTask <- rbind(metaDiceTask, c(sum(duplicates), "Duplicate attempts removed", "Prolific_1&2"))
metaDiceTask <- rbind(metaDiceTask, c(length(duplicateIDs), 
                                      "Participants with duplicate attempts", "Prolific_1&2"))
metaDiceTask <- rbind(metaDiceTask, c(length(duplicateIDs), "Participants with first attempt kept",
                                      "Prolific_1&2"))
## Actual removal
keep <- (duplicates-1)*-1
jatos_prolific <- jatos_prolific[as.logical(keep),]

# Find duplicate attempts in students_2 data (based on identical ID)
## Find duplicate attempts
duplicates <- duplicated(jatos_students_2$diceMetaPartID)
## Flagging of first-attempts kept in
duplicateIDs <- unique(jatos_students_2[duplicates,2])
jatos_students_2$diceMetaMultiAtt <- 0
for (i in 1:nrow(jatos_students_2)) {
  if (jatos_students_2[i,2] %in% duplicateIDs) {jatos_students_2[i,"diceMetaMultiAtt"] <- 1}
}
## Save removed to meta-file
metaDiceTask <- rbind(metaDiceTask, c(sum(duplicates), "Duplicate attempts removed", "Students_2"))
metaDiceTask <- rbind(metaDiceTask, c(length(duplicateIDs), 
                                      "Participants with duplicate attempts", "Students_2"))
metaDiceTask <- rbind(metaDiceTask, c(length(duplicateIDs), "Participants with first attempt kept",
                                      "Students_2"))
## Actual removal
keep <- (duplicates-1)*-1
jatos_students_2 <- jatos_students_2[as.logical(keep),]

# Merge student data
## Fix students ID (contain leading white space)
jatos_students$diceMetaPartID <- as.numeric(as.character(jatos_students$diceMetaPartID))
jatos_students <- rbind(jatos_students, jatos_students_2)

# Check for duplicate ID's in all data. If any, they must be dealt with before moving on!
if(sum(duplicated(jatos_hamburg$diceMetaPartID))!=0){print("Duplicates in Hamburg data!")}
if(sum(duplicated(jatos_prolific$diceMetaPartID))!=0){print("Duplicates in Prolific data!")}
if(sum(duplicated(jatos_students$diceMetaPartID))!=0){print("Duplicates in Students data!")}
if(sum(duplicated(jatos_students_2$diceMetaPartID))!=0){print("Duplicates in Students_2 data!")}

# Set IDs as row names
row.names(jatos_hamburg) <- jatos_hamburg[,2]
jatos_hamburg <- jatos_hamburg[,-2]
row.names(jatos_prolific) <- jatos_prolific[,2]
jatos_prolific <- jatos_prolific[,-2]
row.names(jatos_students) <- jatos_students[,2]
jatos_students <- jatos_students[,-2]

# Convert relevant variables from character to numeric
changevars <- c(2:9, 11, 13, seq(16,37,3), seq(17,38,3))
for (i in changevars) {
  jatos_hamburg[,i] <- as.numeric(jatos_hamburg[,i])
  jatos_prolific[,i] <- as.numeric(jatos_prolific[,i])
  jatos_students[,i] <- as.numeric(jatos_students[,i])
}

# Add non-informative "diceMetaMultiAtt" for Hamburg data, so rows match with other experiments
jatos_hamburg$diceMetaMultiAtt <- 0

# 06 Variable creation -----------------------------------------------------------------------------
## Following the exclusion criteria variables, most variables are created in two ways, one with, and
## one without the excluded trials. Latter denoted with an 'E' at the end of the variable name.

# Variables for exclusion purposes
## Create 'DtD'-based exclusion criteria variables
### Trial wise mean DtD =< 2
jatos_hamburg$excludeDtDTrial1 <- rowSums(jatos_hamburg[,2:5])<9
jatos_hamburg$excludeDtDTrial2 <- rowSums(jatos_hamburg[,6:9])<9
jatos_prolific$excludeDtDTrial1 <- rowSums(jatos_prolific[,2:5])<9
jatos_prolific$excludeDtDTrial2 <- rowSums(jatos_prolific[,6:9])<9
jatos_students$excludeDtDTrial1 <- rowSums(jatos_students[,2:5])<9
jatos_students$excludeDtDTrial2 <- rowSums(jatos_students[,6:9])<9
### Overall mean trial wise exclusion (0: no trials to be excluded, 1: all trials to be excluded)
jatos_hamburg$excludeDtDOverall <- rowMeans(jatos_hamburg[,49:50])
jatos_prolific$excludeDtDOverall <- rowMeans(jatos_prolific[,49:50])
jatos_students$excludeDtDOverall <- rowMeans(jatos_students[,49:50])

# Variables for 'score' and attention / comprehension and checks
## Per dice, was the participant correct in reported loadedness
### Trial-wise correctness
jatos_hamburg$diceIndLoadTrial1 <- rowMeans(cbind(jatos_hamburg[,c(16,19,25)],
                                                  ((jatos_hamburg[,22]-1)*-1)))
jatos_hamburg$diceIndLoadTrial2 <- rowMeans(cbind(jatos_hamburg[,c(28,34,37)],
                                                  ((jatos_hamburg[,31]-1)*-1)))
jatos_prolific$diceIndLoadTrial1 <- rowMeans(cbind(jatos_prolific[,c(16,19,25)],
                                                  ((jatos_prolific[,22]-1)*-1)))
jatos_prolific$diceIndLoadTrial2 <- rowMeans(cbind(jatos_prolific[,c(28,34,37)],
                                                  ((jatos_prolific[,31]-1)*-1)))
jatos_students$diceIndLoadTrial1 <- rowMeans(cbind(jatos_students[,c(16,19,25)],
                                                  ((jatos_students[,22]-1)*-1)))
jatos_students$diceIndLoadTrial2 <- rowMeans(cbind(jatos_students[,c(28,34,37)],
                                                  ((jatos_students[,31]-1)*-1)))
jatos_hamburg$diceIndLoadTrial1E <- jatos_hamburg$diceIndLoadTrial1
jatos_hamburg$diceIndLoadTrial1E <- replace(jatos_hamburg$diceIndLoadTrial1E, 
                                            jatos_hamburg$excludeDtDTrial1, NA)
jatos_hamburg$diceIndLoadTrial2E <- jatos_hamburg$diceIndLoadTrial2
jatos_hamburg$diceIndLoadTrial2E <- replace(jatos_hamburg$diceIndLoadTrial2E, 
                                            jatos_hamburg$excludeDtDTrial2, NA)
jatos_prolific$diceIndLoadTrial1E <- jatos_prolific$diceIndLoadTrial1
jatos_prolific$diceIndLoadTrial1E <- replace(jatos_prolific$diceIndLoadTrial1E, 
                                            jatos_prolific$excludeDtDTrial1, NA)
jatos_prolific$diceIndLoadTrial2E <- jatos_prolific$diceIndLoadTrial2
jatos_prolific$diceIndLoadTrial2E <- replace(jatos_prolific$diceIndLoadTrial2E, 
                                            jatos_prolific$excludeDtDTrial2, NA)
jatos_students$diceIndLoadTrial1E <- jatos_students$diceIndLoadTrial1
jatos_students$diceIndLoadTrial1E <- replace(jatos_students$diceIndLoadTrial1E, 
                                            jatos_students$excludeDtDTrial1, NA)
jatos_students$diceIndLoadTrial2E <- jatos_students$diceIndLoadTrial2
jatos_students$diceIndLoadTrial2E <- replace(jatos_students$diceIndLoadTrial2E, 
                                            jatos_students$excludeDtDTrial2, NA)
### Overall correctness
jatos_hamburg$diceIndLoadOverall <- rowMeans(jatos_hamburg[,c(52,53)])
jatos_prolific$diceIndLoadOverall <- rowMeans(jatos_prolific[,c(52,53)])
jatos_students$diceIndLoadOverall <- rowMeans(jatos_students[,c(52,53)])
jatos_hamburg$diceIndLoadOverallE <- rowMeans(jatos_hamburg[,c(54,55)], na.rm = TRUE)
jatos_hamburg$diceIndLoadOverallE <- replace(jatos_hamburg$diceIndLoadOverallE, 
                                             is.nan(jatos_hamburg$diceIndLoadOverallE), NA)
jatos_prolific$diceIndLoadOverallE <- rowMeans(jatos_prolific[,c(54,55)], na.rm = TRUE)
jatos_prolific$diceIndLoadOverallE <- replace(jatos_prolific$diceIndLoadOverallE, 
                                             is.nan(jatos_prolific$diceIndLoadOverallE), NA)
jatos_students$diceIndLoadOverallE <- rowMeans(jatos_students[,c(54,55)], na.rm = TRUE)
jatos_students$diceIndLoadOverallE <- replace(jatos_students$diceIndLoadOverallE, 
                                             is.nan(jatos_students$diceIndLoadOverallE), NA)
### Pre loaded die correctness
jatos_hamburg$diceIndLoadPre <- rowMeans(jatos_hamburg[,c(16,19,28)])
jatos_hamburg$diceIndLoadPreE <- rowMeans(cbind(replace(jatos_hamburg[,16], jatos_hamburg[,49], NA),
                                                replace(jatos_hamburg[,19], jatos_hamburg[,49], NA),
                                                replace(jatos_hamburg[,28], jatos_hamburg[,50], NA)),
                                          na.rm=TRUE)
jatos_hamburg$diceIndLoadPreE <- replace(jatos_hamburg$diceIndLoadPreE,
                                         is.nan(jatos_hamburg$diceIndLoadPreE), NA)
jatos_prolific$diceIndLoadPre <- rowMeans(jatos_prolific[,c(16,19,28)])
jatos_prolific$diceIndLoadPreE <- rowMeans(cbind(replace(jatos_prolific[,16], jatos_prolific[,49], NA),
                                                replace(jatos_prolific[,19], jatos_prolific[,49], NA),
                                                replace(jatos_prolific[,28], jatos_prolific[,50], NA)),
                                          na.rm=TRUE)
jatos_prolific$diceIndLoadPreE <- replace(jatos_prolific$diceIndLoadPreE,
                                         is.nan(jatos_prolific$diceIndLoadPreE), NA)
jatos_students$diceIndLoadPre <- rowMeans(jatos_students[,c(16,19,28)])
jatos_students$diceIndLoadPreE <- rowMeans(cbind(replace(jatos_students[,16], jatos_students[,49], NA),
                                                replace(jatos_students[,19], jatos_students[,49], NA),
                                                replace(jatos_students[,28], jatos_students[,50], NA)),
                                          na.rm=TRUE)
jatos_students$diceIndLoadPreE <- replace(jatos_students$diceIndLoadPreE,
                                         is.nan(jatos_students$diceIndLoadPreE), NA)
### At loaded die correctness
jatos_hamburg$diceIndLoadAt <- rowMeans(jatos_hamburg[,c(22,31)])
jatos_hamburg$diceIndLoadAtE <- rowMeans(cbind(replace(jatos_hamburg[,22], jatos_hamburg[,49], NA),
                                              replace(jatos_hamburg[,31], jatos_hamburg[,50], NA)),
                                        na.rm=TRUE)
jatos_hamburg$diceIndLoadAtE <- replace(jatos_hamburg$diceIndLoadAtE,
                                        is.nan(jatos_hamburg$diceIndLoadAtE), NA)
jatos_prolific$diceIndLoadAt <- rowMeans(jatos_prolific[,c(22,31)])
jatos_prolific$diceIndLoadAtE <- rowMeans(cbind(replace(jatos_prolific[,22], jatos_prolific[,49], NA),
                                                replace(jatos_prolific[,31], jatos_prolific[,50], NA)),
                                          na.rm=TRUE)
jatos_prolific$diceIndLoadAtE <- replace(jatos_prolific$diceIndLoadAtE,
                                        is.nan(jatos_prolific$diceIndLoadAtE), NA)
jatos_students$diceIndLoadAt <- rowMeans(jatos_students[,c(22,31)])
jatos_students$diceIndLoadAtE <- rowMeans(cbind(replace(jatos_students[,22], jatos_students[,49], NA),
                                                replace(jatos_students[,31], jatos_students[,50], NA)),
                                          na.rm=TRUE)
jatos_students$diceIndLoadAtE <- replace(jatos_students$diceIndLoadAtE,
                                        is.nan(jatos_students$diceIndLoadAtE), NA)
### Post loaded die correctness
jatos_hamburg$diceIndLoadPost <- rowMeans(jatos_hamburg[,c(25,34,37)])
jatos_hamburg$diceIndLoadPostE <- rowMeans(cbind(replace(jatos_hamburg[,25], jatos_hamburg[,49], NA),
                                                replace(jatos_hamburg[,34], jatos_hamburg[,50], NA),
                                                replace(jatos_hamburg[,37], jatos_hamburg[,50], NA)),
                                          na.rm=TRUE)
jatos_hamburg$diceIndLoadPostE <- replace(jatos_hamburg$diceIndLoadPostE,
                                          is.nan(jatos_hamburg$diceIndLoadPostE), NA)
jatos_prolific$diceIndLoadPost <- rowMeans(jatos_prolific[,c(25,34,37)])
jatos_prolific$diceIndLoadPostE <- rowMeans(cbind(replace(jatos_prolific[,25], jatos_prolific[,49], NA),
                                                 replace(jatos_prolific[,34], jatos_prolific[,50], NA),
                                                 replace(jatos_prolific[,37], jatos_prolific[,50], NA)),
                                           na.rm=TRUE)
jatos_prolific$diceIndLoadPostE <- replace(jatos_prolific$diceIndLoadPostE,
                                          is.nan(jatos_prolific$diceIndLoadPostE), NA)
jatos_students$diceIndLoadPost <- rowMeans(jatos_students[,c(25,34,37)])
jatos_students$diceIndLoadPostE <- rowMeans(cbind(replace(jatos_students[,25], jatos_students[,49], NA),
                                                 replace(jatos_students[,34], jatos_students[,50], NA),
                                                 replace(jatos_students[,37], jatos_students[,50], NA)),
                                           na.rm=TRUE)
jatos_students$diceIndLoadPostE <- replace(jatos_students$diceIndLoadPostE,
                                           is.nan(jatos_students$diceIndLoadPostE), NA)
## For the loaded dice, was the participant correct in reported 'what' it was loaded on
### Returns 1 if correct (per trial), 0 if incorrect, NA if not reported loaded or excluded
jatos_hamburg$diceIndLoad1Cor <- as.numeric(jatos_hamburg$dice3LoadWhat)
jatos_hamburg$diceIndLoad1Cor <- replace(jatos_hamburg$diceIndLoad1Cor,
                                         jatos_hamburg$diceIndLoad1Cor!=4, 0)
jatos_hamburg$diceIndLoad1Cor <- replace(jatos_hamburg$diceIndLoad1Cor,
                                         jatos_hamburg$diceIndLoad1Cor==4, 1)
jatos_hamburg$diceIndLoad1CorE <- replace(jatos_hamburg$diceIndLoad1Cor, 
                                          jatos_hamburg$excludeDtDTrial1, NA)
jatos_hamburg$diceIndLoad2Cor <- as.numeric(jatos_hamburg$dice6LoadWhat)
jatos_hamburg$diceIndLoad2Cor <- replace(jatos_hamburg$diceIndLoad2Cor,
                                         jatos_hamburg$diceIndLoad2Cor!=3, 0)
jatos_hamburg$diceIndLoad2Cor <- replace(jatos_hamburg$diceIndLoad2Cor,
                                         jatos_hamburg$diceIndLoad2Cor==3, 1)
jatos_hamburg$diceIndLoad2CorE <- replace(jatos_hamburg$diceIndLoad2Cor, 
                                          jatos_hamburg$excludeDtDTrial2, NA)
jatos_prolific$diceIndLoad1Cor <- as.numeric(jatos_prolific$dice3LoadWhat)
jatos_prolific$diceIndLoad1Cor <- replace(jatos_prolific$diceIndLoad1Cor,
                                         jatos_prolific$diceIndLoad1Cor!=4, 0)
jatos_prolific$diceIndLoad1Cor <- replace(jatos_prolific$diceIndLoad1Cor,
                                         jatos_prolific$diceIndLoad1Cor==4, 1)
jatos_prolific$diceIndLoad1CorE <- replace(jatos_prolific$diceIndLoad1Cor, 
                                          jatos_prolific$excludeDtDTrial1, NA)
jatos_prolific$diceIndLoad2Cor <- as.numeric(jatos_prolific$dice6LoadWhat)
jatos_prolific$diceIndLoad2Cor <- replace(jatos_prolific$diceIndLoad2Cor,
                                         jatos_prolific$diceIndLoad2Cor!=3, 0)
jatos_prolific$diceIndLoad2Cor <- replace(jatos_prolific$diceIndLoad2Cor,
                                         jatos_prolific$diceIndLoad2Cor==3, 1)
jatos_prolific$diceIndLoad2CorE <- replace(jatos_prolific$diceIndLoad2Cor, 
                                          jatos_prolific$excludeDtDTrial2, NA)
jatos_students$diceIndLoad1Cor <- as.numeric(jatos_students$dice3LoadWhat)
jatos_students$diceIndLoad1Cor <- replace(jatos_students$diceIndLoad1Cor,
                                         jatos_students$diceIndLoad1Cor!=4, 0)
jatos_students$diceIndLoad1Cor <- replace(jatos_students$diceIndLoad1Cor,
                                         jatos_students$diceIndLoad1Cor==4, 1)
jatos_students$diceIndLoad1CorE <- replace(jatos_students$diceIndLoad1Cor, 
                                          jatos_students$excludeDtDTrial1, NA)
jatos_students$diceIndLoad2Cor <- as.numeric(jatos_students$dice6LoadWhat)
jatos_students$diceIndLoad2Cor <- replace(jatos_students$diceIndLoad2Cor,
                                         jatos_students$diceIndLoad2Cor!=3, 0)
jatos_students$diceIndLoad2Cor <- replace(jatos_students$diceIndLoad2Cor,
                                         jatos_students$diceIndLoad2Cor==3, 1)
jatos_students$diceIndLoad2CorE <- replace(jatos_students$diceIndLoad2Cor, 
                                          jatos_students$excludeDtDTrial2, NA)
## Was the participant correct at the end stage
### Variables already exists, diceTrial*EndCor, so only making the excluded variant
jatos_hamburg$diceTrial1EndCorE <- replace(jatos_hamburg$diceTrial1EndCor,
                                           jatos_hamburg$excludeDtDTrial1, NA)
jatos_hamburg$diceTrial2EndCorE <- replace(jatos_hamburg$diceTrial2EndCor,
                                           jatos_hamburg$excludeDtDTrial2, NA)
jatos_prolific$diceTrial1EndCorE <- replace(jatos_prolific$diceTrial1EndCor,
                                            jatos_prolific$excludeDtDTrial1, NA)
jatos_prolific$diceTrial2EndCorE <- replace(jatos_prolific$diceTrial2EndCor,
                                            jatos_prolific$excludeDtDTrial2, NA)
jatos_students$diceTrial1EndCorE <- replace(jatos_students$diceTrial1EndCor,
                                            jatos_students$excludeDtDTrial1, NA)
jatos_students$diceTrial2EndCorE <- replace(jatos_students$diceTrial2EndCor,
                                            jatos_students$excludeDtDTrial2, NA)
### Summary score - Mean trial 1 and 2
jatos_hamburg$diceEndCorOverall <- rowMeans(jatos_hamburg[,c(11,13)])
jatos_hamburg$diceEndCorOverallE <- rowMeans(jatos_hamburg[,c(68,69)], na.rm = TRUE)
jatos_prolific$diceEndCorOverall <- rowMeans(jatos_prolific[,c(11,13)])
jatos_prolific$diceEndCorOverallE <- rowMeans(jatos_prolific[,c(68,69)], na.rm = TRUE)
jatos_students$diceEndCorOverall <- rowMeans(jatos_students[,c(11,13)])
jatos_students$diceEndCorOverallE <- rowMeans(jatos_students[,c(68,69)], na.rm = TRUE)

# Variables for information sampled (DtD)
## DtD - Trial, pre, load, post trial and overall
## Trial-wise DtD
jatos_hamburg$diceDtDTrial1 <- rowSums(jatos_hamburg[,c(2,3,4,5)])
jatos_hamburg$diceDtDTrial2 <- rowSums(jatos_hamburg[,c(6,7,8,9)])
jatos_prolific$diceDtDTrial1 <- rowSums(jatos_prolific[,c(2,3,4,5)])
jatos_prolific$diceDtDTrial2 <- rowSums(jatos_prolific[,c(6,7,8,9)])
jatos_students$diceDtDTrial1 <- rowSums(jatos_students[,c(2,3,4,5)])
jatos_students$diceDtDTrial2 <- rowSums(jatos_students[,c(6,7,8,9)])
jatos_hamburg$diceDtDTrial1E <- jatos_hamburg$diceDtDTrial1
jatos_hamburg$diceDtDTrial1E <- replace(jatos_hamburg$diceDtDTrial1E, 
                                            jatos_hamburg$excludeDtDTrial1, NA)
jatos_hamburg$diceDtDTrial2E <- jatos_hamburg$diceDtDTrial2
jatos_hamburg$diceDtDTrial2E <- replace(jatos_hamburg$diceDtDTrial2E, 
                                            jatos_hamburg$excludeDtDTrial2, NA)
jatos_prolific$diceDtDTrial1E <- jatos_prolific$diceDtDTrial1
jatos_prolific$diceDtDTrial1E <- replace(jatos_prolific$diceDtDTrial1E, 
                                             jatos_prolific$excludeDtDTrial1, NA)
jatos_prolific$diceDtDTrial2E <- jatos_prolific$diceDtDTrial2
jatos_prolific$diceDtDTrial2E <- replace(jatos_prolific$diceDtDTrial2E, 
                                             jatos_prolific$excludeDtDTrial2, NA)
jatos_students$diceDtDTrial1E <- jatos_students$diceDtDTrial1
jatos_students$diceDtDTrial1E <- replace(jatos_students$diceDtDTrial1E, 
                                             jatos_students$excludeDtDTrial1, NA)
jatos_students$diceDtDTrial2E <- jatos_students$diceDtDTrial2
jatos_students$diceDtDTrial2E <- replace(jatos_students$diceDtDTrial2E, 
                                             jatos_students$excludeDtDTrial2, NA)
## Mean trial-wise DtD
### Use mean instead of sum, so that trial-wise exclusion is meaningful
jatos_hamburg$diceDtDOverall <- rowMeans(jatos_hamburg[,c(72,73)])
jatos_prolific$diceDtDOverall <- rowMeans(jatos_prolific[,c(72,73)])
jatos_students$diceDtDOverall <- rowMeans(jatos_students[,c(72,73)])
jatos_hamburg$diceDtDOverallE <- rowMeans(jatos_hamburg[,c(74,75)], na.rm = TRUE)
jatos_hamburg$diceDtDOverallE <- replace(jatos_hamburg$diceDtDOverallE, 
                                             is.nan(jatos_hamburg$diceDtDOverallE), NA)
jatos_prolific$diceDtDOverallE <- rowMeans(jatos_prolific[,c(74,75)], na.rm = TRUE)
jatos_prolific$diceDtDOverallE <- replace(jatos_prolific$diceDtDOverallE, 
                                              is.nan(jatos_prolific$diceDtDOverallE), NA)
jatos_students$diceDtDOverallE <- rowMeans(jatos_students[,c(74,75)], na.rm = TRUE)
jatos_students$diceDtDOverallE <- replace(jatos_students$diceDtDOverallE, 
                                              is.nan(jatos_students$diceDtDOverallE), NA)
## Mean pre loaded dice DtD
### Use mean instead of sum, so that trial-wise exclusion is meaningful
jatos_hamburg$diceDtDPre <- rowMeans(jatos_hamburg[,c(2,3,6)])
jatos_hamburg$diceDtDPreE <- rowMeans(cbind(replace(jatos_hamburg[,2], jatos_hamburg[,49], NA),
                                                 replace(jatos_hamburg[,3], jatos_hamburg[,49], NA),
                                                 replace(jatos_hamburg[,6], jatos_hamburg[,50], NA)),
                                           na.rm=TRUE)
jatos_hamburg$diceDtDPreE <- replace(jatos_hamburg$diceDtDPreE,
                                          is.nan(jatos_hamburg$diceDtDPreE), NA)
jatos_prolific$diceDtDPre <- rowMeans(jatos_prolific[,c(2,3,6)])
jatos_prolific$diceDtDPreE <- rowMeans(cbind(replace(jatos_prolific[,2], jatos_prolific[,49], NA),
                                                  replace(jatos_prolific[,3], jatos_prolific[,49], NA),
                                                  replace(jatos_prolific[,6], jatos_prolific[,50], NA)),
                                            na.rm=TRUE)
jatos_prolific$diceDtDPreE <- replace(jatos_prolific$diceDtDPreE,
                                           is.nan(jatos_prolific$diceDtDPreE), NA)
jatos_students$diceDtDPre <- rowMeans(jatos_students[,c(2,3,6)])
jatos_students$diceDtDPreE <- rowMeans(cbind(replace(jatos_students[,2], jatos_students[,49], NA),
                                                  replace(jatos_students[,3], jatos_students[,49], NA),
                                                  replace(jatos_students[,6], jatos_students[,50], NA)),
                                            na.rm=TRUE)
jatos_students$diceDtDPreE <- replace(jatos_students$diceDtDPreE,
                                           is.nan(jatos_students$diceDtDPreE), NA)
## Mean at loaded dice DtD
### Use mean instead of sum, so that trial-wise exclusion is meaningful
jatos_hamburg$diceDtDAt <- rowMeans(jatos_hamburg[,c(4,7)])
jatos_hamburg$diceDtDAtE <- rowMeans(cbind(replace(jatos_hamburg[,4], jatos_hamburg[,49], NA),
                                                 replace(jatos_hamburg[,7], jatos_hamburg[,50], NA)),
                                           na.rm=TRUE)
jatos_hamburg$diceDtDAtE <- replace(jatos_hamburg$diceDtDAtE,
                                          is.nan(jatos_hamburg$diceDtDAtE), NA)
jatos_prolific$diceDtDAt <- rowMeans(jatos_prolific[,c(4,7)])
jatos_prolific$diceDtDAtE <- rowMeans(cbind(replace(jatos_prolific[,4], jatos_prolific[,49], NA),
                                                  replace(jatos_prolific[,7], jatos_prolific[,50], NA)),
                                            na.rm=TRUE)
jatos_prolific$diceDtDAtE <- replace(jatos_prolific$diceDtDAtE,
                                           is.nan(jatos_prolific$diceDtDAtE), NA)
jatos_students$diceDtDAt <- rowMeans(jatos_students[,c(4,7)])
jatos_students$diceDtDAtE <- rowMeans(cbind(replace(jatos_students[,4], jatos_students[,49], NA),
                                                  replace(jatos_students[,7], jatos_students[,50], NA)),
                                            na.rm=TRUE)
jatos_students$diceDtDAtE <- replace(jatos_students$diceDtDAtE,
                                           is.nan(jatos_students$diceDtDAtE), NA)
## Mean post loaded dice DtD
### Use mean instead of sum, so that trial-wise exclusion is meaningful
jatos_hamburg$diceDtDPost <- rowMeans(jatos_hamburg[,c(5,8,9)])
jatos_hamburg$diceDtDPostE <- rowMeans(cbind(replace(jatos_hamburg[,5], jatos_hamburg[,49], NA),
                                                 replace(jatos_hamburg[,8], jatos_hamburg[,50], NA),
                                                 replace(jatos_hamburg[,9], jatos_hamburg[,50], NA)),
                                           na.rm=TRUE)
jatos_hamburg$diceDtDPostE <- replace(jatos_hamburg$diceDtDPostE,
                                          is.nan(jatos_hamburg$diceDtDPostE), NA)
jatos_prolific$diceDtDPost <- rowMeans(jatos_prolific[,c(5,8,9)])
jatos_prolific$diceDtDPostE <- rowMeans(cbind(replace(jatos_prolific[,5], jatos_prolific[,49], NA),
                                                  replace(jatos_prolific[,8], jatos_prolific[,50], NA),
                                                  replace(jatos_prolific[,9], jatos_prolific[,50], NA)),
                                            na.rm=TRUE)
jatos_prolific$diceDtDPostE <- replace(jatos_prolific$diceDtDPostE,
                                           is.nan(jatos_prolific$diceDtDPostE), NA)
jatos_students$diceDtDPost <- rowMeans(jatos_students[,c(5,8,9)])
jatos_students$diceDtDPostE <- rowMeans(cbind(replace(jatos_students[,5], jatos_students[,49], NA),
                                                  replace(jatos_students[,8], jatos_students[,50], NA),
                                                  replace(jatos_students[,9], jatos_students[,50], NA)),
                                            na.rm=TRUE)
jatos_students$diceDtDPostE <- replace(jatos_students$diceDtDPostE,
                                           is.nan(jatos_students$diceDtDPostE), NA)

# Variables for reported / subjective confidence
## Trial-wise mean confidence
jatos_hamburg$diceConfTrial1 <- rowMeans(jatos_hamburg[,c(17,20,23,26)])
jatos_hamburg$diceConfTrial1E <- replace(jatos_hamburg$diceConfTrial1,
                                         jatos_hamburg$excludeDtDTrial1, NA)
jatos_hamburg$diceConfTrial2 <- rowMeans(jatos_hamburg[,c(17,20,23,26)])
jatos_hamburg$diceConfTrial2E <- replace(jatos_hamburg$diceConfTrial2,
                                         jatos_hamburg$excludeDtDTrial2, NA)
jatos_prolific$diceConfTrial1 <- rowMeans(jatos_prolific[,c(17,20,23,26)])
jatos_prolific$diceConfTrial1E <- replace(jatos_prolific$diceConfTrial1,
                                         jatos_prolific$excludeDtDTrial1, NA)
jatos_prolific$diceConfTrial2 <- rowMeans(jatos_prolific[,c(17,20,23,26)])
jatos_prolific$diceConfTrial2E <- replace(jatos_prolific$diceConfTrial2,
                                         jatos_prolific$excludeDtDTrial2, NA)
jatos_students$diceConfTrial1 <- rowMeans(jatos_students[,c(17,20,23,26)])
jatos_students$diceConfTrial1E <- replace(jatos_students$diceConfTrial1,
                                         jatos_students$excludeDtDTrial1, NA)
jatos_students$diceConfTrial2 <- rowMeans(jatos_students[,c(17,20,23,26)])
jatos_students$diceConfTrial2E <- replace(jatos_students$diceConfTrial2,
                                         jatos_students$excludeDtDTrial2, NA)
## Overall mean confidence
jatos_hamburg$diceConfOverall <- rowMeans(jatos_hamburg[,c(84,86)])
jatos_hamburg$diceConfOverallE <- rowMeans(jatos_hamburg[,c(85,87)], na.rm = TRUE)
jatos_hamburg$diceConfOverallE <- replace(jatos_hamburg$diceConfOverallE, 
                                          is.nan(jatos_hamburg$diceConfOverallE), NA)
jatos_prolific$diceConfOverall <- rowMeans(jatos_prolific[,c(84,86)])
jatos_prolific$diceConfOverallE <- rowMeans(jatos_prolific[,c(85,87)], na.rm = TRUE)
jatos_prolific$diceConfOverallE <- replace(jatos_prolific$diceConfOverallE, 
                                          is.nan(jatos_prolific$diceConfOverallE), NA)
jatos_students$diceConfOverall <- rowMeans(jatos_students[,c(84,86)])
jatos_students$diceConfOverallE <- rowMeans(jatos_students[,c(85,87)], na.rm = TRUE)
jatos_students$diceConfOverallE <- replace(jatos_students$diceConfOverallE, 
                                          is.nan(jatos_students$diceConfOverallE), NA)
## Mean pre loaded dice confidence
jatos_hamburg$diceConfPre <- rowMeans(jatos_hamburg[,c(17,20,29)])
jatos_hamburg$diceConfPreE <- rowMeans(cbind(replace(jatos_hamburg[,17], jatos_hamburg[,49], NA),
                                             replace(jatos_hamburg[,20], jatos_hamburg[,49], NA),
                                             replace(jatos_hamburg[,29], jatos_hamburg[,50], NA)),
                                       na.rm=TRUE)
jatos_hamburg$diceConfPreE <- replace(jatos_hamburg$diceConfPreE, 
                                      is.nan(jatos_hamburg$diceConfPreE), NA)
jatos_prolific$diceConfPre <- rowMeans(jatos_prolific[,c(17,20,29)])
jatos_prolific$diceConfPreE <- rowMeans(cbind(replace(jatos_prolific[,17], jatos_prolific[,49], NA),
                                             replace(jatos_prolific[,20], jatos_prolific[,49], NA),
                                             replace(jatos_prolific[,29], jatos_prolific[,50], NA)),
                                       na.rm=TRUE)
jatos_prolific$diceConfPreE <- replace(jatos_prolific$diceConfPreE, 
                                      is.nan(jatos_prolific$diceConfPreE), NA)
jatos_students$diceConfPre <- rowMeans(jatos_students[,c(17,20,29)])
jatos_students$diceConfPreE <- rowMeans(cbind(replace(jatos_students[,17], jatos_students[,49], NA),
                                             replace(jatos_students[,20], jatos_students[,49], NA),
                                             replace(jatos_students[,29], jatos_students[,50], NA)),
                                       na.rm=TRUE)
jatos_students$diceConfPreE <- replace(jatos_students$diceConfPreE, 
                                      is.nan(jatos_students$diceConfPreE), NA)
## Mean at loaded dice confidence
jatos_hamburg$diceConfAt <- rowMeans(jatos_hamburg[,c(23,32)])
jatos_hamburg$diceConfAtE <- rowMeans(cbind(replace(jatos_hamburg[,23], jatos_hamburg[,49], NA),
                                            replace(jatos_hamburg[,32], jatos_hamburg[,50], NA)),
                                      na.rm=TRUE)
jatos_hamburg$diceConfAtE <- replace(jatos_hamburg$diceConfAtE,
                                     is.nan(jatos_hamburg$diceConfAtE), NA)
jatos_prolific$diceConfAt <- rowMeans(jatos_prolific[,c(23,32)])
jatos_prolific$diceConfAtE <- rowMeans(cbind(replace(jatos_prolific[,23], jatos_prolific[,49], NA),
                                            replace(jatos_prolific[,32], jatos_prolific[,50], NA)),
                                      na.rm=TRUE)
jatos_prolific$diceConfAtE <- replace(jatos_prolific$diceConfAtE,
                                     is.nan(jatos_prolific$diceConfAtE), NA)
jatos_students$diceConfAt <- rowMeans(jatos_students[,c(23,32)])
jatos_students$diceConfAtE <- rowMeans(cbind(replace(jatos_students[,23], jatos_students[,49], NA),
                                            replace(jatos_students[,32], jatos_students[,50], NA)),
                                      na.rm=TRUE)
jatos_students$diceConfAtE <- replace(jatos_students$diceConfAtE,
                                     is.nan(jatos_students$diceConfAtE), NA)
## Mean post loaded dice confidence
jatos_hamburg$diceConfPost <- rowMeans(jatos_hamburg[,c(26,35,38)])
jatos_hamburg$diceConfPostE <- rowMeans(cbind(replace(jatos_hamburg[,26], jatos_hamburg[,49], NA),
                                                 replace(jatos_hamburg[,35], jatos_hamburg[,50], NA),
                                                 replace(jatos_hamburg[,38], jatos_hamburg[,50], NA)),
                                           na.rm=TRUE)
jatos_hamburg$diceConfPostE <- replace(jatos_hamburg$diceConfPostE,
                                          is.nan(jatos_hamburg$diceConfPostE), NA)
jatos_prolific$diceConfPost <- rowMeans(jatos_prolific[,c(26,35,38)])
jatos_prolific$diceConfPostE <- rowMeans(cbind(replace(jatos_prolific[,26], jatos_prolific[,49], NA),
                                                  replace(jatos_prolific[,35], jatos_prolific[,50], NA),
                                                  replace(jatos_prolific[,38], jatos_prolific[,50], NA)),
                                            na.rm=TRUE)
jatos_prolific$diceConfPostE <- replace(jatos_prolific$diceConfPostE,
                                           is.nan(jatos_prolific$diceConfPostE), NA)
jatos_students$diceConfPost <- rowMeans(jatos_students[,c(26,35,38)])
jatos_students$diceConfPostE <- rowMeans(cbind(replace(jatos_students[,26], jatos_students[,49], NA),
                                                  replace(jatos_students[,35], jatos_students[,50], NA),
                                                  replace(jatos_students[,38], jatos_students[,50], NA)),
                                            na.rm=TRUE)
jatos_students$diceConfPostE <- replace(jatos_students$diceConfPostE,
                                           is.nan(jatos_students$diceConfPostE), NA)

# Update meta file to display number of trials and unique participants excluded in 'E'-variables
metaDiceTask <- rbind(metaDiceTask, c(sum(jatos_hamburg$excludeDtDTrial1),
                                      "Trial1 DtD exclusion", "Hamburg"))
metaDiceTask <- rbind(metaDiceTask, c(sum(jatos_hamburg$excludeDtDTrial2),
                                      "Trial2 DtD exclusion", "Hamburg"))
metaDiceTask <- rbind(metaDiceTask, c(sum(jatos_hamburg$excludeDtDOverall>0),
                                      "Participants with DtD exclusion", "Hamburg"))
metaDiceTask <- rbind(metaDiceTask, c(sum(jatos_hamburg$excludeDtDOverall==1),
                                      "Participants with full DtD exclusion", "Hamburg"))
metaDiceTask <- rbind(metaDiceTask, c(sum(jatos_prolific$excludeDtDTrial1),
                                      "Trial1 DtD exclusion", "Prolific_1&2"))
metaDiceTask <- rbind(metaDiceTask, c(sum(jatos_prolific$excludeDtDTrial2),
                                      "Trial2 DtD exclusion", "Prolific_1&2"))
metaDiceTask <- rbind(metaDiceTask, c(sum(jatos_prolific$excludeDtDOverall>0),
                                      "Participants with DtD exclusion", "Prolific_1&2"))
metaDiceTask <- rbind(metaDiceTask, c(sum(jatos_prolific$excludeDtDOverall==1),
                                      "Participants with full DtD exclusion", "Prolific_1&2"))
metaDiceTask <- rbind(metaDiceTask, c(sum(jatos_students[jatos_students$diceMetaStudyID=="210",49]),
                                      "Trial1 DtD exclusion", "Students_1"))
metaDiceTask <- rbind(metaDiceTask, c(sum(jatos_students[jatos_students$diceMetaStudyID=="210",50]),
                                      "Trial2 DtD exclusion", "Students_1"))
metaDiceTask <- rbind(metaDiceTask, c(sum(jatos_students[jatos_students$diceMetaStudyID=="210",51]>0),
                                      "Participants with DtD exclusion", "Students_1"))
metaDiceTask <- rbind(metaDiceTask, c(sum(jatos_students[jatos_students$diceMetaStudyID=="210",51]==1),
                                      "Participants with full DtD exclusion", "Students_1"))
metaDiceTask <- rbind(metaDiceTask, c(sum(jatos_students[jatos_students$diceMetaStudyID=="359",49]),
                                      "Trial1 DtD exclusion", "Students_2"))
metaDiceTask <- rbind(metaDiceTask, c(sum(jatos_students[jatos_students$diceMetaStudyID=="359",50]),
                                      "Trial2 DtD exclusion", "Students_2"))
metaDiceTask <- rbind(metaDiceTask, c(sum(jatos_students[jatos_students$diceMetaStudyID=="359",51]>0),
                                      "Participants with DtD exclusion", "Students_2"))
metaDiceTask <- rbind(metaDiceTask, c(sum(jatos_students[jatos_students$diceMetaStudyID=="359",51]==1),
                                      "Participants with full DtD exclusion", "Students_2"))

# 07 Output CSV-files for all data in 'processed' --------------------------------------------------

# Fix row & col names to match that of other tasks
#colnames(3x dfs)
row.names(metaDiceTask) <- NULL
colnames(metaDiceTask) <- c("N affected","Reason","Sample pool")

# Remove course-only participant and record in meta
metaCourse <- sum(row.names(jatos_students)=="2334")
metaDiceTask <- rbind(metaDiceTask, c(metaCourse, "Participants excluded for science",
                                      "Students_2"))
jatos_students <- jatos_students[row.names(jatos_students)!="2334",]

# Create summary-file

# Create full-data file

# Create meta file
write.csv(metaDiceTask, "data/processed/meta_dice-task.csv")
