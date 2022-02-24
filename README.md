# Individual differences in information sampling using a novel dice task paradigm

## GitHub project relating to article 2 and 3 for my PhD.

## Current project status: GitHub project in semi-restructuring (24th. Feb, 2022).

## Project structure:

    project/
    │   README.md - ReadMe file.
    │   dicetask.Rproj - Initiate this before running any scripts.  
    │
    └───article_2/ - Not pushed to GitHub, markdown-document and images for article 2.
    │
    └───article_3/ - Not pushed to GitHub, markdown-document and images for article 3.
    │
    └───data/ - Real data not pushed to GitHub, see [OpenScienceFramework](www.osf.com/LINK). 
    │
    └───data_dummy/ - Contains identical file-structure, name, and number of files as the data.
    │   │
    │   └───processed/ - All processed data files from scripts are saved here.
    │   │   Happens automatically when running scripts. This section will not be updated.
    │   │
    │   └───raw/ - All raw output files from the experiments. Treated as read-only.
    │   │   │
    │   │   └───jatos/ - All raw output files from jatos.
    │   │   │   │
    │   │   │   └───hamburg/ - From Hamburg sample.
    │   │   │   │   jatos_hamburg.txt - Hamburg Jatos file.
    │   │   │   │
    │   │   │   └───prolific/ - From Prolific sample.
    │   │   │   │   jatos_prolific_1.txt - Prolific cond. A Jatos file. 
    │   │   │   │   jatos_prolific_2.txt - Prolific cond. B Jatos file.
    │   │   │   │
    │   │   │   └───students/ - From student samples.
    |   |   |       jatos_students_2.txt - Student sample 2 Jatos file.   
    │   │   │       jatos_students.txt - Student sample 1 Jatos file.
    │   │   │
    │   │   └───pavlovia/ - All raw output files from pavlovia
    |   |   |   |
    |   |   |   └───students2/ - From student 2 sample.
    |   |   |       ID_box_task_norm_YEAR-MONTH-DAY_HOURh00.00.000.csv - Two files per participant
    |   |   |       ID_box_task_norm_YEAR-MONTH-DAY_HOURh00.00.000.log.gz
    |   |   |
    |   |   └───qualtrics/ - All raw output files from qualtrics.
    │   │       │
    │   │       └───prolific/ - From Prolific sample.
    │   │       │   qualtrics_prolific.csv - Prolific qualtrics file.
    │   │       │
    │   │       └───students/ - From student 1 sample.
    │   │       |   qualtrics_students_1.csv  - Student qualtrics form part 1 file.
    │   │       |   qualtrics_students_2.csv  - Student qualtrics form part 2 file.
    │   │       |   qualtrics_students_3.csv  - Student qualtrics form part 3 file.
    │   │       |
    |   |       └───students2/
    │   │   
    │   └───temp/ - Temporary files from scripts, not to be used directly in analyses.
    │       Happens automatically when running scripts. This section will not be updated.
    │
    └───output/ - All output files (excluding pure processed data files).
    │
    └───presentations/ - Not pushed to GitHub, markdown files and images for presentations.
    │
    └───src/ - All script files (function, extraction, clearning, analyses and plots).
    |   │   jatos_extraction.R      - Script for extracting and summarising Dice-task files.
    |   |   pavlovia_extraction.R   - Script for extracting and summarising Box-task files.
    |   |   qualtrics_cleanup.R     - Script for cleaning up qualtrics files before extraction.
    |   │
    |   └───functions/ - Functions scripts.
    |       duplicate.detective.R   - Helper script to look for non-unique participants.
    |       recoding.cape.R         - Function-script for recoding and summary of CAPE.
    |       recoding.gender.R       - Function-script for recoding gender. 
    |       recoding.nfc.R          - Function-script for recoding and summary of NfC.
    |       recoding.rq.R           - Function-script for recoding of RQ items.
    |       recoding.time.R         - Function-script for recoding time on page.
    |
    └───tasks/ - Task files for running the behavioral tasks (not qualtrics-based).
        |        NB: Some tasks are modified variants of tasks created by others, 
        |        read the task spesific readMe to find the creator(s) for each spesific task.
        |
        └───box-task/ - All files needed to run the box-task (locally/psychopy or online/pavlovia).
        |   boxTaskReadMe.txt    
        |
        └───dice-task/ - All files needed to run the dice-task via Jatos (online).
            diceTaskReadMe.txt