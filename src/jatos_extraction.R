####################################################################################################
# Extracts, collects and summarises data from Dice-task / JATOS                                    #
# Input: Jatos raw data                                                                            #
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
diceTask <- NULL

# Set up meta file to capture data removal
metaDiceTask <- NULL

# 01 Load raw data ---------------------------------------------------------------------------------

jatFiles <- list.files("data/raw/jatos", pattern = "*.txt", recursive = TRUE)
jatPath <- paste("data/raw/jatos/", jatFiles, sep ="")

# 02 Extract and save cleaned raw data -------------------------------------------------------------

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
## Catching of limited throws if they were administered
### These differ in length (nrow) based on how many dice were thrown etc.

# Exctracting relevant data from each row
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
## Preconcived loadedness
diceTrial1Pre <- unlist(strsplit(unlist(strsplit(diceTrial1Pre, "value:"))[2], "\\}"))[1]
diceTrial2Pre <- unlist(strsplit(unlist(strsplit(diceTrial2Pre, "value:"))[2], "\\}"))[1]
## Trial end decision
diceTrial1End <- unlist(strsplit(unlist(strsplit(diceTrial1End, "value:"))[2], "\\}"))[1]
diceTrial2End <- unlist(strsplit(unlist(strsplit(diceTrial2End, "value:"))[2], "\\}"))[1]

# Stich together per participant
diceParticipant <- cbind(diceMetaStudyID, diceMetaPartID, diceDtD1, diceDtD2, diceDtD3, diceDtD4,
                         diceDtD5, diceDtD6, diceDtD7, diceDtD8, diceTrial1End, diceTrial2End,
                         diceTrial1Pre, diceTrial2Pre, dice1Load, dice1LoadCert, dice1LoadWhat,
                         dice2Load, dice2LoadCert, dice2LoadWhat, dice3Load, dice3LoadCert, 
                         dice4LoadWhat, dice5Load, dice5LoadCert, dice5LoadWhat, dice6Load,
                         dice6LoadCert, dice6LoadWhat, dice7Load, dice7LoadCert, dice7LoadWhat,
                         dice8Load, dice8LoadCert, dice8LoadWhat, dice1Col, dice2Col, dice3Col,
                         dice4Col, dice5Col, dice6Col, dice7Col, dice8Col)
diceParticipant <- as.data.frame(diceParticipant)
diceTask <- rbind(diceTask, diceParticipant)
}

# Make a variable for each experiment / jatos-file
filename <- unlist(strsplit(unlist(strsplit(jatFiles[x], "/"))[2], ".txt"))
assign(filename, diceTask)

# Save cleaned raw-data in 'processed'
write.csv(diceTask, paste("data/processed/", filename, "_full.csv", sep=""))

# Reset diceTask-variable
diceTask <- NULL          
}

#2Do: Change metafile and boxtask output names. Fetch limited trials.