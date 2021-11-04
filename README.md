# Individual differences in information sampling using a novel dice task paradigm

## GitHub project relating to article 2 and 3 for my PhD.

## Current project status: GitHub project in restructuring (1. Nov, 2021).

## Project structure:

    project/
    │   README.md - ReadMe file.
    │   dicetask.Rproj - Initiate this before running any scripts.  
    │
    └───article_2/ - Not pushed to GitHub, markdown-document for article 2.
    │
    └───article_3/ - Not pushed to GitHub, markdown-document for article 3.
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
    │   │   │   └───students/ - From student sample.
    │   │   │       jatos_students.txt - Student Jatos file.
    │   │   │
    │   │   └───qualtrics/ - All raw output files from qualtrics.
    │   │       │
    │   │       └───prolific/ - From Prolific sample.
    │   │       │   qualtrics_prolific.csv - Prolific qualtrics file.
    │   │       │
    │   │       └───students/ - From student sample.
    │   │           qualtrics_students_1.csv  - Student qualtrics form part 1 file.
    │   │           qualtrics_students_2.csv  - Student qualtrics form part 2 file.
    │   │           qualtrics_students_3.csv  - Student qualtrics form part 3 file.
    │   │
    │   │   
    │   └───temp/ - Temporary files from scripts, to be used by scripts.
    │       Happens automatically when running scripts. This section will not be updated.
    │
    └───output/ - All output files (excluding pure processed data files).
    │
    └───presentations/ - Not pushed to GitHub, markdown files for presentations.
    │
    └───src/ - All script files (function, extraction, clearning, analyses and plots).
        │   qualtrics_cleanup.R - Script for cleaning up qualtrics files before extraction.
        │
        └───functions/ - Functions scripts.
        │   recoding.cape.R   - Function-script for recoding and summary of CAPE.
        │   recoding.gender.R - Function-script for recoding gender. 
        │   recoding.nfc.R    - Function-script for recoding and summary of NfC.
        │   recoding.rq.R     - Function-script for recoding of RQ items.
        │   recoding.time.R   - Function-script for recoding time on page.
        │
        └───other/
