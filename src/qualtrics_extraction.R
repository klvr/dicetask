####################################################################################################
# Extracts and summarises Qualtrics data (Prolific and Students)                                   #
# Input: Qualtrics temp data (from qualtrics_cleanup.R)                                            #
# Output: Csv-files containing extracted data (full), and summary-data                             #
# Kristoffer Klevjer - github.com/klvr - klevjer(a)gmail.com                                       #
####################################################################################################

# 00 Preparation -----------------------------------------------------------------------------------

# Clean up workspare
rm(list = ls())

# Source own functions
for (i in list.files("src/functions", full.names = TRUE)) {source(i)}

# 01 Load data -------------------------------------------------------------------------------------

# Load main data files
qualtrics_prolific <- read.csv("data/temp/qualtrics_prolific.csv")
qualtrics_students_1 <- read.csv("data/temp/qualtrics_students_1.csv")
qualtrics_students_2 <- read.csv("data/temp/qualtrics_students_2.csv")
qualtrics_students_3 <- read.csv("data/temp/qualtrics_students_3.csv")

# Load meta files

meta_prolific <- read.csv("data/processed/meta_prolific.csv")
meta_students <- read.csv("data/processed/meta_students.csv")

# 02 Extraction Prolific ---------------------------------------------------------------------------

# Extract Misc
prolific_misc <- qualtrics_prolific[,c(1,2,161:164)]

# Extract Condition / Sequence info
prolific_cond <- qualtrics_prolific[,c(1,165:178)]

# Extract RQ items
prolific_rq <- qualtrics_prolific[,c(1,seq(7, 57, 5),62,63,68,69,74)]

# Extract RQ times
timeItem1 <- c(seq(7, 57, 5),74)-4
timeItem2 <- c(seq(7, 57, 5),74)-3
timeItem3 <- c(seq(7, 57, 5),74)-2
timeItem4 <- c(seq(7, 57, 5),74)-1
timeItem5 <- c(62-c(1,2,3,4))
timeItem6 <- c(68-c(1,2,3,4))
timeItems <- sort(c(timeItem1, timeItem2, timeItem3, timeItem4, timeItem5, timeItem6))
prolific_rqTime <- qualtrics_prolific[,c(1, timeItems)]

# Extract RQ Debrief
prolific_rqDebrief <- qualtrics_prolific[,c(1,82,83)]

# Extract NfC
prolific_nfc <- qualtrics_prolific[,c(1,88:105)]

# Extract NfC times
prolific_nfcTime <- qualtrics_prolific[,c(1, 84:87)]

# Extract BNT items
prolific_bnt <- qualtrics_prolific[,c(1, 110, 115, 120, 125)]

# Extract BNT times
timeItem1 <- c(110-c(1,2,3,4))
timeItem2 <- c(115-c(1,2,3,4))
timeItem3 <- c(120-c(1,2,3,4))
timeItem4 <- c(125-c(1,2,3,4))
timeItems <- sort(c(timeItem1, timeItem2, timeItem3, timeItem4))
prolific_bntTime <- qualtrics_prolific[,c(1, timeItems)]

# Extract 5DCuriosity
prolific_fdc <- qualtrics_prolific[,c(1,151:160)]

# Extract 5DCuriosity times
prolific_fdcTime <- qualtrics_prolific[,c(1, 147:150)]

# 03 Extraction Students ---------------------------------------------------------------------------

# Extract Misc
students_misc <- qualtrics_students_1[,c(8, 2, 10, 9, 1)]

# Extract Condition / Sequence info
students_condA <- qualtrics_students_1[,c(8, 288:291)]
students_condB <- qualtrics_students_2[,c(292, 303, 304)]

# Extract RQ
students_rqA <- qualtrics_students_1[,c(8, 208, 232:241, 265)]
students_rqB <- qualtrics_students_2[,c(292, 197, 221:230, 254)]

# Extract RQ times
timeItem1A <- c(208,232,265)-4
timeItem2A <- c(208,232,265)-3
timeItem3A <- c(208,232,265)-2
timeItem4A <- c(208,232,265)-1
timeItem1B <- c(197,221,254)-4
timeItem2B <- c(197,221,254)-3
timeItem3B <- c(197,221,254)-2
timeItem4B <- c(197,221,254)-1
timeItemsA <- sort(c(timeItem1A, timeItem2A, timeItem3A, timeItem4A))
timeItemsB <- sort(c(timeItem1B, timeItem2B, timeItem3B, timeItem4B))
students_rqTimeA <- qualtrics_students_1[,c(8, timeItemsA)]
students_rqTimeB <- qualtrics_students_2[,c(292, timeItemsB)]

# Extract NfC
students_nfcA <- qualtrics_students_1[,c(8, 270:287)]
students_nfcB <- qualtrics_students_2[,c(292, 259:276)]

# Extract NfC times
students_nfcTimeA <- qualtrics_students_1[,c(8, 266:269)]
students_nfcTimeB <- qualtrics_students_2[,c(292, 255:258)]

# Extract Risk
students_risk <- qualtrics_students_1[,c(8, 11)]

# Extract Mood
students_mood <- qualtrics_students_1[,c(8, 7)]

# Extract NTLX & Debrief

# Extract CAPE
students_capeA <- qualtrics_students_1[,c(8, 189:203,213:227,246:260)]
students_capeB <- qualtrics_students_2[,c(292, 178:192, 202:216, 235:249)]

# Extract CAPE times
timeItem1A <- c(189,213,246)-4
timeItem2A <- c(189,213,246)-3
timeItem3A <- c(189,213,246)-2
timeItem4A <- c(189,213,246)-1
timeItem1B <- c(178,202,235)-4
timeItem2B <- c(178,202,235)-3
timeItem3B <- c(178,202,235)-2
timeItem4B <- c(178,202,235)-1
timeItemsA <- sort(c(timeItem1A, timeItem2A, timeItem3A, timeItem4A))
timeItemsB <- sort(c(timeItem1B, timeItem2B, timeItem3B, timeItem4B))
students_capeTimeA <- qualtrics_students_1[,c(8, timeItemsA)]
students_capeTimeB <- qualtrics_students_2[,c(292, timeItemsB)]

# Extract Beads

# Extract Beads time

# 04 Recoding Prolific -----------------------------------------------------------------------------

# Variable names and sequences
namesTime <- c("timeOnPage","timeFirstLast","timeLastSubmit","clicksAboveMin")
namesRQ <- c("rqRunning","rqSheep","rqName","rqNurses","rqSoup","rqTea","rqMedals","rqBlocks",
             "rqThog","rqMoney","rqHospital","rqKnight","rqKnightB","rqGas","rqGasB","rqLottary")
namesNTLX <- c("ntlxMental","ntlxPhysical","ntlxTempo","ntlxFrust","ntlxEffort","ntlxSucces",
               "ntlxSatis")
namesFamiliar <- c("seenAny", "seenNumber")
namesSelfRep <- c("nfcScore", "fiveDimExplo", "fiveDimSocial")
namesBNT <- c("bntChoir","bntDiceFive","bntMushroom","bntDiceSix")
namesWST <- paste(rep("WST", 10), seq(1,10,1), sep="")
namesMisc <- c("ID","Browser","Gender", "Age", "Edu", "scoreSC")

# Misc
## Recode Browser into 1: Problematic for Dice (Safari, Edge, mobile device), 0: No problem
prob1 <- grepl(prolific_misc[,2], pattern = "Edge")
prob2 <- grepl(prolific_misc[,2], pattern = "Safari")
prob3 <- grepl(prolific_misc[,2], pattern = "iP")
prolific_misc[,2] <- as.numeric(((prob1+prob2+prob3) > 0))
## Recode gender
prolific_misc[,3] <- recodeGender(prolific_misc[,3])
## Recode education (from 0, not completed high school, to 4, completed PhD)
prolific_misc[,5] <- replace(prolific_misc[,5],prolific_misc[,5]=="not completed Highschool",0)
prolific_misc[,5] <- replace(prolific_misc[,5],prolific_misc[,5]=="completed Highschool",1)
prolific_misc[,5] <- replace(prolific_misc[,5],prolific_misc[,5]=="Bachelor degree or equivalent",2)
prolific_misc[,5] <- replace(prolific_misc[,5],prolific_misc[,5]=="Master degree or equivalent",3)
prolific_misc[,5] <- replace(prolific_misc[,5],prolific_misc[,5]=="PhD or equivalent",4)
## Variable names
colnames(prolific_misc) <- namesMisc

# RQ items
## Recode into correct (1), incorrect (0) and heuristic (-1; if applicable)
prolific_rq[,2] <- recodeSingle(prolific_rq[,2], c = "40")
prolific_rq[,3] <- recodeSingle(prolific_rq[,3], c = "8", h = "7")
prolific_rq[,4] <- recodeSingle(prolific_rq[,4], c = "Emily", h = "June")
prolific_rq[,5] <- recodeSingle(prolific_rq[,5], c = "2", h = "200")
prolific_rq[,6] <- replace(prolific_rq[,6], prolific_rq[,6]=="225.00", "2.25") #Some forgot the dot
prolific_rq[,6] <- recodeSingle(prolific_rq[,6], c = "2.25")
prolific_rq[,7] <- recodeSingle(prolific_rq[,7], c = "5", h = "3")
prolific_rq[,8] <- recodeSingle(prolific_rq[,8], c = "15", h = "20")
prolific_rq[,9] <- recodeSingle(prolific_rq[,9], c = "Yes")
prolific_rq[,10] <- recodeSingle(prolific_rq[,10], c = "Yes")
prolific_rq[,11] <- recodeSingle(prolific_rq[,11], c = "Less than 1%")
prolific_rq[,12] <- recodeSingle(prolific_rq[,12], c = "The smaller hospital")
prolific_rq[,13] <- recodeSingle(prolific_rq[,13], c = "A knave")
prolific_rq[,14] <- recodeSingle(prolific_rq[,14], c = "A knight")
prolific_rq[,15] <- recodeSingle(prolific_rq[,15], c = "Turn over card D")
prolific_rq[,15] <- replace(prolific_rq[,15], is.na(prolific_rq[,15]), 0) #No response (incorr) => 0
prolific_rq[,16] <- recodeSingle(prolific_rq[,16], c = "")
prolific_rq[,17] <- recodeSingle(prolific_rq[,17], c = "The games are equal")
## Knight and knave (col 13 & 14) and Gas (col 15&16) is only correct if both columns are correct
prolific_rq[,13] <- replace(prolific_rq[,13], (prolific_rq[,13]+prolific_rq[,14])>1, 9)
prolific_rq[,13] <- replace(prolific_rq[,13], (prolific_rq[,13]+prolific_rq[,14])<8, 0)
prolific_rq[,13] <- replace(prolific_rq[,13], (prolific_rq[,13]+prolific_rq[,14])>8, 1)
prolific_rq[,15] <- replace(prolific_rq[,15], (prolific_rq[,15]+prolific_rq[,16])>1, 9)
prolific_rq[,15] <- replace(prolific_rq[,15], (prolific_rq[,15]+prolific_rq[,16])<8, 0)
prolific_rq[,15] <- replace(prolific_rq[,15], (prolific_rq[,15]+prolific_rq[,16])>8, 1)
## Variable names
colnames(prolific_rq) <- c(namesMisc[1], namesRQ)
## Remove unnecessary secound items for knight and knave, and gas
prolific_rq <- prolific_rq[,-c(14,16)]

# RQ times
## Recode times into overall time (OT), first action to submit (FS), last action to submit (LS),
## and clicks above minimum (CM)
timingAll <- NULL
for (i in seq(2,54,4)) {
timingItem <- recodeTime(prolific_rqTime[i:(i+3)])
timingAll <- cbind(timingAll, timingItem)
}
prolific_rqTime <- as.data.frame(cbind(prolific_rqTime[,1], timingAll))
## Variable names
colnames(prolific_rqTime) <- c(namesMisc[1], paste(rep(namesRQ[-c(13,15)], each=4), 
                              rep(c("TimeOT", "TimeFS", "TimeLS", "TimeCM")), sep=""))

# RQ debrief
## Recode seen before into yes (1), and no (0)
prolific_rqDebrief[,2] <- recodeSingle(prolific_rqDebrief[,2], c = "Yes")
## Recode into none (0), some (1), many (2)
prolific_rqDebrief[,3] <- replace(prolific_rqDebrief[,3], prolific_rqDebrief[,3]=="", 0)
prolific_rqDebrief[,3] <- replace(prolific_rqDebrief[,3], prolific_rqDebrief[,3]==
                          "1-3 tasks were familiar", 1)
prolific_rqDebrief[,3] <- replace(prolific_rqDebrief[,3], prolific_rqDebrief[,3]==
                          "4-7 tasks were familiar", 2)
## Variable names
colnames(prolific_rqDebrief) <- c("ID", "rqSeen","rqSeenN")

# NfC
## Calculate summary score
prolific_nfc[,2] <- recodeNFC(prolific_nfc[,-1])
## Remove individual items
prolific_nfc <- prolific_nfc[,1:2]
## Variable names
colnames(prolific_nfc) <- c(namesMisc[1], namesSelfRep[1])

# NfC times
## Recode times into overall time (OT), first action to submit (FS), last action to submit (LS),
## and clicks above minimum (CM)
prolific_nfcTime[,-1] <- recodeTime(prolific_nfcTime[,-1])
## Variable names
colnames(prolific_nfcTime) <- c(namesMisc[1], "nfcTimeOT", "nfcTimeFL", "nfcTimeLS", "nfcTimeCM")

# BNT items
## Recode into correct (1) or incorrect (0)
prolific_bnt[,2] <- recodeSingle(prolific_bnt[,2], c = "25%")
prolific_bnt[,3] <- recodeSingle(prolific_bnt[,3], c = "30 out of 50 throws")
prolific_bnt[,4] <- recodeSingle(prolific_bnt[,4], c = "50%")
prolific_bnt[,5] <- recodeSingle(prolific_bnt[,5], c = "20 out of 70 throws")
## Variable names
colnames(prolific_bnt) <- c(namesMisc[1], namesBNT)

# BNT times
## Recode times into overall time (OT), first action to submit (FS), last action to submit (LS),
## and clicks above minimum (CM)
timingAll <- NULL
for (i in seq(2,14,4)) {
  timingItem <- recodeTime(prolific_bntTime[i:(i+3)])
  timingAll <- cbind(timingAll, timingItem)
}
prolific_bntTime <- as.data.frame(cbind(prolific_bntTime[,1], timingAll))
## Variable names
colnames(prolific_bntTime) <- c(namesMisc[1], paste(rep(namesBNT, each=4), 
                              rep(c("TimeOT", "TimeFS", "TimeLS", "TimeCM")), sep=""))

# 5DCuriosity
## Calculate summary score for each subscale (explo and social)
for (i in 2:ncol(prolific_fdc)) {
prolific_fdc[,i] <- replace(prolific_fdc[,i], prolific_fdc[,i]=="Completely describes me.", 7)
prolific_fdc[,i] <- replace(prolific_fdc[,i], prolific_fdc[,i]=="Does not describe me at all.", 1)
prolific_fdc[,i] <- as.numeric(prolific_fdc[,i])
}
prolific_fdc[,2] <- rowSums(prolific_fdc[,2:6])
prolific_fdc[,3] <- rowSums(prolific_fdc[,7:11])
## Remove individual items
prolific_fdc <- prolific_fdc[,1:3]
## Variable names
colnames(prolific_fdc) <- c(namesMisc[1], namesSelfRep[-1])

# 5DCuriosity times
## Recode times into overall time (OT), first action to submit (FS), last action to submit (LS),
## and clicks above minimum (CM)
prolific_fdcTime[,-1] <- recodeTime(prolific_fdcTime[,-1])
## Variable names
colnames(prolific_fdcTime) <- c(namesMisc[1], "fdcTimeOT", "fdcTimeFL", "fdcTimeLS", "fdcTimeCM")

# 05 Recoding Students -----------------------------------------------------------------------------
# 06 Summary variable creation Prolific ------------------------------------------------------------

# Summary variables
## RQ
rqScore <- rowSums(prolific_rq[,-1]==1) # Overall score
rqHeurResp <- rowSums(prolific_rq[,-1]==-1) # Number of heuristic responses
prolific_rq <- cbind(prolific_rq, rqScore, rqHeurResp)
## RQ times
allitems <- seq(2,54,4) # First time variable for each item
heur <- c(6, 10, 14, 22, 26) # First time variable for each heuristic item
nonh <- c(2, 18, 30, 34, 38, 42, 46, 50, 54) # First time variable for each non-heuristic item
for (i in 2:ncol(prolific_rqTime)) {prolific_rqTime[,i] <- as.numeric(prolific_rqTime[,i])}
rqTimeOTOverall <- rowSums(prolific_rqTime[,allitems])
rqTimeFLOverall <- rowSums(prolific_rqTime[,allitems+1])
rqTimeLSOverall <- rowSums(prolific_rqTime[,allitems+2])
rqTimeCMOverall <- rowSums(prolific_rqTime[,allitems+3])
rqTimeOTHeur <- rowSums(prolific_rqTime[,heur])
rqTimeFLHeur <- rowSums(prolific_rqTime[,heur+1])
rqTimeLSHeur <- rowSums(prolific_rqTime[,heur+2])
rqTimeCMHeur <- rowSums(prolific_rqTime[,heur+3])
rqTimeOTNonh <- rowSums(prolific_rqTime[,nonh])
rqTimeFLNonh <- rowSums(prolific_rqTime[,nonh+1])
rqTimeLSNonh <- rowSums(prolific_rqTime[,nonh+2])
rqTimeCMNonh <- rowSums(prolific_rqTime[,nonh+3])
prolific_rqTime <- cbind(prolific_rqTime, rqTimeOTOverall, rqTimeFLOverall, rqTimeLSOverall,
                         rqTimeCMOverall, rqTimeOTHeur, rqTimeFLHeur, rqTimeLSHeur, rqTimeCMHeur,
                         rqTimeOTNonh, rqTimeFLNonh, rqTimeLSNonh, rqTimeCMNonh)
## BNT
bntScore <- rowSums(prolific_bnt[,-1])
prolific_bnt <- cbind(prolific_bnt, bntScore)

# BNT Times
items <- seq(2,14,4) # First time variable for each item
for (i in 2:ncol(prolific_bntTime)) {prolific_bntTime[,i] <- as.numeric(prolific_bntTime[,i])}
bntTimeOTOverall <- rowSums(prolific_bntTime[,items])
bntTimeFLOverall <- rowSums(prolific_bntTime[,items+1])
bntTimeLSOverall <- rowSums(prolific_bntTime[,items+2])
bntTimeCMOverall <- rowSums(prolific_bntTime[,items+3])
prolific_bntTime <- cbind(prolific_bntTime, bntTimeOTOverall, bntTimeFLOverall, bntTimeLSOverall,
                          bntTimeCMOverall)

# 07 Summary variable creation Students ------------------------------------------------------------
# 08 Merging and output Prolific -------------------------------------------------------------------

# Simplified summary file
qualtrics_prolific_summary <- cbind(prolific_misc, prolific_rq[,16:17], prolific_rqTime[,58:69], 
                              prolific_rqDebrief[,-1], prolific_nfc[,-1], prolific_nfcTime[,-1],
                              prolific_bnt[,6], prolific_bntTime[,18:21], prolific_fdc[,-1], 
                              prolific_fdcTime[,-1])
# Full data
qualtrics_prolific <- cbind(prolific_misc, prolific_rq[,-1], prolific_rqTime[,-1], 
                            prolific_rqDebrief[,-1], prolific_nfc[,-1], prolific_nfcTime[,-1],
                            prolific_bnt[,-1], prolific_bntTime[,-1], prolific_fdc[,-1], 
                            prolific_fdcTime[,-1])

# Write to CSV
write.csv(qualtrics_prolific, "data/processed/qualtrics_prolific.csv")
write.csv(qualtrics_prolific_summary, "data/processed/qualtrics_prolific_summary.csv")

# 09 Merging and output Students -------------------------------------------------------------------