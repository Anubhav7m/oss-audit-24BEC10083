oss-audit-24BEC10083
The Open Source Audit — Python
Capstone Project | Open Source Software (OSS NGMC Course)
---
Student Name: Anubhav MishraRegistration Number: 24BEC10083Chosen Software: Python  License: Python Software Foundation License (PSF-2.0)  Course Units Covered: 1 – 5
---
About This Project
This repository contains the shell scripts and supporting materials for the Open Source Audit capstone project. The project is a structured analysis of Python as an open-source software project — covering its origin story, licensing, ethics, Linux footprint, FOSS ecosystem, and a comparison with proprietary alternatives.
The full written report (12–16 pages) is submitted separately as a PDF on the VITyarthi portal.
---
Repository Structure
```oss-audit-24BEC10083├── script1\\\\\\\\\\\\\\\_system\\\\\\\\\\\\\\\_identity.sh        # System Identity Report├── script2\\\\\\\\\\\\\\\_package\\\\\\\\\\\\\\\_inspector.sh      # FOSS Package Inspector├── script3\\\\\\\\\\\\\\\_disk\\\\\\\\\\\\\\\_permission\\\\\\\\\\\\\\\_auditor.sh # Disk and Permission Auditor├── script4\\\\\\\\\\\\\\\_log\\\\\\\\\\\\\\\_analyzer.sh           # Log File Analyzer├── script5\\\\\\\\\\\\\\\_manifesto\\\\\\\\\\\\\\\_generator.sh    # Open Source Manifesto Generator└── README.md                         # This file```
---
Script Descriptions
Script 1 — System Identity Report
File: `script1\\\\\\\\\\\\\\\_system\\\\\\\\\\\\\\\_identity.sh`  Displays a formatted welcome screen showing the Linux distribution, kernel version, current user, home directory, system uptime, date/time, and the open-source licenses covering the OS and the audited software (Python).  Concepts used: Variables, `echo`, command substitution `$()`, `/etc/os-release` parsing, output formatting.
---
Script 2 — FOSS Package Inspector
File: `script2\\\\\\\\\\\\\\\_package\\\\\\\\\\\\\\\_inspector.sh`  Checks whether a given open-source package is installed on the system (supports both `dpkg`/Debian and `rpm`/RHEL systems), retrieves version and license metadata, and prints a philosophy note for each known FOSS package using a `case` statement.  Concepts used: `if-then-else`, `case` statement, `dpkg`/`rpm` queries, `grep`, command-line arguments (`$1`).
---
Script 3 — Disk and Permission Auditor
File: `script3\\\\\\\\\\\\\\\_disk\\\\\\\\\\\\\\\_permission\\\\\\\\\\\\\\\_auditor.sh`  Loops through a list of important Linux system directories and reports permissions, ownership, and disk usage for each. Includes a dedicated section for Python's installation directories.  Concepts used: `for` loop, arrays, `ls -ld`, `du -sh`, `awk`, `cut`, conditional directory checks.
---
Script 4 — Log File Analyzer
File: `script4\\\\\\\\\\\\\\\_log\\\\\\\\\\\\\\\_analyzer.sh`  Reads a log file line by line, counts how many lines contain a specified keyword (default: `error`), prints a summary with percentage, and displays the last 5 matching lines. Includes validation and retry guidance if the file is missing or empty.  Concepts used: `while IFS= read -r` loop, `if-then`, counter variables, `$1`/`$2` arguments, `grep`, `tail`, `awk` for floating-point.
---
Script 5 — Open Source Manifesto Generator
File: `script5\\\\\\\\\\\\\\\_manifesto\\\\\\\\\\\\\\\_generator.sh`  Interactively asks the user three questions and generates a personalised open-source philosophy statement using their answers. Saves the output to a `.txt` file named after the current user.  Concepts used: `read` for input, string concatenation, file redirection (`>` and `>>`), `date`, `alias` (`shopt -s expand\\\\\\\\\\\\\\\_aliases`), input validation.
---
How to Run the Scripts
Prerequisites
A Linux system (Ubuntu, Debian, Fedora, CentOS, or similar)
Bash shell (version 4.0 or higher recommended)
Python 3 installed (for Script 2 and Script 3 to show Python-specific results)
Step 1: Clone the Repository
```bashgit clone https://github.com/Anubhav7m/oss-audit-24BEC10083.gitcd oss-audit-24BEC10083```
Step 2: Make Scripts Executable
```bashchmod +x script1\\\\\\\\\\\\\\\_system\\\\\\\\\\\\\\\_identity.shchmod +x script2\\\\\\\\\\\\\\\_package\\\\\\\\\\\\\\\_inspector.shchmod +x script3\\\\\\\\\\\\\\\_disk\\\\\\\\\\\\\\\_permission\\\\\\\\\\\\\\\_auditor.shchmod +x script4\\\\\\\\\\\\\\\_log\\\\\\\\\\\\\\\_analyzer.shchmod +x script5\\\\\\\\\\\\\\\_manifesto\\\\\\\\\\\\\\\_generator.sh```
Step 3: Run Each Script
Script 1 — System Identity Report:
```bash./script1\\\\\\\\\\\\\\\_system\\\\\\\\\\\\\\\_identity.sh```
Script 2 — FOSS Package Inspector:
```bash# Inspect the default package (python3):./script2\\\\\\\\\\\\\\\_package\\\\\\\\\\\\\\\_inspector.sh# Inspect a specific package:./script2\\\\\\\\\\\\\\\_package\\\\\\\\\\\\\\\_inspector.sh git./script2\\\\\\\\\\\\\\\_package\\\\\\\\\\\\\\\_inspector.sh firefox./script2\\\\\\\\\\\\\\\_package\\\\\\\\\\\\\\\_inspector.sh vlc```
Script 3 — Disk and Permission Auditor:
```bash./script3\\\\\\\\\\\\\\\_disk\\\\\\\\\\\\\\\_permission\\\\\\\\\\\\\\\_auditor.sh```
> Note: Some directories (e.g., `/var/log`) may require `sudo` to report accurate sizes.
Script 4 — Log File Analyzer:
```bash# Analyse syslog for 'error' (default keyword):./script4\\\\\\\\\\\\\\\_log\\\\\\\\\\\\\\\_analyzer.sh /var/log/syslog# Analyse with a custom keyword:./script4\\\\\\\\\\\\\\\_log\\\\\\\\\\\\\\\_analyzer.sh /var/log/syslog warning./script4\\\\\\\\\\\\\\\_log\\\\\\\\\\\\\\\_analyzer.sh /var/log/auth.log failed```
Script 5 — Open Source Manifesto Generator:
```bash./script5\\\\\\\\\\\\\\\_manifesto\\\\\\\\\\\\\\\_generator.sh```
> This script is interactive. It will ask you three questions and generate a `.txt` file.
---
Dependencies
Script	Dependencies
Script 1	`bash`, `uname`, `whoami`, `uptime`, `date`, `/etc/os-release`
Script 2	`bash`, `dpkg` (Debian) or `rpm` (RHEL)
Script 3	`bash`, `ls`, `du`, `awk`, `cut`, `python3` (optional)
Script 4	`bash`, `grep`, `tail`, `awk`, `du`
Script 5	`bash`, `date`, `whoami`
All dependencies are standard Linux utilities available on any modern distribution.
---
Chosen Software: Python
Python is a general-purpose, open-source programming language first released in 1991 by Guido van Rossum. It is distributed under the PSF License (PSF-2.0), a permissive licence approved by both the Open Source Initiative and the Free Software Foundation. Python grants all four freedoms of free software: the freedom to run, study, modify, and redistribute the program.
Key facts:
Current stable version: Python 3.12.x
Governance: Python Software Foundation (PSF) + elected Steering Council
Package ecosystem: 500,000+ packages on PyPI
Used by: Google, NASA, CERN, Instagram, Spotify, and virtually every data science team globally
---
Academic Integrity
All shell scripts in this repository are original work written for this course. All written sections of the project report are in the student's own words. Scripts have been tested on a Linux system and produce correct output.
---
Open Source Software Course | VITyarthi
