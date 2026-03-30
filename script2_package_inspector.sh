#!/bin/bash
# =============================================================
# Script 2: FOSS Package Inspector
# Author: Anubhav Mishra
# Registration: 24BEC10083
# Course: Open Source Software | Unit 2
# Description: Checks if a given open-source package is installed,
#              retrieves version and license info, and prints a
#              philosophy note about each known FOSS package.
# Usage: ./script2_package_inspector.sh [package-name]
#        If no argument is given, defaults to python3.
# =============================================================

# --- Accept an optional command-line argument for the package name ---
# If no argument is passed ($1 is empty), default to "python3"
PACKAGE=${1:-python3}

echo "================================================================"
echo "  FOSS PACKAGE INSPECTOR"
echo "================================================================"
echo "  Inspecting package: $PACKAGE"
echo "----------------------------------------------------------------"

# --- Detect the package manager available on this system ---
# Different Linux distributions use different package managers.
if command -v dpkg &>/dev/null; then
    PKG_MANAGER="dpkg"       # Debian / Ubuntu family
elif command -v rpm &>/dev/null; then
    PKG_MANAGER="rpm"        # Red Hat / Fedora / CentOS family
else
    PKG_MANAGER="unknown"
fi

echo "  Package Manager Detected: $PKG_MANAGER"
echo ""

# --- Check if the package is installed using if-then-else ---
if [ "$PKG_MANAGER" = "dpkg" ]; then
    # dpkg -l lists installed packages; grep filters for the exact name
    if dpkg -l "$PACKAGE" 2>/dev/null | grep -q "^ii"; then
        INSTALLED=true
        echo "  STATUS: $PACKAGE is INSTALLED on this system."
        echo ""
        echo "  Package Details:"
        # dpkg -s gives full package info; grep extracts key fields
        dpkg -s "$PACKAGE" 2>/dev/null | grep -E '^(Version|Maintainer|Homepage|Description)' | \
            sed 's/^/    /'
    else
        INSTALLED=false
        echo "  STATUS: $PACKAGE is NOT installed on this system."
        echo "  To install: sudo apt install $PACKAGE"
    fi

elif [ "$PKG_MANAGER" = "rpm" ]; then
    # rpm -q returns exit code 0 if installed, 1 if not
    if rpm -q "$PACKAGE" &>/dev/null; then
        INSTALLED=true
        echo "  STATUS: $PACKAGE is INSTALLED on this system."
        echo ""
        echo "  Package Details:"
        # rpm -qi gives verbose info; grep extracts Version, License, Summary
        rpm -qi "$PACKAGE" | grep -E 'Version|License|Summary' | sed 's/^/    /'
    else
        INSTALLED=false
        echo "  STATUS: $PACKAGE is NOT installed on this system."
        echo "  To install: sudo dnf install $PACKAGE"
    fi

else
    # Fallback: try 'which' to check if the binary exists in PATH
    if command -v "$PACKAGE" &>/dev/null; then
        INSTALLED=true
        echo "  STATUS: $PACKAGE binary found at: $(which $PACKAGE)"
        # Try to get version info if the command supports --version
        VERSION_OUTPUT=$("$PACKAGE" --version 2>&1 | head -1)
        echo "  Version: $VERSION_OUTPUT"
    else
        INSTALLED=false
        echo "  STATUS: $PACKAGE not found. Package manager not identified."
    fi
fi

echo ""
echo "----------------------------------------------------------------"
echo "  PHILOSOPHY NOTE"
echo "----------------------------------------------------------------"

# --- Case statement: print a philosophy note per known FOSS package ---
# This demonstrates the 'case' construct in shell scripting.
case "$PACKAGE" in
    python3 | python)
        echo "  Python: 'Readability counts.' — A language built on the belief"
        echo "  that code is written for humans first, machines second."
        echo "  License: PSF-2.0 | Creator: Guido van Rossum (1991)"
        ;;
    httpd | apache2)
        echo "  Apache HTTP Server: the open web server that built the internet."
        echo "  Apache's permissive license lets everyone build on it."
        echo "  License: Apache-2.0 | Creator: The Apache Group (1995)"
        ;;
    mysql | mysql-server)
        echo "  MySQL: dual-licensed open source at the heart of millions of apps."
        echo "  A fascinating lesson in how FOSS and commerce can coexist."
        echo "  License: GPL-2.0 / Commercial | Creator: MySQL AB (1995)"
        ;;
    git)
        echo "  Git: the version control system Linus built in 2 weeks when"
        echo "  a proprietary tool failed the Linux community."
        echo "  License: GPL-2.0 | Creator: Linus Torvalds (2005)"
        ;;
    firefox)
        echo "  Firefox: a nonprofit fighting for an open, user-respecting web."
        echo "  Proof that a browser can prioritise people over profit."
        echo "  License: MPL-2.0 | Creator: Mozilla Foundation (2002)"
        ;;
    vlc)
        echo "  VLC: started by students in Paris who needed to stream video."
        echo "  Plays everything — built for freedom, not for a market."
        echo "  License: LGPL-2.1 / GPL-2.0 | Creator: VideoLAN (2001)"
        ;;
    libreoffice)
        echo "  LibreOffice: born from a community fork of OpenOffice.org."
        echo "  A lesson that community ownership beats corporate control."
        echo "  License: MPL-2.0 | Creator: The Document Foundation (2010)"
        ;;
    *)
        # Default case for any package not in the known list
        echo "  '$PACKAGE' is an open-source tool. Every open-source project"
        echo "  represents a decision to share knowledge rather than hoard it."
        ;;
esac

echo ""
echo "================================================================"
echo "  END OF PACKAGE INSPECTION"
echo "================================================================"
