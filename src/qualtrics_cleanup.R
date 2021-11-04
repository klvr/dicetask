####################################################################################################
# Removes redundant data, variables and other thrash from the qualtrics raw files                  #
# Input: Qualtrics raw data                                                                        #
# Output: Cleaner csv-files in temp, to subsequently do data extracted from                        #
# Meta-output: Outputs a meta-file on relevant data removed (e.g., due to no consent)              #
# Kristoffer Klevjer - github.com/klvr - klevjer(a)gmail.com                                       #
####################################################################################################

# 00 Preparation -----------------------------------------------------------------------------------

# Clean up workspare
rm(list = ls())

# Set up meta file to capture data removal
metaProlific <- NULL
metaStudents <- NULL

# 01 Load raw data ---------------------------------------------------------------------------------

# Get paths and names of all qualtrics raw data files
listRawFiles <- list.files("data/raw/", pattern = "qualtrics", recursive = TRUE)
pathRawFiles <- paste("data/raw/", listRawFiles, sep = "")
nameRawFiles <- unlist(strsplit(basename(listRawFiles), split = ".csv"))

# Save as data frames
for (i in 1:length(nameRawFiles)) {
  assign(nameRawFiles[i], read.csv(pathRawFiles[i]))
}

# 02 Prepare Prolific data -------------------------------------------------------------------------

# Remove item description row
qualtrics_prolific <- qualtrics_prolific[-1,]

# Remove non-consent participants
consentProlific <- qualtrics_prolific$QID74 != 
  "No, I am not willing to participate; one or more statement does not apply to me."
qualtrics_prolific <- qualtrics_prolific[consentProlific,]
metaProlific <- rbind(metaProlific, c(sum(consentProlific == FALSE), "no consent"))

# Remove non-completed entries
completionProlific <- qualtrics_prolific$finished == "True"
qualtrics_prolific <- qualtrics_prolific[completionProlific,]
metaProlific <- rbind(metaProlific, c(sum(completionProlific== FALSE), "not completed"))

# 03 Prepare Students data ------------------------------------------------------------------------

# Remove item description row
qualtrics_students_1 <- qualtrics_students_1[-1,]
qualtrics_students_2 <- qualtrics_students_2[-1,]
qualtrics_students_3 <- qualtrics_students_3[-1,]

# Remove pilot/technical-pilot data
pilotStudents <- qualtrics_students_1$distributionChannel == "preview"
qualtrics_students_1 <- qualtrics_students_1[!pilotStudents,]
pilotStudents <- qualtrics_students_2$distributionChannel == "preview"
qualtrics_students_2 <- qualtrics_students_2[!pilotStudents,]

# Remove non-consent participants
consentStudents <- qualtrics_students_1$QID51 ==
  "I am willing to participate in the research project."
qualtrics_students_1 <- qualtrics_students_1[consentStudents,]
metaStudents <- rbind(metaStudents, c(sum(consentStudents == FALSE), "no consent"))

# Remove (self-)terminated runs (due to being on mobile)
mobileStudents <- qualtrics_students_1$QID113 == 
  "Yes, and I'm not using Safari"
qualtrics_students_1 <- qualtrics_students_1[mobileStudents,]
metaStudents <- rbind(metaStudents, c(sum(mobileStudents == FALSE), "on mobile"))

# Remove aborted runs (all data missing from ID and out)
abortedStudents <- as.numeric(qualtrics_students_1$QID58_TEXT) > 1
qualtrics_students_1 <- qualtrics_students_1[!is.na(abortedStudents),]

# Manual removal of test-data (recorded date prior to sending out the study invite)
qualtrics_students_1 <- qualtrics_students_1[-c(1:4),]
qualtrics_students_2 <- qualtrics_students_2[-c(1:3),]
qualtrics_students_3 <- qualtrics_students_3[-1,]

# 04 Removal of unnecessary & empty variables ------------------------------------------------------

qualtrics_prolific <- qualtrics_prolific[,-c(1:11,14:16)]
qualtrics_students_1 <- qualtrics_students_1[,-c(1:16,19:21,26,27,309:351,356,357)]
qualtrics_students_2 <- qualtrics_students_2[,-c(1:30,333:353)]
qualtrics_students_3 <- qualtrics_students_3[,-c(1:17)]

# 05 Set-up meta-data files ------------------------------------------------------------------------

metaProlific <- as.data.frame(metaProlific)
metaStudents <- as.data.frame(metaStudents)
colnames(metaProlific) <- c("removed", "reason")
colnames(metaStudents) <- c("removed", "reason")

# 06 Saving of temp-data and meta-data -------------------------------------------------------------

# Saving temp files
write.csv(qualtrics_prolific, file = "data/temp/qualtrics_prolific.csv", row.names = FALSE)
write.csv(qualtrics_students_1, file = "data/temp/qualtrics_students_1.csv", row.names = FALSE)
write.csv(qualtrics_students_2, file = "data/temp/qualtrics_students_2.csv", row.names = FALSE)
write.csv(qualtrics_students_3, file = "data/temp/qualtrics_students_3.csv", row.names = FALSE)

# Saving meta files
write.csv(metaProlific, file = "data/processed/meta_prolific.csv", row.names = FALSE)
write.csv(metaStudents, file = "data/processed/meta_students.csv", row.names = FALSE)
