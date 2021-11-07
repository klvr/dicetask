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

meta_prolific <- read.csv("data/temp/meta_prolific.csv")
meta_students <- read.csv("data/temp/meta_students.csv")

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

# Extract NTLX
prolific_rqNTLX <- qualtrics_prolific[,c(1, 75:81)]

# 03 Extraction Students ---------------------------------------------------------------------------

# Extract Misc
students_miscA <- qualtrics_students_1[,c(8, 2, 10, 9, 1)]
students_miscB <- qualtrics_students_2[,c(292, 297, 302)]

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

# Extract NTLX & Debrief Beads
students_beadsNTLXA <- qualtrics_students_1[,c(8, 174, 175, 176, 179, 178, 177)] #Match Prolific
students_beadsNTLXB <- qualtrics_students_2[,c(292, 163, 164, 165, 168, 167, 166)] #Match Prolific
students_beadsDiffA <- qualtrics_students_1[,c(8, 184)]
students_beadsDiffB <- qualtrics_students_2[,c(292, 173)]

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
## Split over two different response types, and either before or after dice
## Condition info save in students_cond
items1AA <- seq(20,83,7)
items2AA <- seq(20,83,7)+1
items3AA <- seq(20,83,7)+2
items1BA <- seq(9,72,7)
items2BA <- seq(9,72,7)+1
items3BA <- seq(9,72,7)+2
items1AB <- seq(94,169,8)
items2AB <- seq(94,169,8)+1
items3AB <- seq(94,169,8)+2
items4AB <- seq(94,169,8)+3
items1BB <- seq(83,158,8)
items2BB <- seq(83,158,8)+1
items3BB <- seq(83,158,8)+2
items4BB <- seq(83,158,8)+3
itemsAA <- sort(c(items1AA, items2AA, items3AA))
itemsBA <- sort(c(items1BA, items2BA, items3BA))
itemsAB <- sort(c(items1AB, items2AB, items3AB, items4AB))
itemsBB <- sort(c(items1BB, items2BB, items3BB, items4BB))
students_beadsAA <- qualtrics_students_1[,c(8, itemsAA)]
students_beadsBA <- qualtrics_students_2[,c(292, itemsBA)]
students_beadsAB <- qualtrics_students_1[,c(8, itemsAB)]
students_beadsBB <- qualtrics_students_2[,c(292, itemsBB)]

# Extract Beads time
items1AA <- seq(20,83,7)-4
items2AA <- seq(20,83,7)-3
items3AA <- seq(20,83,7)-2
items4AA <- seq(20,83,7)-1
items1BA <- seq(9,72,7)-4
items2BA <- seq(9,72,7)-3
items3BA <- seq(9,72,7)-2
items4BA <- seq(9,72,7)-1
items1AB <- seq(94,169,8)-4
items2AB <- seq(94,169,8)-3
items3AB <- seq(94,169,8)-2
items4AB <- seq(94,169,8)-1
items1BB <- seq(83,158,8)-4
items2BB <- seq(83,158,8)-3
items3BB <- seq(83,158,8)-2
items4BB <- seq(83,158,8)-1
itemsAA <- sort(c(items1AA, items2AA, items3AA, items4AA))
itemsBA <- sort(c(items1BA, items2BA, items3BA, items4BA))
itemsAB <- sort(c(items1AB, items2AB, items3AB, items4AB))
itemsBB <- sort(c(items1BB, items2BB, items3BB, items4BB))
students_beadsTimeAA <- qualtrics_students_1[,c(8, itemsAA)]
students_beadsTimeBA <- qualtrics_students_2[,c(292, itemsBA)]
students_beadsTimeAB <- qualtrics_students_1[,c(8, itemsAB)]
students_beadsTimeBB <- qualtrics_students_2[,c(292, itemsBB)]

# Extract NTLX & Debrief Dice
students_diceNTLX <- qualtrics_students_2[,c(292, 281, 282, 283, 286, 285, 284)]
students_diceDiff <- qualtrics_students_2[,c(292, 291)]

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

# NTLX RQ
colnames(prolific_rqNTLX) <- c(namesMisc[1], paste("rq", namesNTLX, sep=""))

# 05 Recoding Students -----------------------------------------------------------------------------

# Variable names and sequences
namesTime <- c("timeOnPage","timeFirstLast","timeLastSubmit","clicksAboveMin")
namesRQ <- c("rqKnight","rqProbMatch","rqHospital")
namesNTLX <- c("ntlxMental","ntlxPhysical","ntlxTempo","ntlxFrust","ntlxEffort","ntlxPerf")
namesSelfRep <- c("nfcScore", "capeP", "capeN", "capeD", "capeC", "mood", "risk", "Diff")
namesMisc <- c("ID","Browser","Gender", "Age", "Lang")
namesBeadsA <- c("beadsProbMin", "beadsProbMaj", "beadsChoice")
namesBeadsB <- c("beadsGuess", "beadsProbMin", "beadsProbMaj", "beadsChoice")

# Misc
## Recode Browser into 1: Problematic for Dice (Safari, Edge, mobile device), 0: No problem
prob1 <- grepl(students_miscA[,2], pattern = "Edge")
prob2 <- grepl(students_miscA[,2], pattern = "Safari")
prob3 <- grepl(students_miscA[,2], pattern = "iP")
students_miscA[,2] <- as.numeric(((prob1+prob2+prob3) > 0))
## Recode gender
students_miscA[,3] <- recodeGender(students_miscA[,3])
## Recode Fish/condition catch
students_miscB[,2] <- recodeSingle(students_miscB[,2], c = "Yes") #1: Played before, 0: Not
## Variable names
colnames(students_miscA) <- namesMisc
colnames(students_miscB) <- c(namesMisc[1], "playedB", "nFish")

# RQ items
## Recode into correct (1) and incorrect (0)
students_rqA[,2] <- recodeSingle(students_rqA[,2], c = "A knave")
students_rqB[,2] <- recodeSingle(students_rqB[,2], c = "A knave")
students_rqA[,3] <- recodeProbabilityMatching(students_rqA[,3:12], hc = TRUE)
students_rqB[,3] <- recodeProbabilityMatching(students_rqB[,3:12], hc = TRUE)
students_rqA[,13] <- recodeSingle(students_rqA[,13], c = "The smaller hospital")
students_rqB[,13] <- recodeSingle(students_rqB[,13], c = "The smaller hospital")
## Remove leftover PM items
students_rqA <- students_rqA[,-c(4:12)]
students_rqB <- students_rqB[,-c(4:12)]
## Variable names
colnames(students_rqA) <- c(namesMisc[1], namesRQ)
colnames(students_rqB) <- c(namesMisc[1], namesRQ)

# RQ times
## Recode times into overall time (OT), first action to submit (FS), last action to submit (LS),
## and clicks above minimum (CM)
timingAll <- NULL
for (i in seq(2,10,4)) {
  timingItem <- recodeTime(students_rqTimeA[i:(i+3)])
  timingAll <- cbind(timingAll, timingItem)
}
students_rqTimeA <- as.data.frame(cbind(students_rqTimeA[,1], timingAll))
timingAll <- NULL
for (i in seq(2,10,4)) {
  timingItem <- recodeTime(students_rqTimeB[i:(i+3)])
  timingAll <- cbind(timingAll, timingItem)
}
students_rqTimeB <- as.data.frame(cbind(students_rqTimeB[,1], timingAll))
## Variable names
colnames(students_rqTimeA) <- c(namesMisc[1], paste(rep(namesRQ, each=4), 
                              rep(c("TimeOT", "TimeFS", "TimeLS", "TimeCM")), sep=""))
colnames(students_rqTimeB) <- c(namesMisc[1], paste(rep(namesRQ, each=4), 
                              rep(c("TimeOT", "TimeFS", "TimeLS", "TimeCM")), sep=""))

# NfC
## Calculate summary score
students_nfcA[,2] <- recodeNFC(students_nfcA[,-1])
students_nfcB[,2] <- recodeNFC(students_nfcB[,-1])
## Remove individual items
students_nfcA <- students_nfcA[,1:2]
students_nfcB <- students_nfcB[,1:2]
## Variable names
colnames(students_nfcA) <- c(namesMisc[1], namesSelfRep[1])
colnames(students_nfcB) <- c(namesMisc[1], namesSelfRep[1])

# NfC times
## Recode times into overall time (OT), first action to submit (FS), last action to submit (LS),
## and clicks above minimum (CM)
students_nfcTimeA[,-1] <- recodeTime(students_nfcTimeA[,-1])
students_nfcTimeB[,-1] <- recodeTime(students_nfcTimeB[,-1])
## Variable names
colnames(students_nfcTimeA) <- c(namesMisc[1], "nfcTimeOT", "nfcTimeFL", "nfcTimeLS", "nfcTimeCM")
colnames(students_nfcTimeB) <- c(namesMisc[1], "nfcTimeOT", "nfcTimeFL", "nfcTimeLS", "nfcTimeCM")

# Risk
## Variable names
colnames(students_risk) <- c(namesMisc[1], namesSelfRep[7])

# Mood
## Variable names
colnames(students_mood) <- c(namesMisc[1], namesSelfRep[6])

# NTLX Beads & Dice
## Variable names
colnames(students_beadsNTLXA) <- c(namesMisc[1], paste("beads", namesNTLX, sep=""))
colnames(students_beadsNTLXB) <- c(namesMisc[1], paste("beads", namesNTLX, sep=""))
colnames(students_diceNTLX) <- c(namesMisc[1], paste("dice", namesNTLX, sep=""))

# Diff Beads & Dice
## Recode answers into 0: Extremely easy, to, 6: Extremely difficult
students_beadsDiffA <- replace(students_beadsDiffA, students_beadsDiffA=="Extremely easy", 0)
students_beadsDiffA <- replace(students_beadsDiffA, students_beadsDiffA=="Moderately easy", 1)
students_beadsDiffA <- replace(students_beadsDiffA, students_beadsDiffA=="Slightly easy", 2)
students_beadsDiffA <- replace(students_beadsDiffA, 
                               students_beadsDiffA=="Neither easy nor difficult", 3)
students_beadsDiffA <- replace(students_beadsDiffA, students_beadsDiffA=="Slightly difficult", 4)
students_beadsDiffA <- replace(students_beadsDiffA, students_beadsDiffA=="Moderately difficult", 5)
students_beadsDiffA <- replace(students_beadsDiffA, students_beadsDiffA=="Extremely difficult", 6)
students_beadsDiffB <- replace(students_beadsDiffB, students_beadsDiffB=="Extremely easy", 0)
students_beadsDiffB <- replace(students_beadsDiffB, students_beadsDiffB=="Moderately easy", 1)
students_beadsDiffB <- replace(students_beadsDiffB, students_beadsDiffB=="Slightly easy", 2)
students_beadsDiffB <- replace(students_beadsDiffB, 
                               students_beadsDiffB=="Neither easy nor difficult", 3)
students_beadsDiffB <- replace(students_beadsDiffB, students_beadsDiffB=="Slightly difficult", 4)
students_beadsDiffB <- replace(students_beadsDiffB, students_beadsDiffB=="Moderately difficult", 5)
students_beadsDiffB <- replace(students_beadsDiffB, students_beadsDiffB=="Extremely difficult", 6)
students_diceDiff <- replace(students_diceDiff, students_diceDiff=="Extremely easy", 0)
students_diceDiff <- replace(students_diceDiff, students_diceDiff=="Moderately easy", 1)
students_diceDiff <- replace(students_diceDiff, students_diceDiff=="Slightly easy", 2)
students_diceDiff <- replace(students_diceDiff, students_diceDiff=="Neither easy nor difficult", 3)
students_diceDiff <- replace(students_diceDiff, students_diceDiff=="Slightly difficult", 4)
students_diceDiff <- replace(students_diceDiff, students_diceDiff=="Moderately difficult", 5)
students_diceDiff <- replace(students_diceDiff, students_diceDiff=="Extremely difficult", 6)
## Variable names
colnames(students_beadsDiffA) <- c(namesMisc[1], paste("beads",namesSelfRep[8], "A", sep=""))
colnames(students_beadsDiffB) <- c(namesMisc[1], paste("beads",namesSelfRep[8], "B", sep=""))
colnames(students_diceDiff) <- c(namesMisc[1], paste("dice", namesSelfRep[8], sep=""))

# CAPE
## Recode answers into 1: Never, 4: Nearly always # To match others using CAPE (so not 0 index)
## Create summary variables for P, N and D sub-scales, and control items
students_capeA[,2:5] <- recodeCAPE(students_capeA[2:46])
students_capeB[,2:5] <- recodeCAPE(students_capeB[2:46])
## Remove leftover CAPE items
students_capeA <- students_capeA[,1:5]
students_capeB <- students_capeB[,1:5]
## Variable names
colnames(students_capeA) <- c(namesMisc[1], namesSelfRep[2:5])
colnames(students_capeB) <- c(namesMisc[1], namesSelfRep[2:5])

# CAPE times
timingAll <- NULL
for (i in seq(2,10,4)) {
  timingItem <- recodeTime(students_capeTimeA[i:(i+3)])
  timingAll <- cbind(timingAll, timingItem)
}
students_capeTimeA <- as.data.frame(cbind(students_capeTimeA[,1], timingAll))
timingAll <- NULL
for (i in seq(2,10,4)) {
  timingItem <- recodeTime(students_capeTimeB[i:(i+3)])
  timingAll <- cbind(timingAll, timingItem)
}
students_capeTimeB <- as.data.frame(cbind(students_capeTimeB[,1], timingAll))
## Variable names
colnames(students_capeTimeA) <- c(namesMisc[1], paste(rep(c("capeBlock1", "capeBlock2", 
                                "capeBlock3"), each = 4),rep(c("TimeOT", "TimeFS", "TimeLS",
                                "TimeCM")), sep=""))
colnames(students_capeTimeB) <- c(namesMisc[1], paste(rep(c("capeBlock1", "capeBlock2",
                                "capeBlock3"), each = 4),rep(c("TimeOT", "TimeFS", "TimeLS",
                                "TimeCM")), sep=""))

# Beads
## Recode into guess/choice pond B (corr): 1, guess/choice pond A (incorr): -1, and no decision: 0
for (i in 2:ncol(students_beadsAA)){
                                  students_beadsAA[,i] <- replace(students_beadsAA[,i], 
                                  students_beadsAA[,i] == "Yes, I chose pond B", 1)}
for (i in 2:ncol(students_beadsAA)){
                                  students_beadsAA[,i] <- replace(students_beadsAA[,i], 
                                  students_beadsAA[,i] == "Yes, I chose pond A", -1)}
for (i in 2:ncol(students_beadsAA)){
                                  students_beadsAA[,i] <- replace(students_beadsAA[,i], 
                                  students_beadsAA[,i] == "No, I need to see more fish", 0)}
for (i in 2:ncol(students_beadsBA)){
                                  students_beadsBA[,i] <- replace(students_beadsBA[,i], 
                                  students_beadsBA[,i] == "Yes, I chose pond B", 1)}
for (i in 2:ncol(students_beadsBA)){
                                  students_beadsBA[,i] <- replace(students_beadsBA[,i], 
                                  students_beadsBA[,i] == "Yes, I chose pond A", -1)}
for (i in 2:ncol(students_beadsBA)){
                                  students_beadsBA[,i] <- replace(students_beadsBA[,i], 
                                  students_beadsBA[,i] == "No, I need to see more fish", 0)}
for (i in 2:ncol(students_beadsAB)){
                                  students_beadsAB[,i] <- replace(students_beadsAB[,i], 
                                  students_beadsAB[,i] == "Yes, I chose pond B", 1)}
for (i in 2:ncol(students_beadsAB)){
                                  students_beadsAB[,i] <- replace(students_beadsAB[,i], 
                                  students_beadsAB[,i] == "Yes, I chose pond A", -1)}
for (i in 2:ncol(students_beadsAB)){
                                  students_beadsAB[,i] <- replace(students_beadsAB[,i], 
                                  students_beadsAB[,i] == "No, I need to see more fish", 0)}
for (i in 2:ncol(students_beadsAB)){
                                  students_beadsAB[,i] <- replace(students_beadsAB[,i], 
                                  students_beadsAB[,i] == "Pond B (80 grey : 20 green)", 1)}
for (i in 2:ncol(students_beadsAB)){
                                  students_beadsAB[,i] <- replace(students_beadsAB[,i], 
                                  students_beadsAB[,i] == "Pond A (80 green : 20 grey)", -1)}
for (i in 2:ncol(students_beadsBB)){
                                  students_beadsBB[,i] <- replace(students_beadsBB[,i], 
                                  students_beadsBB[,i] == "Yes, I chose pond B", 1)}
for (i in 2:ncol(students_beadsBB)){
                                  students_beadsBB[,i] <- replace(students_beadsBB[,i], 
                                  students_beadsBB[,i] == "Yes, I chose pond A", -1)}
for (i in 2:ncol(students_beadsBB)){
                                  students_beadsBB[,i] <- replace(students_beadsBB[,i], 
                                  students_beadsBB[,i] == "No, I need to see more fish", 0)}
for (i in 2:ncol(students_beadsBB)){
                                  students_beadsBB[,i] <- replace(students_beadsBB[,i], 
                                  students_beadsBB[,i] == "Pond B (80 grey : 20 green)", 1)}
for (i in 2:ncol(students_beadsBB)){
                                  students_beadsBB[,i] <- replace(students_beadsBB[,i], 
                                  students_beadsBB[,i] == "Pond A (80 green : 20 grey)", -1)}
## Variable names
colnames(students_beadsAA) <- c(namesMisc[1], paste(rep(namesBeadsA, times = 10),
                                                    rep(1:10, each = 3), sep="")) 
colnames(students_beadsBA) <- c(namesMisc[1], paste(rep(namesBeadsA, times = 10),
                                                    rep(1:10, each = 3), sep=""))
colnames(students_beadsAB) <- c(namesMisc[1], paste(rep(namesBeadsB, times = 10),
                                                    rep(1:10, each = 4), sep=""))
colnames(students_beadsBB) <- c(namesMisc[1], paste(rep(namesBeadsB, times = 10),
                                                    rep(1:10, each = 4), sep=""))

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

# Summary variables
## RQ
rqScoreA <- rowSums(students_rqA[,-1]==1) # Overall score
rqScoreB <- rowSums(students_rqB[,-1]==1) # Overall score
students_rqA <- cbind(students_rqA, rqScoreA)
students_rqB <- cbind(students_rqB, rqScoreB)
## RQ times
allitems <- seq(2,10,4) # First time variable for each item
for (i in 2:ncol(students_rqTimeA)) {students_rqTimeA[,i] <- as.numeric(students_rqTimeA[,i])}
for (i in 2:ncol(students_rqTimeB)) {students_rqTimeB[,i] <- as.numeric(students_rqTimeB[,i])}
rqTimeOTOverallA <- rowSums(students_rqTimeA[,allitems])
rqTimeFLOverallA <- rowSums(students_rqTimeA[,allitems+1])
rqTimeLSOverallA <- rowSums(students_rqTimeA[,allitems+2])
rqTimeCMOverallA <- rowSums(students_rqTimeA[,allitems+3])
rqTimeOTOverallB <- rowSums(students_rqTimeB[,allitems])
rqTimeFLOverallB <- rowSums(students_rqTimeB[,allitems+1])
rqTimeLSOverallB <- rowSums(students_rqTimeB[,allitems+2])
rqTimeCMOverallB <- rowSums(students_rqTimeB[,allitems+3])
students_rqTimeA <- cbind(students_rqTimeA, rqTimeOTOverallA, rqTimeFLOverallA, rqTimeLSOverallA,
                          rqTimeCMOverallA)
students_rqTimeB <- cbind(students_rqTimeB, rqTimeOTOverallB, rqTimeFLOverallB, rqTimeLSOverallB,
                          rqTimeCMOverallB)
## CAPE times
allitems <- seq(2,10,4) # First time variable for each item
for (i in 2:ncol(students_capeTimeA)) {students_capeTimeA[,i] <- as.numeric(students_capeTimeA[,i])}
for (i in 2:ncol(students_capeTimeB)) {students_capeTimeB[,i] <- as.numeric(students_capeTimeB[,i])}
capeTimeOTOverallA <- rowSums(students_capeTimeA[,allitems])
capeTimeFLOverallA <- rowSums(students_capeTimeA[,allitems+1])
capeTimeLSOverallA <- rowSums(students_capeTimeA[,allitems+2])
capeTimeCMOverallA <- rowSums(students_capeTimeA[,allitems+3])
capeTimeOTOverallB <- rowSums(students_capeTimeB[,allitems])
capeTimeFLOverallB <- rowSums(students_capeTimeB[,allitems+1])
capeTimeLSOverallB <- rowSums(students_capeTimeB[,allitems+2])
capeTimeCMOverallB <- rowSums(students_capeTimeB[,allitems+3])
students_capeTimeA <- cbind(students_capeTimeA, capeTimeOTOverallA, capeTimeFLOverallA, 
                            capeTimeLSOverallA, capeTimeCMOverallA)
students_capeTimeB <- cbind(students_capeTimeB, capeTimeOTOverallB, capeTimeFLOverallB, 
                            capeTimeLSOverallB, capeTimeCMOverallB)
## Beads
### How to summarize? It's chaos

# 08 Merging and output Prolific -------------------------------------------------------------------

# Simplified summary file
qualtrics_prolific_summary <- cbind(prolific_misc, prolific_rq[,16:17], prolific_rqTime[,58:69], 
                              prolific_rqDebrief[,-1], prolific_rqNTLX[,-1], prolific_nfc[,-1], 
                              prolific_nfcTime[,-1], prolific_bnt[,6], prolific_bntTime[,18:21], 
                              prolific_fdc[,-1], prolific_fdcTime[,-1])
# Full data
qualtrics_prolific <- cbind(prolific_misc, prolific_rq[,-1], prolific_rqTime[,-1], 
                            prolific_rqDebrief[,-1], prolific_rqNTLX[,-1], prolific_nfc[,-1], 
                            prolific_nfcTime[,-1], prolific_bnt[,-1], prolific_bntTime[,-1], 
                            prolific_fdc[,-1], prolific_fdcTime[,-1])

# Fixing three missing colnames due to merging
oldNameNfc <- "prolific_nfc[, -1]"
newNameNfc <- "nfcScore"
oldNameBnt <- "prolific_bnt[, 6]"
newNameBnt <- "bntScore"
names(qualtrics_prolific)[names(qualtrics_prolific) == oldNameNfc] <- newNameNfc
names(qualtrics_prolific_summary)[names(qualtrics_prolific_summary) == oldNameNfc] <- newNameNfc
names(qualtrics_prolific_summary)[names(qualtrics_prolific_summary) == oldNameBnt] <- newNameBnt

# Write to CSV
write.csv(qualtrics_prolific, "data/processed/qualtrics_prolific.csv")
write.csv(qualtrics_prolific_summary, "data/processed/qualtrics_prolific_summary.csv")

# 09 Merging and output Students -------------------------------------------------------------------

# Merging data across conditions, removing cases with all NA's
## If by mistake played/answered multiple times, keep only first

## Misc
students_misc <- merge(students_miscA, students_miscB, all = TRUE, by = "ID")

## RQ
students_rq <- merge(students_rqA[rowSums(sapply(students_rqA, is.na))!=4,],
                     students_rqB[rowSums(sapply(students_rqB, is.na))!=4,], all = TRUE, by = "ID")
### Save N duplicate responses to meta file
meta_students <- rbind(meta_students, c(sum(rowSums(sapply(students_rq, is.na))==0),
                                        "responded twice"))
nitems <- 4
for(i in 2:(nitems+1)){
  for (x in 1:nrow(students_rq)) {if(is.na(students_rq[x,i])){students_rq[x,i] <- 
    students_rq[x,i+nitems]}}
}
students_rq <- students_rq[,1:(nitems+1)]

## RQ times
students_rqTime <- merge(students_rqTimeA[rowSums(sapply(students_rqTimeA, is.na))!=16,],
                         students_rqTimeB[rowSums(sapply(students_rqTimeB, is.na))!=16,], 
                         all = TRUE, by = "ID")
nitems <- 16
for(i in 2:(nitems+1)){
  for (x in 1:nrow(students_rqTime)) {if(is.na(students_rqTime[x,i])){students_rqTime[x,i] <- 
    students_rqTime[x,i+nitems]}}
}
students_rqTime <- students_rqTime[,1:(nitems+1)]

## NfC
students_nfc <- merge(students_nfcA[rowSums(sapply(students_nfcA, is.na))!=1,], 
                      students_nfcB[rowSums(sapply(students_nfcB, is.na))!=1,], 
                      all = TRUE, by = "ID")
nitems <- 1
for(i in 2:(nitems+1)){
  for (x in 1:nrow(students_nfc)) {if(is.na(students_nfc[x,i])){students_nfc[x,i] <- 
    students_nfc[x,i+nitems]}}
}
students_nfc <- students_nfc[,1:(nitems+1)]

## NfC time
students_nfcTime <- merge(students_nfcTimeA[rowSums(sapply(students_nfcTimeA, is.na))!=4,], 
                          students_nfcTimeB[rowSums(sapply(students_nfcTimeB, is.na))!=4,], 
                          all = TRUE, by = "ID")
nitems <- 4
for(i in 2:(nitems+1)){
  for (x in 1:nrow(students_nfcTime)) {if(is.na(students_nfcTime[x,i])){students_nfcTime[x,i] <- 
    students_nfcTime[x,i+nitems]}}
}
students_nfcTime <- students_nfcTime[,1:(nitems+1)]

## Beads NTLX
students_beadsNTLX <- merge(students_beadsNTLXA[rowSums(sapply(students_beadsNTLXA, is.na))!=6,], 
                            students_beadsNTLXB[rowSums(sapply(students_beadsNTLXB, is.na))!=6,], 
                            all = TRUE, by = "ID")
nitems <- 6
for(i in 2:(nitems+1)){
  for (x in 1:nrow(students_beadsNTLX)) {if(is.na(students_beadsNTLX[x,i])){
    students_beadsNTLX[x,i] <- students_beadsNTLX[x,i+nitems]}}
}
students_beadsNTLX <- students_beadsNTLX[,1:(nitems+1)]

## Beads Diff
students_beadsDiff <- merge(students_beadsDiffA[rowSums(sapply(students_beadsDiffA, is.na))!=1,], 
                            students_beadsDiffB[rowSums(sapply(students_beadsDiffB, is.na))!=1,], 
                            all = TRUE, by = "ID")
nitems <- 1
for(i in 2:(nitems+1)){
  for (x in 1:nrow(students_beadsDiff)) {if(is.na(students_beadsDiff[x,i])){
    students_beadsDiff[x,i] <- students_beadsDiff[x,i+nitems]}}
}
for(i in 2:(nitems+1)){
  for (x in 1:nrow(students_beadsDiff)) {if(students_beadsDiff[x,i]=="")try({
    students_beadsDiff[x,i] <- students_beadsDiff[x,i+nitems]})}
}
students_beadsDiff <- students_beadsDiff[,1:(nitems+1)]

## CAPE
students_cape <- merge(students_capeA[rowSums(sapply(students_capeA, is.na))!=4,], 
                       students_capeB[rowSums(sapply(students_capeB, is.na))!=4,], 
                       all = TRUE, by = "ID")
nitems <- 4
for(i in 2:(nitems+1)){
  for (x in 1:nrow(students_cape)) {if(is.na(students_cape[x,i])){students_cape[x,i] <- 
    students_cape[x,i+nitems]}}
}
students_cape <- students_cape[,1:(nitems+1)]

## CAPE times
students_capeTime <- merge(students_capeTimeA[rowSums(sapply(students_capeTimeA, is.na))!=16,], 
                           students_capeTimeB[rowSums(sapply(students_capeTimeB, is.na))!=16,], 
                           all = TRUE, by = "ID")
nitems <- 16
for(i in 2:(nitems+1)){
  for (x in 1:nrow(students_capeTime)) {if(is.na(students_capeTime[x,i])){students_capeTime[x,i] <- 
    students_capeTime[x,i+nitems]}}
}
students_capeTime <- students_capeTime[,1:(nitems+1)]

## Beads A
students_beadsA <- merge(students_beadsAA[rowSums(sapply(students_beadsAA, is.na))!=30,], 
                         students_beadsBA[rowSums(sapply(students_beadsBA, is.na))!=30,], 
                         all = TRUE, by = "ID")
nitems <- 30
for(i in 2:(nitems+1)){
  for (x in 1:nrow(students_beadsA)) {if(is.na(students_beadsA[x,i])){students_beadsA[x,i] <- 
    students_beadsA[x,i+nitems]}}
}
students_beadsA <- students_beadsA[,1:(nitems+1)]

## Beads B
students_beadsB <- merge(students_beadsAB[rowSums(sapply(students_beadsAB, is.na))!=40,], 
                         students_beadsBB[rowSums(sapply(students_beadsBB, is.na))!=40,], 
                         all = TRUE, by = "ID")
nitems <- 40
for(i in 2:(nitems+1)){
  for (x in 1:nrow(students_beadsB)) {if(is.na(students_beadsB[x,i])){students_beadsB[x,i] <- 
    students_beadsB[x,i+nitems]}}
}
students_beadsB <- students_beadsB[,1:(nitems+1)]

# Manual duplication inspection
## using df[sort(c(as.numeric(row.names(df[duplicated(df[,1]),])), 
##          as.numeric(row.names(df[duplicated(df[,1]),]))-1)),]
## I.e., returns dataframes with all duplicated results, and inspected prior to removal so no
## data gets lost
students_misc <- students_misc[-c(69,136,186,222,226),]
students_rq <- students_rq[-112,]
students_rqTime <- students_rqTime[-112,]
students_nfc <- students_nfc[-112,]
students_nfcTime <- students_nfcTime[-112,]
students_risk <- students_risk[-c(146,179,193),]
students_mood <- students_mood[-c(146,179,193),]
students_beadsNTLX <- students_beadsNTLX[-113,]
students_beadsDiff <- students_beadsDiff[-c(70,137,187,223,225),]
students_diceNTLX <- students_diceNTLX[-c(27,50),]
students_diceDiff <- students_diceDiff[-c(27,50),]
students_cape <- students_cape[-112,]
students_capeTime <- students_capeTime[-112,]
students_beadsA <- students_beadsA[-c(69,136,187,223,225),]
students_beadsB <- students_beadsB[-c(69,137,187,223,225),]


# Merging data across tasks
## Full data
qualtrics_students <-merge(students_misc, students_rq, all = TRUE, by = "ID")
qualtrics_students <-merge(qualtrics_students, students_rqTime, all = TRUE, by = "ID")
qualtrics_students <-merge(qualtrics_students, students_nfc, all = TRUE, by = "ID")
qualtrics_students <-merge(qualtrics_students, students_nfcTime, all = TRUE, by = "ID")
qualtrics_students <-merge(qualtrics_students, students_risk, all = TRUE, by = "ID")
qualtrics_students <-merge(qualtrics_students, students_mood, all = TRUE, by = "ID")
qualtrics_students <-merge(qualtrics_students, students_beadsNTLX, all = TRUE, by = "ID")
qualtrics_students <-merge(qualtrics_students, students_beadsDiff, all = TRUE, by = "ID")
qualtrics_students <-merge(qualtrics_students, students_diceNTLX, all = TRUE, by = "ID")
qualtrics_students <-merge(qualtrics_students, students_diceDiff, all = TRUE, by = "ID")
qualtrics_students <-merge(qualtrics_students, students_cape, all = TRUE, by = "ID")
qualtrics_students <-merge(qualtrics_students, students_capeTime, all = TRUE, by = "ID")
qualtrics_students <-merge(qualtrics_students, students_beadsA, all = TRUE, by = "ID")
qualtrics_students <-merge(qualtrics_students, students_beadsB, all = TRUE, by = "ID")
## Simplified summary-file
qualtrics_students_summary <- qualtrics_students[,c(1:5,11,24:52,65:68)]


# Write to CSV
write.csv(meta_students, "data/processed/meta_students.csv")
write.csv(qualtrics_students, "data/processed/qualtrics_students.csv")
write.csv(qualtrics_students_summary, "data/processed/qualtrics_students_summary.csv")