#!/bin/bash
# =============================================================
# Script 1: System Identity Report
# Author: Anubhav Mishra 
# Registration: 24BEC10083
# Course: Open Source Software | Unit 1 & 2
# Description: Displays a formatted welcome screen showing
#              key information about the Linux system and the
#              open-source license that governs it.
# =============================================================

# --- Variables ---
STUDENT_NAME="Anubhav Mishra"           # Fill in your name before submission
SOFTWARE_CHOICE="Python"             # The OSS project being audited

# --- Gather system information using command substitution ---
KERNEL=$(uname -r)                   # Kernel version (e.g., 6.1.0-21-amd64)
USER_NAME=$(whoami)                  # Currently logged-in username
HOME_DIR=$HOME                       # Home directory of the current user
UPTIME=$(uptime -p)                  # Human-readable uptime (e.g., "up 2 hours, 15 minutes")
DATETIME=$(date '+%A, %d %B %Y — %H:%M:%S')   # Formatted date and time
HOSTNAME=$(hostname)                 # Machine hostname

# --- Detect the Linux distribution name ---
# /etc/os-release is a standard file present on all modern distros
if [ -f /etc/os-release ]; then
    # Source the file to get variables like NAME and VERSION
    . /etc/os-release
    DISTRO="Ubuntu v24.04.4"
else
    # Fallback if /etc/os-release is not present
    DISTRO="Ubuntu"
fi

# --- Determine the OS license ---
# The Linux kernel (which underlies all Linux distros) is GPL v2 licensed.
# Python itself uses the PSF License.
OS_LICENSE="GNU General Public License v2 (GPL-2.0)"
PYTHON_LICENSE="Python Software Foundation License (PSF-2.0)"

# --- Display formatted output ---
echo "================================================================"
echo "        OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT"
echo "================================================================"
echo ""
echo "  Student  : Anubhav Mishra
echo "  Software : Python
echo "  Host     : host
echo ""
echo "----------------------------------------------------------------"
echo "  SYSTEM INFORMATION"
echo "----------------------------------------------------------------"
echo "  Distribution : $DISTRO"
echo "  Kernel       : $KERNEL"
echo "  User         : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo "  Uptime       : $UPTIME"
echo "  Date/Time    : $DATETIME"
echo ""
echo "----------------------------------------------------------------"
echo "  LICENSE INFORMATION"
echo "----------------------------------------------------------------"
echo "  This operating system (Linux kernel) is covered by:"
echo "  $OS_LICENSE"
echo ""
echo "  The audited software (Python) is covered by:"
echo "  $PYTHON_LICENSE"
echo ""
echo "  Both licenses grant the four freedoms: run, study,"
echo "  redistribute, and improve the software."
echo ""
echo "================================================================"
echo "  END OF SYSTEM IDENTITY REPORT"
echo "================================================================"
