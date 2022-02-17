####################################################################################################
# Extracts and summarises Jatos data (Prolific, Students, and Hamburg)                             #
# Input: Jatos raw data                                                                            #
# Output: Csv-files containing extracted data (full), and summary-data                             #
# Kristoffer Klevjer - github.com/klvr - klevjer(a)gmail.com                                       #
####################################################################################################

# 00 Preparation -----------------------------------------------------------------------------------

# Clean up workspare
rm(list = ls())

# Source own functions
for (i in list.files("src/functions", full.names = TRUE)) {source(i)}

# 01 Load data -------------------------------------------------------------------------------------

# TEMP SOLUTION UNTIL JATOS EXTRACTION IS FIXED

# Load data files
jatos_prolific_1 <- read.csv("data/temp/jatos_prolific_1.csv")
jatos_prolific_2 <- read.csv("data/temp/jatos_prolific_2.csv")
jatos_students <- read.csv("data/temp/jatos_students.csv")
jatos_hamburg <- read.csv("data/temp/jatos_hamburg.csv")

# 02 Clean data ------------------------------------------------------------------------------------

jatos_prolific_1 <- jatos_prolific_1[,-c(1,3)]
jatos_prolific_2 <- jatos_prolific_2[,-c(1,3)]
jatos_students <- jatos_students[,-c(1,3)]
jatos_hamburg <- jatos_hamburg[,-c(1,3)]

diceDtDOverall <- rowSums(jatos_prolific_1[,c(3,8,13,18,23,28,33,38)])
diceDtD1 <- rowSums(jatos_prolific_1[,c(3,8,13,18)])
diceDtD2 <- rowSums(jatos_prolific_1[,c(23,28,33,38)])
diceDtDPreOverall <- rowSums(jatos_prolific_1[,c(3,8,23)])
diceDtDLoadOverall <- rowSums(jatos_prolific_1[,c(13,28)])
diceDtDPostOverall <- rowSums(jatos_prolific_1[,c(18,33,38)])
diceDtDPre1 <- rowSums(jatos_prolific_1[,c(3,8)])
diceDtDLoad1 <- jatos_prolific_1[,13]
diceDtDPost1 <- jatos_prolific_1[,18]
diceDtDPre2 <- jatos_prolific_1[,23]
diceDtDLoad2 <- jatos_prolific_1[,28]
diceDtDPost2 <- rowSums(jatos_prolific_1[,c(33,38)])
diceChoice1 <- as.numeric(jatos_prolific_1[,44]==2)
diceChoice2 <- as.numeric(jatos_prolific_1[,45]==1)
diceChoiceOverall <- (diceChoice1+diceChoice2)
jatos_prolific_1 <- cbind(jatos_prolific_1[,1], diceDtDOverall, diceDtD1, diceDtD2, diceDtDPreOverall, diceDtDLoadOverall,
                          diceDtDPostOverall, diceDtDPre1, diceDtDLoad1, diceDtDPost1, diceDtDPre2,
                          diceDtDLoad2, diceDtDPost2, diceChoiceOverall, diceChoice1, diceChoice2)

diceDtDOverall <- rowSums(jatos_prolific_2[,c(3,8,13,18,23,28,33,38)])
diceDtD1 <- rowSums(jatos_prolific_2[,c(3,8,13,18)])
diceDtD2 <- rowSums(jatos_prolific_2[,c(23,28,33,38)])
diceDtDPreOverall <- rowSums(jatos_prolific_2[,c(3,8,23)])
diceDtDLoadOverall <- rowSums(jatos_prolific_2[,c(13,28)])
diceDtDPostOverall <- rowSums(jatos_prolific_2[,c(18,33,38)])
diceDtDPre1 <- rowSums(jatos_prolific_2[,c(3,8)])
diceDtDLoad1 <- jatos_prolific_2[,13]
diceDtDPost1 <- jatos_prolific_2[,18]
diceDtDPre2 <- jatos_prolific_2[,23]
diceDtDLoad2 <- jatos_prolific_2[,28]
diceDtDPost2 <- rowSums(jatos_prolific_2[,c(33,38)])
diceChoice1 <- as.numeric(jatos_prolific_2[,44]==2)
diceChoice2 <- as.numeric(jatos_prolific_2[,45]==1)
diceChoiceOverall <- (diceChoice1+diceChoice2)
jatos_prolific_2 <- cbind(jatos_prolific_2[,1], diceDtDOverall, diceDtD1, diceDtD2, diceDtDPreOverall, diceDtDLoadOverall,
                          diceDtDPostOverall, diceDtDPre1, diceDtDLoad1, diceDtDPost1, diceDtDPre2,
                          diceDtDLoad2, diceDtDPost2, diceChoiceOverall, diceChoice1, diceChoice2)
jatos_prolific <- rbind(jatos_prolific_1, jatos_prolific_2)

diceDtDOverall <- rowSums(jatos_students[,c(3,8,13,18,23,28,33,38)])
diceDtD1 <- rowSums(jatos_students[,c(3,8,13,18)])
diceDtD2 <- rowSums(jatos_students[,c(23,28,33,38)])
diceDtDPreOverall <- rowSums(jatos_students[,c(3,8,23)])
diceDtDLoadOverall <- rowSums(jatos_students[,c(13,28)])
diceDtDPostOverall <- rowSums(jatos_students[,c(18,33,38)])
diceDtDPre1 <- rowSums(jatos_students[,c(3,8)])
diceDtDLoad1 <- jatos_students[,13]
diceDtDPost1 <- jatos_students[,18]
diceDtDPre2 <- jatos_students[,23]
diceDtDLoad2 <- jatos_students[,28]
diceDtDPost2 <- rowSums(jatos_students[,c(33,38)])
diceChoice1 <- as.numeric(jatos_students[,44]==2)
diceChoice2 <- as.numeric(jatos_students[,45]==1)
diceChoiceOverall <- (diceChoice1+diceChoice2)
jatos_students <- cbind(jatos_students[,1], diceDtDOverall, diceDtD1, diceDtD2, diceDtDPreOverall, diceDtDLoadOverall,
                          diceDtDPostOverall, diceDtDPre1, diceDtDLoad1, diceDtDPost1, diceDtDPre2,
                          diceDtDLoad2, diceDtDPost2, diceChoiceOverall, diceChoice1, diceChoice2)

diceDtDOverall <- rowSums(jatos_hamburg[,c(3,8,13,18,23,28,33,38)])
diceDtD1 <- rowSums(jatos_hamburg[,c(3,8,13,18)])
diceDtD2 <- rowSums(jatos_hamburg[,c(23,28,33,38)])
diceDtDPreOverall <- rowSums(jatos_hamburg[,c(3,8,23)])
diceDtDLoadOverall <- rowSums(jatos_hamburg[,c(13,28)])
diceDtDPostOverall <- rowSums(jatos_hamburg[,c(18,33,38)])
diceDtDPre1 <- rowSums(jatos_hamburg[,c(3,8)])
diceDtDLoad1 <- jatos_hamburg[,13]
diceDtDPost1 <- jatos_hamburg[,18]
diceDtDPre2 <- jatos_hamburg[,23]
diceDtDLoad2 <- jatos_hamburg[,28]
diceDtDPost2 <- rowSums(jatos_hamburg[,c(33,38)])
diceChoice1 <- as.numeric(jatos_hamburg[,44]==2)
diceChoice2 <- as.numeric(jatos_hamburg[,45]==1)
diceChoiceOverall <- (diceChoice1+diceChoice2)
jatos_hamburg <- cbind(jatos_hamburg[,1], diceDtDOverall, diceDtD1, diceDtD2, diceDtDPreOverall, diceDtDLoadOverall,
                        diceDtDPostOverall, diceDtDPre1, diceDtDLoad1, diceDtDPost1, diceDtDPre2,
                        diceDtDLoad2, diceDtDPost2, diceChoiceOverall, diceChoice1, diceChoice2)

jatos_hamburg <- as.data.frame(jatos_hamburg)
jatos_prolific <- as.data.frame(jatos_prolific)
jatos_students <- as.data.frame(jatos_students)
oldNameVar <- "V1"
newNameVar <- "ID"
names(jatos_hamburg)[names(jatos_hamburg) == oldNameVar] <- newNameVar
names(jatos_prolific)[names(jatos_prolific) == oldNameVar] <- newNameVar
names(jatos_students)[names(jatos_students) == oldNameVar] <- newNameVar

qualtrics_students <- read.csv("data/processed/qualtrics_students_summary.csv")[,-1]
qualtrics_prolific <- read.csv("data/processed/qualtrics_prolific_summary.csv")[,-1]

students <- merge(qualtrics_students, jatos_students, all = TRUE, by = "ID")
prolific <- merge(qualtrics_prolific, jatos_prolific, all = TRUE, by = "ID")

write.csv(students, "data/temp/students.csv")
write.csv(prolific, "data/temp/prolific.csv")
write.csv(jatos_hamburg, "data/temp/hamburg.csv")