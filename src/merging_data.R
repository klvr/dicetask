####################################################################################################
# Merges data form all sources for article 2 (experiment 1 and 2)                                  #
# Input: CSV file from jatos_extraction.R (dice-task)                                              #
#        CSV file from pavlovia_extraction.R (box-task)                                            #
#        CSV file from qualtrics_extraction.R (qualtrics form; requires qualtrics_cleanup.R first) #
# Output: CSV-files containing merged data - For analyses use                                      #
# Kristoffer Klevjer - github.com/klvr - klevjer(a)gmail.com                                       #
####################################################################################################

# 00 Preparation -----------------------------------------------------------------------------------

# Clean up workspare
rm(list = ls())

# Source own functions
for (i in list.files("src/functions", full.names = TRUE)) {source(i)}

# 01 Load data & minor fixes -----------------------------------------------------------------------

# Dice task: Uses summary-file, which has variables calculated without prespecified TrialDtD =< 8
#            This can be adjusted in the extraction script, and read about how many affected there
#            are in the meta_dice-task file (data/processed/)
dice_all <- read.csv("data/processed/dice-task_students_summary.csv")

# Box task: Uses the full file, and then removes the redundant variables, so contains both the
#           variables where trial DtD = 1 is excluded (trial-wise) as denoted 'E' at the end,
#           and the variables with everything included.
box_students_2 <- read.csv("data/processed/box-task_students_full.csv")
box_students_2 <- box_students_2[,-c(15:18)] # Removes logical-removal variables (not informative)

# Qualtrics: Uses the full files, with some redundant data removed
qualtrics_students_1 <- read.csv("data/processed/qualtrics_students_1_full.csv")
qualtrics_students_2 <- read.csv("data/processed/qualtrics_students_2_full.csv")
## Remove non-informative variables
qualtrics_students_1 <- qualtrics_students_1[,-1]
qualtrics_students_2 <- qualtrics_students_2[,-1]
## Remove variables not used in this project nor analyses
qualtrics_students_1 <- qualtrics_students_1[,-c(2,5,7, 12:23, 29:32,49,50)]
qualtrics_students_2 <- qualtrics_students_2[,-c(4,32:35)]

# Fix two variable names
colnames(dice_all)[1] <- "ID"
colnames(box_students_2)[1] <- "ID"

# 02 Merge data ------------------------------------------------------------------------------------

# Merge data for article 2 - experiment 1
article2_experiment1 <- dice_all[dice_all$diceMetaStudyID==210,]
article2_experiment1 <- merge(article2_experiment1, qualtrics_students_1, by = 1, all = TRUE)
## Remove session ID
article2_experiment1 <- article2_experiment1[,-2]

# Merge data for article 2 - experiment 2
article2_experiment2 <- dice_all[dice_all$diceMetaStudyID==359,]
article2_experiment2[article2_experiment2$ID==1867,1] <- 6783 # One participant mistyped their ID
article2_experiment2 <- merge(article2_experiment2, box_students_2, by = 1, all = TRUE)
article2_experiment2 <- merge(article2_experiment2, qualtrics_students_2, by = 1, all = TRUE)
## Remove session ID
article2_experiment2 <- article2_experiment2[,-2]

# 03 Output data to CSV ----------------------------------------------------------------------------

# Write to CSV
write.csv(article2_experiment1, "data/processed/article2_experiment1.csv", row.names = FALSE)
write.csv(article2_experiment2, "data/processed/article2_experiment2.csv", row.names = FALSE)