#Data-extraction Dice-task

##2-do
#Must add "componentPos" in pattern-matching, so meta-data doesn't get matched by accident

#Load files
filepath <- paste(getwd(), "/data/", sep="")
files <- paste(filepath, list.files(filepath), sep="")

#Read file-by-file
if(length(files)>0){
  file <- read.delim(files[1], header = FALSE)
  cases <- grep(pattern="studyId:", file[,1])
  cases <- c(cases, nrow(file))
  
  #Read participant-by-participant
  if(length(cases)>1){
    participant <- as.data.frame(file[cases[1]:(cases[2]-1),1])
    participant[,1] <- as.character(participant[,1])

    #StudyID
    studyid <- strsplit(strsplit(participant[,1], split = "*studyId:")[[1]][2], split =",")[[1]][1]

    #QualtricsID
    qualtricsid <- strsplit(strsplit(participant[,1], split = "*qualtricsID: ")[[1]][2], split =",")[[1]][1]

    #Trial1
    #Pre-collection1
      precoll1 <- strsplit(strsplit(participant[grep(pattern = "componentPos:3,", x = participant[,1]),1], split = "value:")[[1]][2], split = "^")[[1]][1]
    #Dice1
      Dice1DtD <- length(regmatches(grep("[0-9]",strsplit(participant[grep(pattern = "componentPos:4,", x = participant[,1]),1], split = "color:")[[1]][2], value = TRUE), gregexpr("[[:digit:]]+", grep("[0-9]",strsplit(participant[grep(pattern = "componentPos:4,", x = participant[,1]),1], split = "color:")[[1]][2], value = TRUE)))[[1]])
      Dice1Col <- strsplit(strsplit(participant[grep(pattern = "componentPos:4,", x = participant[,1]),1], split = "color:")[[1]][2], split = ",sequence")[[1]][1]
      Dice1Load <- strsplit(strsplit(participant[grep(pattern = "componentPos:5,", x = participant[,1]),1], split = "q1,value:")[[1]][2], split = "^")[[1]][1]
      Dice1LoadCert <- strsplit(strsplit(participant[grep(pattern = "componentPos:5,", x = participant[,1]),1], split = "q2,value:")[[1]][2], split = "^")[[1]][1]
      if(Dice1LoadCert == 1){Dice1LoadCert2 <- strsplit(strsplit(participant[grep(pattern = "componentPos:5,", x = participant[,1]),1], split = "q2,value:")[[1]][2], split = "^")[[1]][2]}
      if(Dice1LoadCert == 1){if(Dice1LoadCert2 == 0){Dice1LoadCert <- paste(as.numeric(Dice1LoadCert), as.numeric(Dice1LoadCert2), sep="")}}
      if(Dice1Load == 0){Dice1LoadWhat <- strsplit(strsplit(participant[grep(pattern = "componentPos:5,", x = participant[,1]),1], split = "q3,value:")[[1]][2], split = "^")[[1]][1]}else{Dice1LoadWhat <- "9"}
    #Dice2
      Dice2DtD <- length(regmatches(grep("[0-9]",strsplit(participant[grep(pattern = "componentPos:6,", x = participant[,1]),1], split = "color:")[[1]][2], value = TRUE), gregexpr("[[:digit:]]+", grep("[0-9]",strsplit(participant[grep(pattern = "componentPos:6,", x = participant[,1]),1], split = "color:")[[1]][2], value = TRUE)))[[1]])
      Dice2Col <- strsplit(strsplit(participant[grep(pattern = "componentPos:6,", x = participant[,1]),1], split = "color:")[[1]][2], split = ",sequence")[[1]][1]
      Dice2Load <- strsplit(strsplit(participant[grep(pattern = "componentPos:7,", x = participant[,1]),1], split = "q1,value:")[[1]][2], split = "^")[[1]][1]
      Dice2LoadCert <- strsplit(strsplit(participant[grep(pattern = "componentPos:7,", x = participant[,1]),1], split = "q2,value:")[[1]][2], split = "^")[[1]][1]
      if(Dice2LoadCert == 1){Dice2LoadCert2 <- strsplit(strsplit(participant[grep(pattern = "componentPos:7,", x = participant[,1]),1], split = "q2,value:")[[1]][2], split = "^")[[1]][2]}
      if(Dice2LoadCert == 1){if(Dice2LoadCert2 == 0){Dice2LoadCert <- paste(as.numeric(Dice2LoadCert), as.numeric(Dice2LoadCert2), sep="")}}
      if(Dice2Load == 0){Dice2LoadWhat <- strsplit(strsplit(participant[grep(pattern = "componentPos:7,", x = participant[,1]),1], split = "q3,value:")[[1]][2], split = "^")[[1]][1]}else{Dice2LoadWhat <- "9"}
    #Dice3
      Dice3DtD <- length(regmatches(grep("[0-9]",strsplit(participant[grep(pattern = "componentPos:8,", x = participant[,1]),1], split = "color:")[[1]][2], value = TRUE), gregexpr("[[:digit:]]+", grep("[0-9]",strsplit(participant[grep(pattern = "componentPos:8,", x = participant[,1]),1], split = "color:")[[1]][2], value = TRUE)))[[1]])
      Dice3Col <- strsplit(strsplit(participant[grep(pattern = "componentPos:8,", x = participant[,1]),1], split = "color:")[[1]][2], split = ",sequence")[[1]][1]
      Dice3Load <- strsplit(strsplit(participant[grep(pattern = "componentPos:9,", x = participant[,1]),1], split = "q1,value:")[[1]][2], split = "^")[[1]][1]
      Dice3LoadCert <- strsplit(strsplit(participant[grep(pattern = "componentPos:9,", x = participant[,1]),1], split = "q2,value:")[[1]][2], split = "^")[[1]][1]
      if(Dice3LoadCert == 1){Dice3LoadCert2 <- strsplit(strsplit(participant[grep(pattern = "componentPos:9,", x = participant[,1]),1], split = "q2,value:")[[1]][2], split = "^")[[1]][2]}
      if(Dice3LoadCert == 1){if(Dice3LoadCert2 == 0){Dice3LoadCert <- paste(as.numeric(Dice3LoadCert), as.numeric(Dice3LoadCert2), sep="")}}
      if(Dice3Load == 0){Dice3LoadWhat <- strsplit(strsplit(participant[grep(pattern = "componentPos:9,", x = participant[,1]),1], split = "q3,value:")[[1]][2], split = "^")[[1]][1]}else{Dice3LoadWhat <- "9"}
    #Dice4
      Dice4DtD <- length(regmatches(grep("[0-9]",strsplit(participant[grep(pattern = "componentPos:10,", x = participant[,1]),1], split = "color:")[[1]][2], value = TRUE), gregexpr("[[:digit:]]+", grep("[0-9]",strsplit(participant[grep(pattern = "componentPos:10,", x = participant[,1]),1], split = "color:")[[1]][2], value = TRUE)))[[1]])
      Dice4Col <- strsplit(strsplit(participant[grep(pattern = "componentPos:10,", x = participant[,1]),1], split = "color:")[[1]][2], split = ",sequence")[[1]][1]
      Dice4Load <- strsplit(strsplit(participant[grep(pattern = "componentPos:11,", x = participant[,1]),1], split = "q1,value:")[[1]][2], split = "^")[[1]][1]
      Dice4LoadCert <- strsplit(strsplit(participant[grep(pattern = "componentPos:11,", x = participant[,1]),1], split = "q2,value:")[[1]][2], split = "^")[[1]][1]
      if(Dice4LoadCert == 1){Dice4LoadCert2 <- strsplit(strsplit(participant[grep(pattern = "componentPos:11,", x = participant[,1]),1], split = "q2,value:")[[1]][2], split = "^")[[1]][2]}
      if(Dice4LoadCert == 1){if(Dice4LoadCert2 == 0){Dice4LoadCert <- paste(as.numeric(Dice4LoadCert), as.numeric(Dice4LoadCert2), sep="")}}
      if(Dice4Load == 0){Dice4LoadWhat <- strsplit(strsplit(participant[grep(pattern = "componentPos:11,", x = participant[,1]),1], split = "q3,value:")[[1]][2], split = "^")[[1]][1]}else{Dice4LoadWhat <- "9"}
    #Final choice
      Trial1LoadedDice <- strsplit(strsplit(participant[grep(pattern = "componentPos:12,", x = participant[,1]),1], split = "value:")[[1]][2], split = "^")[[1]][1]

    #Trial2
    #Pre-collection2
      precoll2 <- strsplit(strsplit(participant[grep(pattern = "componentPos:14,", x = participant[,1]),1], split = "value:")[[1]][2], split = "^")[[1]][1]
    #Dice5
      Dice5DtD <- length(regmatches(grep("[0-9]",strsplit(participant[grep(pattern = "componentPos:15,", x = participant[,1]),1], split = "color:")[[1]][2], value = TRUE), gregexpr("[[:digit:]]+", grep("[0-9]",strsplit(participant[grep(pattern = "componentPos:15,", x = participant[,1]),1], split = "color:")[[1]][2], value = TRUE)))[[1]])
      Dice5Col <- strsplit(strsplit(participant[grep(pattern = "componentPos:15,", x = participant[,1]),1], split = "color:")[[1]][2], split = ",sequence")[[1]][1]
      Dice5Load <- strsplit(strsplit(participant[grep(pattern = "componentPos:16,", x = participant[,1]),1], split = "q1,value:")[[1]][2], split = "^")[[1]][1]
      Dice5LoadCert <- strsplit(strsplit(participant[grep(pattern = "componentPos:16,", x = participant[,1]),1], split = "q2,value:")[[1]][2], split = "^")[[1]][1]
      if(Dice5LoadCert == 1){Dice5LoadCert2 <- strsplit(strsplit(participant[grep(pattern = "componentPos:16,", x = participant[,1]),1], split = "q2,value:")[[1]][2], split = "^")[[1]][2]}
      if(Dice5LoadCert == 1){if(Dice5LoadCert2 == 0){Dice5LoadCert <- paste(as.numeric(Dice5LoadCert), as.numeric(Dice5LoadCert2), sep="")}}
      if(Dice5Load == 0){Dice5LoadWhat <- strsplit(strsplit(participant[grep(pattern = "componentPos:16,", x = participant[,1]),1], split = "q3,value:")[[1]][2], split = "^")[[1]][1]}else{Dice5LoadWhat <- "9"}
    #Dice6
      Dice6DtD <- length(regmatches(grep("[0-9]",strsplit(participant[grep(pattern = "componentPos:17,", x = participant[,1]),1], split = "color:")[[1]][2], value = TRUE), gregexpr("[[:digit:]]+", grep("[0-9]",strsplit(participant[grep(pattern = "componentPos:17,", x = participant[,1]),1], split = "color:")[[1]][2], value = TRUE)))[[1]])
      Dice6Col <- strsplit(strsplit(participant[grep(pattern = "componentPos:17,", x = participant[,1]),1], split = "color:")[[1]][2], split = ",sequence")[[1]][1]
      Dice6Load <- strsplit(strsplit(participant[grep(pattern = "componentPos:18,", x = participant[,1]),1], split = "q1,value:")[[1]][2], split = "^")[[1]][1]
      Dice6LoadCert <- strsplit(strsplit(participant[grep(pattern = "componentPos:18,", x = participant[,1]),1], split = "q2,value:")[[1]][2], split = "^")[[1]][1]
      if(Dice6LoadCert == 1){Dice6LoadCert2 <- strsplit(strsplit(participant[grep(pattern = "componentPos:18,", x = participant[,1]),1], split = "q2,value:")[[1]][2], split = "^")[[1]][2]}
      if(Dice6LoadCert == 1){if(Dice6LoadCert2 == 0){Dice6LoadCert <- paste(as.numeric(Dice6LoadCert), as.numeric(Dice6LoadCert2), sep="")}}
      if(Dice6Load == 0){Dice6LoadWhat <- strsplit(strsplit(participant[grep(pattern = "componentPos:18,", x = participant[,1]),1], split = "q3,value:")[[1]][2], split = "^")[[1]][1]}else{Dice6LoadWhat <- "9"}
    #Dice7
      Dice7DtD <- length(regmatches(grep("[0-9]",strsplit(participant[grep(pattern = "componentPos:19,", x = participant[,1]),1], split = "color:")[[1]][2], value = TRUE), gregexpr("[[:digit:]]+", grep("[0-9]",strsplit(participant[grep(pattern = "componentPos:19,", x = participant[,1]),1], split = "color:")[[1]][2], value = TRUE)))[[1]])
      Dice7Col <- strsplit(strsplit(participant[grep(pattern = "componentPos:19,", x = participant[,1]),1], split = "color:")[[1]][2], split = ",sequence")[[1]][1]
      Dice7Load <- strsplit(strsplit(participant[grep(pattern = "componentPos:20,", x = participant[,1]),1], split = "q1,value:")[[1]][2], split = "^")[[1]][1]
      Dice7LoadCert <- strsplit(strsplit(participant[grep(pattern = "componentPos:20,", x = participant[,1]),1], split = "q2,value:")[[1]][2], split = "^")[[1]][1]
      if(Dice7LoadCert == 1){Dice7LoadCert2 <- strsplit(strsplit(participant[grep(pattern = "componentPos:20,", x = participant[,1]),1], split = "q2,value:")[[1]][2], split = "^")[[1]][2]}
      if(Dice7LoadCert == 1){if(Dice7LoadCert2 == 0){Dice7LoadCert <- paste(as.numeric(Dice7LoadCert), as.numeric(Dice7LoadCert2), sep="")}}
      if(Dice7Load == 0){Dice7LoadWhat <- strsplit(strsplit(participant[grep(pattern = "componentPos:20,", x = participant[,1]),1], split = "q3,value:")[[1]][2], split = "^")[[1]][1]}else{Dice7LoadWhat <- "9"}
    #Dice8
      Dice8DtD <- length(regmatches(grep("[0-9]",strsplit(participant[grep(pattern = "componentPos:21,", x = participant[,1]),1], split = "color:")[[1]][2], value = TRUE), gregexpr("[[:digit:]]+", grep("[0-9]",strsplit(participant[grep(pattern = "componentPos:21,", x = participant[,1]),1], split = "color:")[[1]][2], value = TRUE)))[[1]])
      Dice8Col <- strsplit(strsplit(participant[grep(pattern = "componentPos:21,", x = participant[,1]),1], split = "color:")[[1]][2], split = ",sequence")[[1]][1]
      Dice8Load <- strsplit(strsplit(participant[grep(pattern = "componentPos:22,", x = participant[,1]),1], split = "q1,value:")[[1]][2], split = "^")[[1]][1]
      Dice8LoadCert <- strsplit(strsplit(participant[grep(pattern = "componentPos:22,", x = participant[,1]),1], split = "q2,value:")[[1]][2], split = "^")[[1]][1]
      if(Dice8LoadCert == 1){Dice8LoadCert2 <- strsplit(strsplit(participant[grep(pattern = "componentPos:22,", x = participant[,1]),1], split = "q2,value:")[[1]][2], split = "^")[[1]][2]}
      if(Dice8LoadCert == 1){if(Dice8LoadCert2 == 0){Dice8LoadCert <- paste(as.numeric(Dice8LoadCert), as.numeric(Dice8LoadCert2), sep="")}}
      if(Dice8Load == 0){Dice8LoadWhat <- strsplit(strsplit(participant[grep(pattern = "componentPos:22,", x = participant[,1]),1], split = "q3,value:")[[1]][2], split = "^")[[1]][1]}else{Dice8LoadWhat <- "9"}
    #Final choice
      Trial2LoadedDice <- strsplit(strsplit(participant[grep(pattern = "componentPos:23,", x = participant[,1]),1], split = "value:")[[1]][2], split = "^")[[1]][1]

    cases <- cases[-1]
  }
  files <- files[-1]
}
