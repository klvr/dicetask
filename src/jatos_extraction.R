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
                         dice3Load, dice3LoadCert, dice4LoadWhat, dice5Load, dice5LoadCert, 
                         dice5LoadWhat, dice6Load, dice6LoadCert, dice6LoadWhat, dice7Load, 
                         dice7LoadCert, dice7LoadWhat, dice8Load, dice8LoadCert, dice8LoadWhat, 
                         dice1Col, dice2Col, dice3Col, dice4Col, dice5Col, dice6Col, dice7Col, 
                         dice8Col)
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

# 06 Variable creation -----------------------------------------------------------------------------

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

#2Do: Fetch limited trials. Make variables into numeric
