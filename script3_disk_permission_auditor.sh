#!/bin/bash
# =============================================================
# Script 3: Disk and Permission Auditor
# Author: Anubhav Mishra
# Registration: 24BEC10083
# Course: Open Source Software | Unit 2
# Description: Loops through a list of important Linux system
#              directories and reports permissions, ownership,
#              and disk usage for each. Also checks Python's
#              specific installation directories.
# =============================================================

# --- List of important system directories to audit ---
# These are standard Linux Filesystem Hierarchy Standard (FHS) paths.
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/lib" "/opt")

echo "================================================================"
echo "  DISK AND PERMISSION AUDITOR"
echo "  Generated: $(date '+%Y-%m-%d %H:%M:%S')"
echo "================================================================"
echo ""
printf "  %-20s %-15s %-10s %-10s %-8s\n" "DIRECTORY" "PERMISSIONS" "OWNER" "GROUP" "SIZE"
echo "  -----------------------------------------------------------------------"

# --- For loop: iterate over each directory in the DIRS array ---
for DIR in "${DIRS[@]}"; do

    # Check if the directory actually exists before trying to inspect it
    if [ -d "$DIR" ]; then
        # ls -ld lists the directory itself (not its contents)
        # awk extracts fields: $1=permissions, $3=owner, $4=group
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')
        GROUP=$(ls -ld "$DIR" | awk '{print $4}')

        # du -sh gives human-readable size; cut extracts the first field (size only)
        # 2>/dev/null suppresses permission denied errors on unreadable subdirs
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # printf formats the output into aligned columns
        printf "  %-20s %-15s %-10s %-10s %-8s\n" "$DIR" "$PERMS" "$OWNER" "$GROUP" "${SIZE:-N/A}"
    else
        # If directory doesn't exist, note it rather than silently skipping
        printf "  %-20s %s\n" "$DIR" "[does not exist on this system]"
    fi

done

echo ""
echo "================================================================"
echo "  PYTHON-SPECIFIC DIRECTORY AUDIT"
echo "================================================================"
echo "  Checking Python installation directories..."
echo ""

# --- Check Python-specific directories ---
# These are the standard locations where Python lives on Linux systems.
PYTHON_DIRS=(
    "/usr/bin/python3"
    "/usr/lib/python3"
    "/usr/lib/python3/dist-packages"
    "/usr/local/lib"
    "$HOME/.local/lib"
    "/etc/python3"
)

for PDIR in "${PYTHON_DIRS[@]}"; do
    if [ -e "$PDIR" ]; then
        # -e checks for existence of both files and directories
        TYPE="file"
        [ -d "$PDIR" ] && TYPE="dir"   # Override to 'dir' if it's a directory

        PERMS=$(ls -ld "$PDIR" | awk '{print $1}')
        OWNER=$(ls -ld "$PDIR" | awk '{print $3}')
        SIZE=$(du -sh "$PDIR" 2>/dev/null | cut -f1)

        echo "  Path  : $PDIR ($TYPE)"
        echo "  Perms : $PERMS | Owner: $OWNER | Size: ${SIZE:-<1K}"
        echo "  -----------------------------------------------------------"
    else
        echo "  Path  : $PDIR"
        echo "  Status: NOT FOUND (Python may not be installed or path differs)"
        echo "  -----------------------------------------------------------"
    fi
done

# --- Check what Python version is available ---
echo ""
echo "  Python Version Check:"
if command -v python3 &>/dev/null; then
    PYVER=$(python3 --version 2>&1)
    PYLOC=$(which python3)
    echo "  Installed: $PYVER"
    echo "  Binary at: $PYLOC"
else
    echo "  python3 not found in PATH."
fi

echo ""
echo "================================================================"
echo "  END OF DISK AND PERMISSION AUDIT"
echo "================================================================"
