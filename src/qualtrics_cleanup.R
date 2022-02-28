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
metaQualtrics <- NULL

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
metaQualtrics <- rbind(metaQualtrics, c(sum(consentProlific == FALSE), "no consent", "Prolific"))

# Remove non-completed entries
completionProlific <- qualtrics_prolific$finished == "True"
qualtrics_prolific <- qualtrics_prolific[completionProlific,]
metaQualtrics <- rbind(metaQualtrics, c(sum(completionProlific== FALSE), "not completed",
                                        "Prolific"))

# 03 Prepare Students_1 data ------------------------------------------------------------------------

# Remove item description row
qualtrics_students_1 <- qualtrics_students_1_a[-1,]
qualtrics_students_2 <- qualtrics_students_1_b[-1,]
qualtrics_students_3 <- qualtrics_students_1_c[-1,]

# Remove pilot/technical-pilot data
pilotStudents <- qualtrics_students_1$distributionChannel == "preview"
qualtrics_students_1 <- qualtrics_students_1[!pilotStudents,]
pilotStudents <- qualtrics_students_2$distributionChannel == "preview"
qualtrics_students_2 <- qualtrics_students_2[!pilotStudents,]

# Remove non-consent participants
consentStudents <- qualtrics_students_1$QID51 ==
  "I am willing to participate in the research project."
qualtrics_students_1 <- qualtrics_students_1[consentStudents,]
metaQualtrics <- rbind(metaQualtrics, c(sum(consentStudents == FALSE), "no consent", "Students_1"))

# Remove (self-)terminated runs (due to being on mobile)
mobileStudents <- qualtrics_students_1$QID113 == 
  "Yes, and I'm not using Safari"
qualtrics_students_1 <- qualtrics_students_1[mobileStudents,]
metaQualtrics <- rbind(metaQualtrics, c(sum(mobileStudents == FALSE), "on mobile", "Students_1"))

# Remove aborted runs (all data missing from ID and out)
abortedStudents <- as.numeric(qualtrics_students_1$QID58_TEXT) > 1
qualtrics_students_1 <- qualtrics_students_1[!is.na(abortedStudents),]

# Manual removal of test-data (recorded date prior to sending out the study invite)
qualtrics_students_1 <- qualtrics_students_1[-c(1:4),]
qualtrics_students_2 <- qualtrics_students_2[-c(1:3),]
qualtrics_students_3 <- qualtrics_students_3[-1,]

# 04 Prepare Students_2 data -----------------------------------------------------------------------

# Remove item description rows
qualtrics_students_2_a <- qualtrics_students_2_a[-c(1,2),]
qualtrics_students_2_b <- qualtrics_students_2_b[-c(1,2),]
qualtrics_students_2_c <- qualtrics_students_2_c[-c(1,2),]
qualtrics_students_2_nfc <- qualtrics_students_2_nfc[-c(1,2),]

# Remove pilot/technical-pilot data
pilotStudents2 <- qualtrics_students_2_a$DistributionChannel == "preview"
qualtrics_students_2_a <- qualtrics_students_2_a[!pilotStudents2,]
pilotStudents2 <- qualtrics_students_2_b$DistributionChannel == "preview"
qualtrics_students_2_b <- qualtrics_students_2_b[!pilotStudents2,]
pilotStudents2 <- qualtrics_students_2_c$DistributionChannel == "preview"
qualtrics_students_2_c <- qualtrics_students_2_c[!pilotStudents2,]

# Remove non-consent participants
consentStudents2 <- qualtrics_students_2_a$consent2.== 
  "I am willing to participate in the research project."
qualtrics_students_2_a <- qualtrics_students_2_a[consentStudents2,]
metaQualtrics <- rbind(metaQualtrics, c(sum(consentStudents2 == FALSE), "no consent", "Students_2"))

# Remove (self-)terminated runs (due to being on mobile)
mobileStudents2 <- qualtrics_students_2_a$browser1. == "Yes, and I'm not using Safari"
qualtrics_students_2_a <- qualtrics_students_2_a[mobileStudents2,]
metaQualtrics <- rbind(metaQualtrics, c(sum(mobileStudents2== FALSE), "on mobile", "Students_2"))

# Remove aborted runs (all data missing from ID and out)
abortedStudents2 <- qualtrics_students_2_a$FL_5_DO > 1
qualtrics_students_2_a <- qualtrics_students_2_a[abortedStudents2,]

# Make sure ID's are identical across all ID catching variables
## If not, set up a data-frame for matching
sameID <- cbind(qualtrics_students_2_a[,c(13,16,17,18)], 
                qualtrics_students_2_a[,13] == qualtrics_students_2_a[,16], 
                qualtrics_students_2_a[,16] == qualtrics_students_2_a[,17], 
                qualtrics_students_2_a[,17] == qualtrics_students_2_a[,18])
## Manual inspection gives two non-identical instances:
### '6519' responded 'okay' rather than repeating ID, not change needed.
### '6783' responded '1867' in one instance. Look for this ID (1867) in other tasks

# 05 Removal of unnecessary & empty variables ------------------------------------------------------

qualtrics_prolific <- qualtrics_prolific[,-c(1:11,14:16)]
qualtrics_students_1 <- qualtrics_students_1[,-c(1:16,19:21,26,27,309:351,356,357)]
qualtrics_students_2 <- qualtrics_students_2[,-c(1:30,333:353)]
qualtrics_students_3 <- qualtrics_students_3[,-c(1:17)]
qualtrics_students_2_a <- qualtrics_students_2_a[,-c(1:12,16:20)]
qualtrics_students_2_b <- qualtrics_students_2_b[,-c(1:10)]
qualtrics_students_2_c <- qualtrics_students_2_c[,-c(1:10)]

# Remove all variables but NFC from qualtrics_students_2_nfc
## This data was collected during a seperate experiment from someone else
qualtrics_students_2_nfc <- qualtrics_students_2_nfc[,c(13,93:110)]

# 06 Set-up meta-data files ------------------------------------------------------------------------

metaQualtrics <- as.data.frame(metaQualtrics)
colnames(metaQualtrics) <- c("N affected", "Reason", "Sample pool")

# 07 Saving of temp-data and meta-data -------------------------------------------------------------

# Saving temp files
write.csv(qualtrics_prolific, file = "data/temp/qualtrics_prolific_temp.csv", row.names = FALSE)
write.csv(qualtrics_students_1, file = "data/temp/qualtrics_students_1_a_temp.csv", row.names = FALSE)
write.csv(qualtrics_students_2, file = "data/temp/qualtrics_students_1_b_temp.csv", row.names = FALSE)
write.csv(qualtrics_students_3, file = "data/temp/qualtrics_students_1_c_temp.csv", row.names = FALSE)
write.csv(qualtrics_students_2_a, file = "data/temp/qualtrics_students_2_a_temp.csv", row.names = FALSE)
write.csv(qualtrics_students_2_b, file = "data/temp/qualtrics_students_2_b_temp.csv", row.names = FALSE)
write.csv(qualtrics_students_2_c, file = "data/temp/qualtrics_students_2_c_temp.csv", row.names = FALSE)
write.csv(qualtrics_students_2_nfc, file = "data/temp/qualtrics_students_2_nfc_temp.csv", row.names = FALSE)

# Saving meta files
write.csv(metaQualtrics, file = "data/processed/meta_qualtrics-cleanup.csv", row.names = FALSE)
write.csv(metaQualtrics, file = "data/temp/meta_qualtrics.csv", row.names = FALSE)
