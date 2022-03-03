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
qualtrics_prolific <- read.csv("data/temp/qualtrics_prolific_temp.csv")
qualtrics_students_1 <- read.csv("data/temp/qualtrics_students_1_a_temp.csv")
qualtrics_students_2 <- read.csv("data/temp/qualtrics_students_1_b_temp.csv")
qualtrics_students_3 <- read.csv("data/temp/qualtrics_students_1_c_temp.csv")
qualtrics_students_2_a <- read.csv("data/temp/qualtrics_students_2_a_temp.csv")
qualtrics_students_2_b <- read.csv("data/temp/qualtrics_students_2_b_temp.csv")
qualtrics_students_2_c <- read.csv("data/temp/qualtrics_students_2_c_temp.csv")
qualtrics_students_2_nfc <- read.csv("data/temp/qualtrics_students_2_nfc_temp.csv")

# Load meta files
metaQualtrics <- read.csv("data/temp/meta_qualtrics.csv")

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

# 03 Extraction Students_1 -------------------------------------------------------------------------

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

# 04 Extraction Students_2 -------------------------------------------------------------------------

# Extract Misc
students2_miscA <- qualtrics_students_2_a[,c(1,3,2)]
students2_miscB <- qualtrics_students_2_b[,c(2,3,4)]

# Extract Condition / Sequence info
students2_condA <- qualtrics_students_2_a[,c(1,4)]
students2_condB <- qualtrics_students_2_b[,c(2,7,9,206,207)]
students2_condC <- qualtrics_students_2_c[,c(1,2)]

# Extract NfC
students2_nfcA <- qualtrics_students_2_nfc # Vast majority took NfC in another session
students2_nfcB <- qualtrics_students_2_b[,c(2,188:205)] # The few students that indicated that they
                                                        # missed that session

# Extract Risk
students2_risk <- qualtrics_students_2_b[,c(2,8)]

# Extract Mood
students2_mood <- qualtrics_students_2_b[,c(2,1)]

# Extract Debrief Box
students2_boxDiffA <- qualtrics_students_2_b[,c(2,10)]
students2_boxDiffB <- qualtrics_students_2_c[,c(1,3)]

# Extract Debrief Dice
students2_diceDiffA <- qualtrics_students_2_b[,c(2,11)]
students2_diceDiffB <- qualtrics_students_2_c[,c(1,4)]
students2_diceWLA <- qualtrics_students_2_b[,c(2,12)]
students2_diceWLB <- qualtrics_students_2_c[,c(1,5)]

# Extract Debrief Beads
students2_beadsDiff <- qualtrics_students_2_b[,c(2,83)]

# Extract Debrief Ellsberg
students2_ellsFam <- qualtrics_students_2_b[,c(2,142)]
students2_ellsRand <- qualtrics_students_2_b[,c(2,139)]
students2_ellsAgency <- qualtrics_students_2_b[,c(2,140)]
students2_ellsAmbtol <- qualtrics_students_2_b[,c(2,141)]

# Extract CAPE
students2_cape <- qualtrics_students_2_b[,c(2,143:187)] # Vast majority got CAPE in another session
                                                        # data was lost there, so only have a few
                                                        # collected from participants that indicated
                                                        # that they missed that session

# Extract IUS
students2_ius <- qualtrics_students_2_b[,c(2,84:95)]

# Extract 5DC
students2_fdc <- qualtrics_students_2_b[,c(2,96:120)]

# Extract Static Ellsberg
students2_ellsStat <- qualtrics_students_2_b[,c(2,121)]

# Extract Dynamic/titration Ellsberg
students2_ellsDyn <- qualtrics_students_2_b[,c(2, 122:138)]

# Extract Beads
students2_beads <- qualtrics_students_2_b[,c(2, 13:82)]

# 06 Recoding Prolific -----------------------------------------------------------------------------

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

# 06 Recoding Students_1 ---------------------------------------------------------------------------

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

# 07 Recoding Students_2 ---------------------------------------------------------------------------

# Variable names and sequences
namesSelfRep <- c("nfcScore", "iusScore","iusProspective","iusInhib", "capeP", "capeN", "capeD",
                  "capeC", "mood", "risk")
namesMisc <- c("ID","Gender", "Age", "BoxOrDice", "AllDays", "BeadsType")
namesFDC <- c("fdcJoyExp", "fdcDepSen", "fdcStress", "fdcSocial", "fdcThrill")
namesDebrief <- c("beadsDiff", "boxDiff", "diceDiff", "diceWL", "ellsFam", "ellsRand", "ellsAgency",
                  "ellsAmbTol")
namesElls <- c("ellsDyn", "ellsStat")
namesBeadsHH <- c("beadsGuess", "beadsProbMin", "beadsProbMaj", "beadsChoice")
namesBeadsGA <- c("beadsProbMin", "beadsProbMaj", "beadsChoice")

# Misc
## Recode Gender (1: Female, 0: Male, -1: Non-binary, NA: Missing)
students2_miscA$gender1 <- recodeGender(x = students2_miscA$gender1)
students2_miscB$GENDER. <- recodeGender(x = students2_miscB$GENDER.)
## Variable names
colnames(students2_miscA) <- c(namesMisc[1:3])
colnames(students2_miscB) <- c(namesMisc[1:3])

# Condition
## Recode condition Box or Dice (FL_6: Box-task first = 1; FL_7: Dice-task first = 0)
students2_condA$FL_5_DO <- recodeSingle(x = students2_condA$FL_5_DO, c = "FL_6")
students2_condB$BBD. <- recodeSingle(x = students2_condB$BBD., c = "Beads- or box-task")
students2_condC$BBD. <- 1-recodeSingle(x = students2_condC$BBD., c = "Beads- or box-task")
## Recode Beads variant (1: Hamburg, 0: Garety)
students2_condB$FL_27_DO <- recodeSingle(x = students2_condB$FL_27_DO, 
                                                   c = "FishHH")
students2_condB$FL_42_DO <- recodeSingle(x = students2_condB$FL_42_DO, c = "FishHH")
students2_condB$FL_27_DO <- rowSums(students2_condB[,c(4,5)], na.rm=TRUE)
students2_condB <- students2_condB[,-5]
## Recode participation (1: Missed some of the other sessions, 0: Attended all)
students2_condB$THURSDAY. <- recodeSingle(x = students2_condB$THURSDAY.,
                                          c = "No, I missed / skipped one of the days")
## Variable names
colnames(students2_condA) <- namesMisc[c(1,4)]
colnames(students2_condB) <- namesMisc[c(1,5,4,6)]
colnames(students2_condC) <- namesMisc[c(1,4)]

# NfC
## Calculate summary score
students2_nfcA[,2] <- recodeNFC(students2_nfcA[,-1])
students2_nfcB[,2] <- recodeNFC(students2_nfcB[,-1])
## Remove individual items
students2_nfcA <- students2_nfcA[,1:2]
students2_nfcB <- students2_nfcB[,1:2]
## Variable names
colnames(students2_nfcA) <- c(namesMisc[1], namesSelfRep[1])
colnames(students2_nfcB) <- c(namesMisc[1], namesSelfRep[1])

# Risk
## Variable names
colnames(students2_risk) <- c(namesMisc[1], namesSelfRep[10])

# Mood
## Variable names
colnames(students2_mood) <- c(namesMisc[1], namesSelfRep[9])

# Debrief box
## Variable names
colnames(students2_boxDiffA) <- c(namesMisc[1], namesDebrief[2])
colnames(students2_boxDiffB) <- c(namesMisc[1], namesDebrief[2])

# Debrief dice
## Variable names
colnames(students2_diceDiffA) <- c(namesMisc[1], namesDebrief[3])
colnames(students2_diceDiffB) <- c(namesMisc[1], namesDebrief[3])
colnames(students2_diceWLA) <- c(namesMisc[1], namesDebrief[4])
colnames(students2_diceWLB) <- c(namesMisc[1], namesDebrief[4])

# Debrief beads
## Variable names
colnames(students2_beadsDiff) <- c(namesMisc[1], namesDebrief[1])

# Debrief Ellsberg
## Recode Ellsberg Familiarity item, from 0: No familiarity, to 4: Played this exact task before
students2_ellsFam <- replace(students2_ellsFam, students2_ellsFam == 
                               "No", 0)
students2_ellsFam <- replace(students2_ellsFam, students2_ellsFam == 
                               "Somewhat, seemed familiar", 1)
students2_ellsFam <- replace(students2_ellsFam, students2_ellsFam == 
                               "Somewhat, read about / know this task", 2)
students2_ellsFam <- replace(students2_ellsFam, students2_ellsFam == 
                               "Yes, played a similar task before", 3)
students2_ellsFam <- replace(students2_ellsFam, students2_ellsFam == 
                               "Yes, played this exact task before", 4)
## Variable names
colnames(students2_ellsFam) <- c(namesMisc[1], namesDebrief[5])
colnames(students2_ellsRand) <- c(namesMisc[1], namesDebrief[6])
colnames(students2_ellsAgency) <- c(namesMisc[1], namesDebrief[7])
colnames(students2_ellsAmbtol) <- c(namesMisc[1], namesDebrief[8])

# CAPE
## Recode answers into 1: Never, 4: Nearly always # To match others using CAPE (so not 0 index)
## Create summary variables for P, N and D sub-scales, and control items
students2_cape[,2:5] <- recodeCAPE(students2_cape[,2:46])
## Remove leftover CAPE items
students2_cape <- students2_cape[,1:5]
## Variable names
colnames(students2_cape) <- c(namesMisc[1], namesSelfRep[5:8])

# IUS
## Recode answers into 1: Not at all characteristic of me, to 5: Entirely characteristic of me
## Create summary variables for overall score, and prospective and inhibitory sub-scales
students2_ius[,2:4] <- recodeIUS(students2_ius[,2:13])
## Remove leftover IUS items
students2_ius <- students2_ius[,1:4]
## Variable names
colnames(students2_ius) <- c(namesMisc[1], namesSelfRep[2:4])

# 5DC
## Recode answers into 1: Does not describe me at all, to 7: Completely describes me
## Create summary variables for each sub-scale, joyexp, depsen, stress, social and thrill
students2_fdc[,2:6] <- recodeFDC(students2_fdc[2:26])
## Remove leftover 5DC items
students2_fdc <- students2_fdc[,1:6]
## Variable names
colnames(students2_fdc) <- c(namesMisc[1], namesFDC)

# Static Ellsberg
## Recode answers into 1: "I have a strong preference to draw a ball from urn B" (risk urn) to
##                     5: "I have a strong preference to draw a ball from urn A" (ambiguity urn)
students2_ellsStat$StaticEllsberg. <- replace(students2_ellsStat$StaticEllsberg., 
                                      students2_ellsStat$StaticEllsberg. == 
                                      "I have a strong preference to draw a ball from urn B.", 1)
students2_ellsStat$StaticEllsberg. <- replace(students2_ellsStat$StaticEllsberg., 
                                      students2_ellsStat$StaticEllsberg. == 
                                      "I have a slight preference to draw a ball from urn B.", 2)
students2_ellsStat$StaticEllsberg. <- replace(students2_ellsStat$StaticEllsberg., 
                                      students2_ellsStat$StaticEllsberg. == 
                            "I am indifferent between drawing a ball from urn A or from urn B.", 3)
students2_ellsStat$StaticEllsberg. <- replace(students2_ellsStat$StaticEllsberg., 
                                      students2_ellsStat$StaticEllsberg. == 
                                      "I have a slight preference to draw a ball from urn A.", 4)
students2_ellsStat$StaticEllsberg. <- replace(students2_ellsStat$StaticEllsberg., 
                                      students2_ellsStat$StaticEllsberg. == 
                                      "I have a strong preference to draw a ball from urn A.", 5)
## Variable names
colnames(students2_ellsStat) <- c(namesMisc[1], namesElls[2])

# Dynamic Ellsberg
## Recode into -1: Highly ambiguity averse, 0: Ambiguity neutral, 1: Highly ambiguity seeking
students2_ellsDyn[,2] <- recodeEllsDyn(students2_ellsDyn[,2:18])
## Remove leftover items
students2_ellsDyn <- students2_ellsDyn[,1:2]
## Variable names
colnames(students2_ellsDyn) <- c(namesMisc[1], namesElls[1])

# Beads
## Recode into guess/choice pond B (corr): 1, guess/choice pond A (incorr): -1, and no decision: 0
for (i in 2:ncol(students2_beads)) {
  students2_beads[,i] <- replace(students2_beads[,i], 
                                 students2_beads[,i] == "Yes, I chose pond B", 1)
  students2_beads[,i] <- replace(students2_beads[,i], 
                                 students2_beads[,i] == "Yes, I chose pond A", -1)
  students2_beads[,i] <- replace(students2_beads[,i], 
                                 students2_beads[,i] == "No, I need to see more fish", 0)
  students2_beads[,i] <- replace(students2_beads[,i], 
                                 students2_beads[,i] == "Pond B (80 grey : 20 green)", 1)
  students2_beads[,i] <- replace(students2_beads[,i], 
                                 students2_beads[,i] == "Pond A (80 green : 20 grey)", -1)
  }
## Split into Hamburg and Garety variant
students2_beadsHH <- students2_beads[students2_condB$BeadsType==1,c(1, 32:71)]
students2_beadsGA <- students2_beads[students2_condB$BeadsType==0,c(1:31)]
## Variable names
colnames(students2_beadsHH) <- c(namesMisc[1], paste(namesBeadsHH, rep(1:10, each=4), sep=""))
colnames(students2_beadsGA) <- c(namesMisc[1], paste(namesBeadsGA, rep(1:10, each=3), sep=""))

# 08 Summary variable creation Prolific ------------------------------------------------------------

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

# 09 Summary variable creation Students_1 ----------------------------------------------------------

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
### Beads summary variables created after AA, AB, BA and BB merging are done (section 11, line 1025)

# 10 Merging and output Prolific -------------------------------------------------------------------

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
write.csv(qualtrics_prolific, "data/processed/qualtrics_prolific_full.csv")
write.csv(qualtrics_prolific_summary, "data/processed/qualtrics_prolific_summary.csv")

# 11 Merging and output Students_1 -----------------------------------------------------------------

# Merging data across conditions, removing cases with all NA's
## If by mistake played/answered multiple times, keep only first

## Misc
students_misc <- merge(students_miscA, students_miscB, all = TRUE, by = "ID")

## RQ
students_rq <- merge(students_rqA[rowSums(sapply(students_rqA, is.na))!=4,],
                     students_rqB[rowSums(sapply(students_rqB, is.na))!=4,], all = TRUE, by = "ID")
### Save N duplicate responses to meta file
metaQualtrics <- rbind(metaQualtrics, c(sum(rowSums(sapply(students_rq, is.na))==0),
                                        "responded twice", "Students_1"))
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
students_beadsA <- merge(students_beadsAA[rowSums(sapply(students_beadsAA, is.na))<11,], 
                         students_beadsBA[rowSums(sapply(students_beadsBA, is.na))<11,], 
                         all = TRUE, by = "ID")
nitems <- 30
for(i in 2:(nitems+1)){
  for (x in 1:nrow(students_beadsA)) {if(is.na(students_beadsA[x,i])){students_beadsA[x,i] <- 
    students_beadsA[x,i+nitems]}}
}
students_beadsA <- students_beadsA[,1:(nitems+1)]

## Beads B
students_beadsB <- merge(students_beadsAB[rowSums(sapply(students_beadsAB, is.na))<11,], 
                         students_beadsBB[rowSums(sapply(students_beadsBB, is.na))<11,], 
                         all = TRUE, by = "ID")
nitems <- 40
for(i in 2:(nitems+1)){
  for (x in 1:nrow(students_beadsB)) {if(is.na(students_beadsB[x,i])){students_beadsB[x,i] <- 
    students_beadsB[x,i+nitems]}}
}
students_beadsB <- students_beadsB[,1:(nitems+1)]

## Beads summary variable creation
### Creates three variables, DtD (Draw to Decision; first choice), EPD (Estimated Probability at
### Decision), CAD (Change after Decision; choosing something else after first decision; yes/no)
### Beads A
### DtD
seqv <- seq(4,31,3)
students_beadsA$beadsDtD <- 1
for (x in 1:nrow(students_beadsA)) {
  firstdtd <- NULL
  for (i in seqv) {
    if (as.numeric(students_beadsA[x,i])!=0) {
      firstdtd <- c(firstdtd, which(seqv==i))
      students_beadsA[x,32] <- min(firstdtd) 
    }
  }
}
#### EPD
students_beadsA$beadsEPD <- 1
for (x in 1:nrow(students_beadsA)) {
  if ((students_beadsA[x,seqv[students_beadsA[x,32]]]) == 1) {students_beadsA[x,33] <- students_beadsA[x,seqv[students_beadsA[x,32]]-1]}
  if ((students_beadsA[x,seqv[students_beadsA[x,32]]]) == -1) {students_beadsA[x,33] <- students_beadsA[x,seqv[students_beadsA[x,32]]-2]}
}

#### CAD
students_beadsA$beadsCAD <- 1
for (x in 1:nrow(students_beadsA)) {
  changes <- NULL
  for (i in seqv[students_beadsA[x,32]:length(seqv)]) {
    changes <- c(changes, students_beadsA[x,i])
  }
  students_beadsA[x,34] <- length(unique(changes))>1
}
#### Set never made any choice to NA
for (x in 1:nrow(students_beadsA)) {
  if ((students_beadsA[x,seqv[students_beadsA[x,32]]]) == 0) {
    students_beadsA[x,33] <- NA
    students_beadsA[x,34] <- NA
    students_beadsA[x,32] <- NA}
}
#### Set condition variable (beadsCond; A:0, B:1)
students_beadsA$beadsCond <- 0
#### Keep summary variables only
students_beadsA <- students_beadsA[,c(1,32,33,34,35)]

### Beads B
#### DtD
seqv <- seq(5,41,4)
students_beadsB$beadsDtD <- 1
for (x in 1:nrow(students_beadsB)) {
  firstdtd <- NULL
  for (i in seqv) {
    if (as.numeric(students_beadsB[x,i])!=0) {
      firstdtd <- c(firstdtd, which(seqv==i))
      students_beadsB[x,42] <- min(firstdtd) 
    }
  }
}
#### EPD
students_beadsB$beadsEPD <- 1
for (x in 1:nrow(students_beadsB)) {
  if ((students_beadsB[x,seqv[students_beadsB[x,42]]]) == 1) {students_beadsB[x,43] <- students_beadsB[x,seqv[students_beadsB[x,42]]-1]}
  if ((students_beadsB[x,seqv[students_beadsB[x,42]]]) == -1) {students_beadsB[x,43] <- students_beadsB[x,seqv[students_beadsB[x,42]]-2]}
}

#### CAD
students_beadsB$beadsCAD <- 1
for (x in 1:nrow(students_beadsB)) {
  changes <- NULL
  for (i in seqv[students_beadsB[x,42]:length(seqv)]) {
    changes <- c(changes, students_beadsB[x,i])
  }
  students_beadsB[x,44] <- length(unique(changes))>1
}
#### Set never made any choice to NA
for (x in 1:nrow(students_beadsB)) {
  if ((students_beadsB[x,seqv[students_beadsB[x,42]]]) == 0) {
    students_beadsB[x,43] <- NA
    students_beadsB[x,44] <- NA
    students_beadsB[x,42] <- NA}
}
#### Set condition variable (beadsCond; A:0, B:1)
students_beadsB$beadsCond <- 1
#### Keep summary variables only
students_beadsB <- students_beadsB[,c(1,42,43,44,45)]

# Remove duplicate attempts data
## (dependent on duplicate.detective.R being ran beforehand)
if (exists('students_misc_remove')) { # Duplicates removed if the removal columns exist
## Mood
allRemove <- NULL
for (i in students_mood_remove) {
  idRemove <- (grepl(i, students_mood$ID))
  allRemove <- cbind(idRemove, allRemove)
}
allRemove <- rowSums(allRemove)
students_mood <- students_mood[!as.logical(allRemove),]
## Misc
allRemove <- NULL
for (i in students_misc_remove) {
  idRemove <- (grepl(i, students_misc$ID))
  allRemove <- cbind(idRemove, allRemove)
}
allRemove <- rowSums(allRemove)
students_misc <- students_misc[!as.logical(allRemove),]
## Risk
allRemove <- NULL
for (i in students_risk_remove) {
  idRemove <- (grepl(i, students_risk$ID))
  allRemove <- cbind(idRemove, allRemove)
}
allRemove <- rowSums(allRemove)
students_risk <- students_risk[!as.logical(allRemove),]
## DiceNTLX
allRemove <- NULL
for (i in students_diceNTLX_remove) {
  idRemove <- (grepl(i, students_diceNTLX$ID))
  allRemove <- cbind(idRemove, allRemove)
}
allRemove <- rowSums(allRemove)
students_diceNTLX <- students_diceNTLX[!as.logical(allRemove),]
## DiceDiff
allRemove <- NULL
for (i in students_diceDiff_remove) {
  idRemove <- (grepl(i, students_diceDiff$ID))
  allRemove <- cbind(idRemove, allRemove)
}
allRemove <- rowSums(allRemove)
students_diceDiff <- students_diceDiff[!as.logical(allRemove),]
## RQ
allRemove <- NULL
for (i in students_rq_remove) {
  idRemove <- (grepl(i, students_rq$ID))
  allRemove <- cbind(idRemove, allRemove)
}
allRemove <- rowSums(allRemove)
students_rq <- students_rq[!as.logical(allRemove),]
## RQ time
allRemove <- NULL
for (i in students_rqTime_remove) {
  idRemove <- (grepl(i, students_rqTime$ID))
  allRemove <- cbind(idRemove, allRemove)
}
allRemove <- rowSums(allRemove)
students_rqTime <- students_rqTime[!as.logical(allRemove),]
## NfC
allRemove <- NULL
for (i in students_nfc_remove) {
  idRemove <- (grepl(i, students_nfc$ID))
  allRemove <- cbind(idRemove, allRemove)
}
allRemove <- rowSums(allRemove)
students_nfc <- students_nfc[!as.logical(allRemove),]
## NfC time
allRemove <- NULL
for (i in students_nfcTime_remove) {
  idRemove <- (grepl(i, students_nfcTime$ID))
  allRemove <- cbind(idRemove, allRemove)
}
allRemove <- rowSums(allRemove)
students_nfcTime <- students_nfcTime[!as.logical(allRemove),]
## Beads NTLX
allRemove <- NULL
for (i in students_beadsNTLX_remove) {
  idRemove <- (grepl(i, students_beadsNTLX$ID))
  allRemove <- cbind(idRemove, allRemove)
}
allRemove <- rowSums(allRemove)
students_beadsNTLX <- students_beadsNTLX[!as.logical(allRemove),]
## Beads Diff
allRemove <- NULL
for (i in students_beadsDiff_remove) {
  idRemove <- (grepl(i, students_beadsDiff$ID))
  allRemove <- cbind(idRemove, allRemove)
}
allRemove <- rowSums(allRemove)
students_beadsDiff <- students_beadsDiff[!as.logical(allRemove),]
## CAPE
allRemove <- NULL
for (i in students_cape_remove) {
  idRemove <- (grepl(i, students_cape$ID))
  allRemove <- cbind(idRemove, allRemove)
}
allRemove <- rowSums(allRemove)
students_cape <- students_cape[!as.logical(allRemove),]
## Beads A
allRemove <- NULL
for (i in students_beadsA_remove) {
  idRemove <- (grepl(i, students_beadsA$ID))
  allRemove <- cbind(idRemove, allRemove)
}
allRemove <- rowSums(allRemove)
students_beadsA <- students_beadsA[!as.logical(allRemove),]
## Beads B
allRemove <- NULL
for (i in students_beadsB_remove) {
  idRemove <- (grepl(i, students_beadsB$ID))
  allRemove <- cbind(idRemove, allRemove)
}
allRemove <- rowSums(allRemove)
students_beadsB <- students_beadsB[!as.logical(allRemove),]
}

# Renaming to correct / equal IDs for all kept data
if (exists('students_renameID')) { # Duplicates removed if the rename columns exist
## Mood
df <- students_mood
for (i in 1:length(students_renameID[,2])) {
  for (x in 1:length(df$ID)) {
    if (df[x,1]==students_renameID[i,2]) df[x,1] <- students_renameID[i,1] 
    }
}
students_mood <- df
## Misc
df <- students_misc
for (i in 1:length(students_renameID[,2])) {
  for (x in 1:length(df$ID)) {
    if (df[x,1]==students_renameID[i,2]) df[x,1] <- students_renameID[i,1] 
  }
}
students_misc <- df
## Risk
df <- students_risk
for (i in 1:length(students_renameID[,2])) {
  for (x in 1:length(df$ID)) {
    if (df[x,1]==students_renameID[i,2]) df[x,1] <- students_renameID[i,1] 
  }
}
students_risk <- df
## Dice NTLX
df <- students_diceNTLX
for (i in 1:length(students_renameID[,2])) {
  for (x in 1:length(df$ID)) {
    if (df[x,1]==students_renameID[i,2]) df[x,1] <- students_renameID[i,1] 
  }
}
students_diceNTLX <- df
## Dice Diff
df <- students_diceDiff
for (i in 1:length(students_renameID[,2])) {
  for (x in 1:length(df$ID)) {
    if (df[x,1]==students_renameID[i,2]) df[x,1] <- students_renameID[i,1] 
  }
}
students_diceDiff <- df
## RQ
df <- students_rq
for (i in 1:length(students_renameID[,2])) {
  for (x in 1:length(df$ID)) {
    if (df[x,1]==students_renameID[i,2]) df[x,1] <- students_renameID[i,1] 
  }
}
students_rq <- df
## RQ time
df <- students_rqTime
for (i in 1:length(students_renameID[,2])) {
  for (x in 1:length(df$ID)) {
    if (df[x,1]==students_renameID[i,2]) df[x,1] <- students_renameID[i,1] 
  }
}
students_rqTime <- df
## NfC
df <- students_nfc
for (i in 1:length(students_renameID[,2])) {
  for (x in 1:length(df$ID)) {
    if (df[x,1]==students_renameID[i,2]) df[x,1] <- students_renameID[i,1] 
  }
}
students_nfc <- df
## NfC time
df <- students_nfcTime
for (i in 1:length(students_renameID[,2])) {
  for (x in 1:length(df$ID)) {
    if (df[x,1]==students_renameID[i,2]) df[x,1] <- students_renameID[i,1] 
  }
}
students_nfcTime <- df
## Beads NTLX
df <- students_beadsNTLX
for (i in 1:length(students_renameID[,2])) {
  for (x in 1:length(df$ID)) {
    if (df[x,1]==students_renameID[i,2]) df[x,1] <- students_renameID[i,1] 
  }
}
students_beadsNTLX <- df
## Beads Diff
df <- students_beadsDiff
for (i in 1:length(students_renameID[,2])) {
  for (x in 1:length(df$ID)) {
    if (df[x,1]==students_renameID[i,2]) df[x,1] <- students_renameID[i,1] 
  }
}
students_beadsDiff <- df
## CAPE
df <- students_cape
for (i in 1:length(students_renameID[,2])) {
  for (x in 1:length(df$ID)) {
    if (df[x,1]==students_renameID[i,2]) df[x,1] <- students_renameID[i,1] 
  }
}
students_cape <- df
## Beads A
df <- students_beadsA
for (i in 1:length(students_renameID[,2])) {
  for (x in 1:length(df$ID)) {
    if (df[x,1]==students_renameID[i,2]) df[x,1] <- students_renameID[i,1] 
  }
}
students_beadsA <- df
## Beads B
df <- students_beadsB
for (i in 1:length(students_renameID[,2])) {
  for (x in 1:length(df$ID)) {
    if (df[x,1]==students_renameID[i,2]) df[x,1] <- students_renameID[i,1] 
  }
}
students_beadsB <- df
}
## Manual removal of ID 66118 & 98851 second attempt, and all 99999 entries (pilot data)
students_misc <-      rbind(students_misc[students_misc$ID!=66118,], 
                            students_misc[students_misc$ID==66118,][-2,])
students_rq <-        rbind(students_rq[students_rq$ID!=66118,], 
                            students_rq[students_rq$ID==66118,][-2,])
students_rqTime <-    rbind(students_rqTime[students_rqTime$ID!=66118,], 
                            students_rqTime[students_rqTime$ID==66118,][-2,])
students_nfc <-       rbind(students_nfc[students_nfc$ID!=66118,], 
                            students_nfc[students_nfc$ID==66118,][-2,])
students_nfcTime <-   rbind(students_nfcTime[students_nfcTime$ID!=66118,], 
                            students_nfcTime[students_nfcTime$ID==66118,][-2,])
students_risk <-      rbind(students_risk[students_risk$ID!=66118,], 
                            students_risk[students_risk$ID==66118,][-2,])
students_mood <-      rbind(students_mood[students_mood$ID!=66118,], 
                            students_mood[students_mood$ID==66118,][-2,])
students_beadsNTLX <- rbind(students_beadsNTLX[students_beadsNTLX$ID!=66118,], 
                            students_beadsNTLX[students_beadsNTLX$ID==66118,][-2,])
students_beadsDiff <- rbind(students_beadsDiff[students_beadsDiff$ID!=66118,], 
                            students_beadsDiff[students_beadsDiff$ID==66118,][-2,])
students_diceNTLX <-  rbind(students_diceNTLX[students_diceNTLX$ID!=66118,], 
                            students_diceNTLX[students_diceNTLX$ID==66118,][-2,])
students_diceDiff <-  rbind(students_diceDiff[students_diceDiff$ID!=66118,], 
                            students_diceDiff[students_diceDiff$ID==66118,][-2,])
students_cape <-      rbind(students_cape[students_cape$ID!=66118,], 
                            students_cape[students_cape$ID==66118,][-2,])
students_beadsA <-    rbind(students_beadsA[students_beadsA$ID!=66118,], 
                            students_beadsA[students_beadsA$ID==66118,][-2,])
students_beadsB <-    rbind(students_beadsB[students_beadsB$ID!=66118,], 
                            students_beadsB[students_beadsB$ID==66118,][-2,])
students_misc <-      rbind(students_misc[students_misc$ID!=98851,], 
                            students_misc[students_misc$ID==98851,][-2,])
students_beadsDiff <- rbind(students_beadsDiff[students_beadsDiff$ID!=98851,], 
                            students_beadsDiff[students_beadsDiff$ID==98851,][-2,])
students_diceNTLX <-  rbind(students_diceNTLX[students_diceNTLX$ID!=98851,], 
                            students_diceNTLX[students_diceNTLX$ID==98851,][-2,])
students_diceDiff <-  rbind(students_diceDiff[students_diceDiff$ID!=98851,], 
                            students_diceDiff[students_diceDiff$ID==98851,][-2,])
students_beadsA <-    rbind(students_beadsA[students_beadsA$ID!=98851,], 
                            students_beadsA[students_beadsA$ID==98851,][-2,])
students_beadsB <-    rbind(students_beadsB[students_beadsB$ID!=98851,], 
                            students_beadsB[students_beadsB$ID==98851,][-2,])
students_misc <-      students_misc[students_misc$ID!=99999,]
students_beadsDiff <- students_beadsDiff[students_beadsDiff$ID!=99999,]
students_diceNTLX <-  students_diceNTLX[students_diceNTLX$ID!=99999,]
students_diceDiff <-  students_diceDiff[students_diceDiff$ID!=99999,]
students_beadsA <-    students_beadsA[students_beadsA$ID!=99999,]
students_beadsB <-    students_beadsB[students_beadsB$ID!=99999,]

# Merging data across tasks
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
#qualtrics_students <-merge(qualtrics_students, students_capeTime, all = TRUE, by = "ID")
qualtrics_students <-merge(qualtrics_students, students_beadsA, all = TRUE, by = "ID")
qualtrics_students <-merge(qualtrics_students, students_beadsB, all = TRUE, by = "ID")
## If beads condition is A, only keep that, if B, only keep that
for (i in 1:nrow(qualtrics_students)) {
  if (!is.na(as.numeric(qualtrics_students[i,60]))) {
    qualtrics_students[i,56] <- qualtrics_students[i,60]
    qualtrics_students[i,55] <- qualtrics_students[i,59]
    qualtrics_students[i,54] <- qualtrics_students[i,58]
    qualtrics_students[i,53] <- qualtrics_students[i,57]}
}

# Add inn condition (1: Beads first, 1: Beads first)
students_condA$FL_10_DO_FL_31 <- students_condA$FL_10_DO_FL_31-1
students_condA$beadsFirst <- rowSums(students_condA[,c(2,3)], na.rm = TRUE)
students_condA <- students_condA[-145,] # Only duplicate left, taken care of above except in this 
                                        # condition variable
qualtrics_students <- merge(qualtrics_students, students_condA[,c(1,6)], by = 1, all.x = TRUE,
                            all.y = FALSE)

# Fixing colnames due to merging
for (i in 1:length(colnames(qualtrics_students))) {
  colnames(qualtrics_students)[i] <- unlist(strsplit(colnames(qualtrics_students)[i], ".",
                                                     fixed = TRUE))[1]}
colnames(qualtrics_students)[6] <-"beadsEarly"
colnames(qualtrics_students)[7] <-"beadsNFish"
colnames(qualtrics_students)[11] <-"rqScore"
colnames(qualtrics_students)[35] <-"beadsNtlxMental"
colnames(qualtrics_students)[36] <-"beadsNtlxPhysical"
colnames(qualtrics_students)[37] <-"beadsNtlxTempo"
colnames(qualtrics_students)[38] <-"beadsNtlxFrust"
colnames(qualtrics_students)[39] <-"beadsNtlxEffort"
colnames(qualtrics_students)[40] <-"beadsNtlxPerf"
colnames(qualtrics_students)[41] <-"beadsDiff"
colnames(qualtrics_students)[42] <-"diceNtlxMental"
colnames(qualtrics_students)[43] <-"diceNtlxPhysical"
colnames(qualtrics_students)[44] <-"diceNtlxTempo"
colnames(qualtrics_students)[45] <-"diceNtlxFrust"
colnames(qualtrics_students)[46] <-"diceNtlxEffort"
colnames(qualtrics_students)[47] <-"diceNtlxPerf"

# Full data
qualtrics_students_1 <- qualtrics_students[,-c(57,58,59,60)]

# Simplified summary file
qualtrics_students_1_summary <- qualtrics_students_1[,-c(2,5:10,12:27,29:32)]

# Write to CSV
write.csv(qualtrics_students_1, "data/processed/qualtrics_students_1_full.csv")
write.csv(qualtrics_students_1_summary, "data/processed/qualtrics_students_1_summary.csv")

# 12 Merging and output Students_2 ------------------------------------------------------------------

# BoxDiff
## Removal of NA and merge
students2_boxDiff <- merge(students2_boxDiffA[!is.na(students2_boxDiffA$boxDiff),], 
                           students2_boxDiffB[!is.na(students2_boxDiffB$boxDiff),], 
                           by = 1, all.x = TRUE, all.y = TRUE)
## Keep only first entry in case of multiple attempts (noted in box-task)
students2_boxDiff <- students2_boxDiff[!duplicated(students2_boxDiff$ID),]
## Merge into one column and rename variables
students2_boxDiff$boxDiff.x <- rowSums(cbind(as.numeric(students2_boxDiff[,2]),
                                             as.numeric(students2_boxDiff[,3])), na.rm = TRUE)
students2_boxDiff <- students2_boxDiff[,-3]
colnames(students2_boxDiff) <- c(namesMisc[1], namesDebrief[2])

# CAPE
# Removal of NA's
students2_cape <- students2_cape[rowSums(is.na(students2_cape[,2:5]))==0,]

# Condition
## CondA Duplicates
### CondA duplicates found: students2_condA[duplicated(students2_condA$ID),1]
### 3903, 5837 & 6783 where the first two contains identical info, and the latter one different info
### Remove second row for all, make sure only first data is used for them.
students2_condA <- students2_condA[!duplicated(students2_condA$ID),]
## CondB Duplicates
### CondB duplicates found: students2_condB[duplicated(students2_condB$ID),1]
### 1275 & 5837 where the first contains identical info, and the latter different info
### Remove second row for all, make sure only first data is used for them.
students2_condB <- students2_condB[!duplicated(students2_condB$ID),]
## CondC Duplciates
### CondC duplicates found: students2_condC[duplicated(students2_condC$ID),1]
### 4550 & 6599 where both contains identical info.
### Remove second row for all, make sure only first data is used for them.
students2_condC <- students2_condC[!duplicated(students2_condC$ID),]
## Merge into one
students2_cond <- merge(students2_condA, students2_condB, by = 1, all = TRUE)
students2_cond <- merge(students2_cond, students2_condC, by = 1, all = TRUE)
## Rearrange variables
students2_cond <- students2_cond[,c(1,3,5,2,4,6)]
## Find problematic cases
problem <- cbind(students2_cond, rowMeans(students2_cond[,4:6], na.rm=TRUE))
problem <- problem[problem$`rowMeans(students2_cond[, 4:6], na.rm = TRUE)` != 0,]
problem <- problem[problem$`rowMeans(students2_cond[, 4:6], na.rm = TRUE)` != 1,]
### In total 11 participants have conflicting data, meaning they got wrong debrief questionnaires
### after one of the tasks (either box or dice).
### IDs 1646, 1768, 1923, 2931, 3854, 4052, 4077 & 4327 (n = 8) first played dice-task, and
### responded to the dice-task debrief, then played box-task, and responded to dice-task again.
### => Remove second dice-debrief for these, assume missing box-task data. Should take care of it
### self in duplicate removal, but to be on the safe side, do it here.
#### No need to save in meta, as it's redundant (extra) data that is removed, and NA naturally in
#### box-debrief.
idDupData <- c(1646, 1768, 1923, 2931, 3854, 4052, 4077, 4327)
remov <- NULL
for (i in idDupData) {
  rem <- students2_diceDiffB$ID == i
  remov <- cbind(remov, rem)
}
remov <- 1-rowSums(remov)
#### Actual removal
students2_diceDiffB <- students2_diceDiffB[as.logical(remov),]
### IDs 2051 & 4550 first played box-task, responded to dice-task, then got box-task again, and
### responded to box-task. Verified in box-task data.
### => Remove all debriefs for these, and second box-task data, assume missing dice-task data.
### Box-task data removed in box-task script, debrief removal here.
idDupData <- c(2051, 4550)
removDiceDebA <- NULL
removDiceDebB <- NULL
removBoxDeb <- NULL
for (i in idDupData) {
  remDiceDebA <- students2_diceDiffA$ID == i
  remDiceDebB <- students2_diceDiffB$ID == i
  remBoxDeb <- students2_boxDiff$ID == i
  removDiceDebA <- cbind(removDiceDebA, remDiceDebA)
  removDiceDebB <- cbind(removDiceDebB, remDiceDebB)
  removBoxDeb <- cbind(removBoxDeb, remBoxDeb)
}
removDiceDebA <- 1 - rowSums(removDiceDebA) # Should be 2 to remove, and it is.
removDiceDebB <- 1 - rowSums(removDiceDebB) # Should be 0 to remove, and it is.
removBoxDeb <- 1 - rowSums(removBoxDeb) # Should be 2 to remove, and it is.
#### Save to meta, as it's not extra data that is removed, but rather wrong data (wrong debrief)
nremoved <- sum(!is.na(students2_diceDiffA[!as.logical(removDiceDebA),2]))*2 # Due to WL variable
nremoved <- nremoved + sum(!is.na(students2_diceDiffB[!as.logical(removDiceDebB),2]))
nremoved <- nremoved + sum(!is.na(students2_boxDiff[!as.logical(removBoxDeb),2]))
metaQualtrics <- rbind(metaQualtrics, c(nremoved, "wrong debrief data", "Students_2"))
metaQualtrics <- rbind(metaQualtrics, c(length(idDupData), "unique wrong debrief participants",
                                        "Students_2"))
#### Actual removal
students2_diceDiffA <- students2_diceDiffA[as.logical(removDiceDebA),]
students2_diceDiffB <- students2_diceDiffB[as.logical(removDiceDebB),]
students2_diceWLA <- students2_diceWLA[as.logical(removDiceDebA),]
students2_diceWLB <- students2_diceWLB[as.logical(removDiceDebA),]
students2_boxDiff <- students2_boxDiff[as.logical(removBoxDeb),]
### ID 5042 have missing data for one debrief, no action needed.
## Clean up Cond variable
### Only keep wheter the actually got the dice-task first (0) or box-task (1).
students2_cond <- students2_cond[,-c(5,6)]
colnames(students2_cond)[4] <- "BoxBeforeDice"

# DiceDiff
## Removal of NA and merge
students2_diceDiff <- merge(students2_diceDiffA[!is.na(students2_diceDiffA$diceDiff),], 
                            students2_diceDiffB[!is.na(students2_diceDiffB$diceDiff),], 
                           by = 1, all.x = TRUE, all.y = TRUE)
## Merge into one column and rename variables
students2_diceDiff[is.na(students2_diceDiff$diceDiff.x),2] <- students2_diceDiff[is.na(
  students2_diceDiff$diceDiff.x),3]
students2_diceDiff <- students2_diceDiff[,-3]
colnames(students2_diceDiff) <- c(namesMisc[1], namesDebrief[3])

# DiceWL
## Removal of NA and merge
students2_diceWL <- merge(students2_diceWLA[!is.na(students2_diceWLA$diceWL),], 
                            students2_diceWLB[!is.na(students2_diceWLB$diceWL),], 
                            by = 1, all.x = TRUE, all.y = TRUE)
## Merge into one column and rename variables
students2_diceWL[is.na(students2_diceWL$diceWL.x),2] <- students2_diceWL[is.na(
  students2_diceWL$diceWL.x),3]
students2_diceWL <- students2_diceWL[,-3]
colnames(students2_diceWL) <- c(namesMisc[1], namesDebrief[4])

# Ellsberg variables
## Record duplicate attempts to meta, and a column identifying duplicate attempts for Qualtrics-form
metaQualtrics <- rbind(metaQualtrics, c(sum(duplicated(students2_ellsAgency$ID)), "responded twice",
                                        "Students_2"))
idS <- students2_ellsAgency[duplicated(students2_ellsAgency$ID), 1]
multi <- NULL
for (i in idS) {
  mult <- students2_cond$ID==i
  multi <- cbind(multi, mult)
}
students2_cond$MultipleAttempts <- rowSums(multi)
## Removal of duplicates
students2_ellsAgency <- students2_ellsAgency[!duplicated(students2_ellsAgency$ID),]
students2_ellsAmbtol <- students2_ellsAmbtol[!duplicated(students2_ellsAmbtol$ID),]
students2_ellsDyn <- students2_ellsDyn[!duplicated(students2_ellsDyn$ID),]
students2_ellsFam <- students2_ellsFam[!duplicated(students2_ellsFam$ID),]
students2_ellsRand <- students2_ellsRand[!duplicated(students2_ellsRand$ID),]
students2_ellsStat <- students2_ellsStat[!duplicated(students2_ellsStat$ID),]

# FDC
## Removal of duplicates
students2_fdc <- students2_fdc[!duplicated(students2_fdc$ID),]

# IUS
## Removal of duplicates
students2_ius <- students2_ius[!duplicated(students2_ius$ID),]

# Misc
## Merge
students2_misc <- merge(students2_miscA, students2_miscB, by = 1, all.x = TRUE, all.y = TRUE)
## All duplicated entries contain identical info, except 3903 where all demographics will be removed
### Changed from 20y male to 38y female, assume trolling and first being correct, but to be safe.
students2_misc <- students2_misc[!duplicated(students2_misc$ID),]
students2_misc[students2_misc$ID==3903,2:5] <- c(NA,NA)
## Replace NA values at first recording with values from second recording
students2_misc[is.na(students2_misc$Gender.x),2] <- students2_misc[is.na(students2_misc$Gender.x),4]
students2_misc[is.na(students2_misc$Age.x),3] <- students2_misc[is.na(students2_misc$Age.x),5]
## Identify any participants giving different demographics at first and last time-point
different <- (students2_misc[,2]==students2_misc[,4])==FALSE
different <- rowSums(cbind(different, (students2_misc[,3]==students2_misc[,5])==FALSE), na.rm = TRUE)
### Using students2_misc[as.logical(different),] gives one participant, 5951, changed gender from
### female to other. Remove gender to be safe.
students2_misc[students2_misc$ID==5951,2] <- "NA"
## Remove redundant columns
students2_misc <- students2_misc[,-c(4,5)]
## Rename variables
colnames(students2_misc)[2] <- "Gender"
colnames(students2_misc)[3] <- "Age"

# Mood
## If participant wen with '3' without adjusting the slider, it's recorded as NA. Recode these,
## and to make sure, only do so if the latter 'Age'-question is answered
moodfix <- merge(students2_mood, students2_misc, by = 1, all.x = TRUE)
moodfix[is.na(moodfix$mood),2] <- (moodfix[is.na(moodfix$mood),4]>1)*3
students2_mood <- moodfix[,c(1,2)]
## Removal of duplicates
students2_mood <- students2_mood[!duplicated(students2_mood$ID),]

# NfC
## Merge and remove NA's
students2_nfc <- merge(students2_nfcA[!is.na(students2_nfcA$nfcScore),], 
                       students2_nfcB[!is.na(students2_nfcB$nfcScore),], 
                       by = 1, all.x = TRUE, all.y = TRUE)
## Removal of duplicates
students2_nfc <- students2_nfc[!duplicated(students2_nfc$ID),]
## Save to meta the n of participants that get their NfC from this component session
metaQualtrics <- rbind(metaQualtrics, c(sum(is.na(students2_nfc$nfcScore.x)),
                                        "participants with NfC from different day", "Students_2"))
## Keep NfC from main collection if both exists
students2_nfc[is.na(students2_nfc$nfcScore.x),2] <- students2_nfc[is.na(students2_nfc$nfcScore.x),3]
## Remove redundant columns
students2_nfc <- students2_nfc[,-c(3)]
## Rename variables
colnames(students2_nfc)[2] <- "nfcScore"

# Risk
## Removal of duplicates
students2_risk <- students2_risk[!duplicated(students2_risk$ID),]

# Beads Diff
## Removal of duplicates
students2_beadsDiff <- students2_beadsDiff[!duplicated(students2_beadsDiff$ID),]

# Beads
## Garety variant
### Creates three variables, DtD (Draw to Decision; first choice), EPD (Estimated Probability at
### Decision), CAD (Change after Decision; choosing something else after first decision; yes/no)
choices <- c(4,7,10,13,16,19,22,25,28,31)
DtD <- students2_beadsGA[,c(choices)]
garety <- NULL
for (i in 1:nrow(DtD)) {
  cor <- match(1,DtD[i,])
  incor <- match(-1,DtD[i,])
  none <- sum(grepl(0, DtD[i,]))
  if (none == 10) {
    cor <- 11
    incor <- 11 } else {
      none <- 11}
  draws <- (min(cor,incor, none, na.rm=TRUE))
  if (none == 10) {
    epd <- NA 
  } else if (sum(none, cor, incor, na.rm = TRUE) == 11) {
      epd <- NA
      } else if (students2_beadsGA[i,(choices[draws])] == 1) {
    epd <- students2_beadsGA[i,(choices[draws])-1]
  } else if (students2_beadsGA[i,(choices[draws])] == -1) {
    epd <- students2_beadsGA[i,(choices[draws])-2]
  }
  if (draws == 11) {
    cad <- 10
    } else {cad <- draws}
  cad <- as.numeric((length(unique(as.numeric(DtD[i,cad:10])))-1)>0)
  if (draws == 11) {
    cad <- NA
    draws <- NA
    }
  garety <- rbind(garety, cbind(draws, epd, cad))
}
### Merge with data
students2_beadsGA <- cbind(students2_beadsGA, garety)
### Removal of duplicates & NA's
students2_beadsGA <- students2_beadsGA[!duplicated(students2_beadsGA$ID),]
students2_beadsGA <- students2_beadsGA[as.logical(rowSums(is.na(students2_beadsGA))!=23),]
### Remove redundant variables
students2_beadsGA <- students2_beadsGA[,-c(2:31)]
## Hamburg variant
### Creates three variables, DtD (Draw to Decision; first choice), EPD (Estimated Probability at
### Decision), CAD (Change after Decision; choosing something else after first decision; yes/no)
choices <- c(5,9,13,17,21,25,29,33,37,41)
DtD <- students2_beadsHH[,c(choices)]
hh <- NULL
for (i in 1:nrow(DtD)) {
  cor <- match(1,DtD[i,])
  incor <- match(-1,DtD[i,])
  none <- sum(grepl(0, DtD[i,]))
  if (none == 10) {
    cor <- 11
    incor <- 11 } else {
      none <- 11}
  draws <- (min(cor,incor, none, na.rm=TRUE))
  if (none == 10) {
    epd <- NA 
  } else if (sum(none, cor, incor, na.rm = TRUE) == 11) {
    epd <- NA
  } else if (students2_beadsHH[i,(choices[draws])] == 1) {
    epd <- students2_beadsHH[i,(choices[draws])-1]
  } else if (students2_beadsHH[i,(choices[draws])] == -1) {
    epd <- students2_beadsHH[i,(choices[draws])-2]
  }
  if (draws == 11) {
    cad <- 10
  } else {cad <- draws}
  cad <- as.numeric((length(unique(as.numeric(DtD[i,cad:10])))-1)>0)
  if (draws == 11) {
    cad <- NA
    draws <- NA
  }
  hh <- rbind(hh, cbind(draws, epd, cad))
}
### Merge with data
students2_beadsHH <- cbind(students2_beadsHH, hh)
### Removal of duplicates & NA's
students2_beadsHH <- students2_beadsHH[!duplicated(students2_beadsHH$ID),]
students2_beadsHH <- students2_beadsHH[as.logical(rowSums(is.na(students2_beadsHH))!=23),]
### Remove redundant variables
students2_beadsHH <- students2_beadsHH[,-c(2:41)]
## Merge data sets
students2_beads <- merge(students2_beadsGA, students2_beadsHH,
                         by = 1, all.x = TRUE, all.y = TRUE)
## Collect into same columns
students2_beads[is.na(students2_beads$draws.x),2] <- students2_beads[is.na(students2_beads$draws.x),5]
students2_beads[is.na(students2_beads$epd.x),3] <- students2_beads[is.na(students2_beads$epd.x),6]
students2_beads[is.na(students2_beads$cad.x),4] <- students2_beads[is.na(students2_beads$cad.x),7]
## Remove redundant variables
students2_beads <- students2_beads[,-c(5,6,7)]
## Rename variables
colnames(students2_beads) <- c("ID","beadsDtD","beadsEPD","beadsCAD")

# Merging data across tasks
qualtrics_students_2 <- merge(students2_misc, students2_cond, by = 1, all = TRUE)
qualtrics_students_2 <- merge(qualtrics_students_2, students2_risk, by = 1, all = TRUE)
qualtrics_students_2 <- merge(qualtrics_students_2, students2_mood, by = 1, all = TRUE)
qualtrics_students_2 <- merge(qualtrics_students_2, students2_ius, by = 1, all = TRUE)
qualtrics_students_2 <- merge(qualtrics_students_2, students2_fdc, by = 1, all = TRUE)
qualtrics_students_2 <- merge(qualtrics_students_2, students2_beads, by = 1, all = TRUE)
qualtrics_students_2 <- merge(qualtrics_students_2, students2_ellsAmbtol, by = 1, all = TRUE)
qualtrics_students_2 <- merge(qualtrics_students_2, students2_ellsDyn, by = 1, all = TRUE)
qualtrics_students_2 <- merge(qualtrics_students_2, students2_ellsStat, by = 1, all = TRUE)
qualtrics_students_2 <- merge(qualtrics_students_2, students2_ellsAgency, by = 1, all = TRUE)
qualtrics_students_2 <- merge(qualtrics_students_2, students2_ellsRand, by = 1, all = TRUE)
qualtrics_students_2 <- merge(qualtrics_students_2, students2_ellsFam, by = 1, all = TRUE)
qualtrics_students_2 <- merge(qualtrics_students_2, students2_boxDiff, by = 1, all = TRUE)
qualtrics_students_2 <- merge(qualtrics_students_2, students2_beadsDiff, by = 1, all = TRUE)
qualtrics_students_2 <- merge(qualtrics_students_2, students2_diceDiff, by = 1, all = TRUE)
qualtrics_students_2 <- merge(qualtrics_students_2, students2_diceWL, by = 1, all = TRUE)
qualtrics_students_2 <- merge(qualtrics_students_2, students2_nfc, by = 1, all.x = TRUE)
qualtrics_students_2 <- merge(qualtrics_students_2, students2_cape, by = 1, all = TRUE)

# Simplified summary file
qualtrics_students_2_summary <- qualtrics_students_2[,-c(4,7,32:35)]

# Write to CSV
write.csv(qualtrics_students_2, "data/processed/qualtrics_students_2_full.csv")
write.csv(qualtrics_students_2_summary, "data/processed/qualtrics_students_2_summary.csv")

# Write meta
write.csv(metaQualtrics, "data/processed/meta_qualtrics.csv")