#!/bin/bash
# =============================================================
# Script 5: The Open Source Manifesto Generator
# Author: Anubhav Mishra
# Registration: 24BEC10083
# Course: Open Source Software | Unit 5
# Description: Interactively asks the user three questions and
#              generates a personalised open-source philosophy
#              statement, saving it to a .txt file.
#              Demonstrates: read, string concatenation, file
#              redirection (>), date command, and aliases.
# =============================================================

# --- Alias demonstration ---
# Aliases create shorthand for longer commands.
# In scripts, aliases require 'expand_aliases' to be enabled.
shopt -s expand_aliases
alias greet='echo "  Welcome to the Open Source Manifesto Generator!"'
alias divider='echo "  ---------------------------------------------------------------"'

# --- Display header ---
echo ""
echo "  ==============================================================="
greet
echo "  ==============================================================="
echo ""
echo "  This script will ask you three questions and compose a"
echo "  personalised open-source philosophy statement for you."
echo "  Your manifesto will be saved as a .txt file."
echo ""
divider
echo ""

# --- Gather user input using 'read' with prompts ---
# -p displays a prompt on the same line as input
# -e enables readline editing (backspace, arrow keys work)

read -e -p "  1. Name one open-source tool you use every day: " TOOL
echo ""

read -e -p "  2. In one word, what does 'freedom' mean to you? " FREEDOM
echo ""

read -e -p "  3. Name one thing you would build and share freely: " BUILD
echo ""

# --- Validate inputs: make sure none are empty ---
# If the user just pressed Enter without typing, set a default.
if [ -z "$TOOL" ]; then
    TOOL="Python"         # Default if user skips
fi
if [ -z "$FREEDOM" ]; then
    FREEDOM="choice"      # Default if user skips
fi
if [ -z "$BUILD" ]; then
    BUILD="something useful"   # Default if user skips
fi

# --- Generate metadata ---
DATE=$(date '+%d %B %Y')                        # e.g., 30 March 2026
TIME=$(date '+%H:%M:%S')                        # e.g., 14:32:07
AUTHOR=$(whoami)                                # Current Linux username
OUTPUT="manifesto_${AUTHOR}.txt"               # Output filename uses the username

# --- Compose the manifesto using string concatenation ---
# Each paragraph is built and appended to the file using >>
# The first write uses > to create/overwrite, subsequent ones use >>

echo ""
divider
echo "  Generating your manifesto..."
divider
echo ""

# Write the header to the file (> creates or overwrites)
echo "================================================================" > "$OUTPUT"
echo "  MY OPEN SOURCE MANIFESTO" >> "$OUTPUT"
echo "  Author : $AUTHOR" >> "$OUTPUT"
echo "  Date   : $DATE at $TIME" >> "$OUTPUT"
echo "================================================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Compose and write the first paragraph using the user's inputs
PARAGRAPH_1="Every day, I rely on $TOOL — a tool built not by a single"
PARAGRAPH_1+=" corporation for profit, but by a community of people who believed"
PARAGRAPH_1+=" that good software should be shared. That act of sharing is not"
PARAGRAPH_1+=" charity. It is a statement: that knowledge belongs to everyone,"
PARAGRAPH_1+=" and that the freedom to learn, to inspect, and to improve is not"
PARAGRAPH_1+=" a privilege but a right."

echo "  $PARAGRAPH_1" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Compose and write the second paragraph
PARAGRAPH_2="To me, freedom means $FREEDOM. In the context of software, that"
PARAGRAPH_2+=" freedom is made real every time someone publishes source code,"
PARAGRAPH_2+=" every time a bug fix travels from one developer's machine to"
PARAGRAPH_2+=" millions of users without a licence fee, every time a student"
PARAGRAPH_2+=" in a country with no budget for proprietary tools can still"
PARAGRAPH_2+=" learn, build, and contribute."

echo "  $PARAGRAPH_2" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Compose and write the third paragraph
PARAGRAPH_3="I commit to carrying this forward. I will build $BUILD, and I will"
PARAGRAPH_3+=" share it. Not because I am required to, but because the tools I"
PARAGRAPH_3+=" use today exist because someone before me made the same choice."
PARAGRAPH_3+=" Open source is not a licence model. It is a way of believing"
PARAGRAPH_3+=" that the world works better when we build it together."

echo "  $PARAGRAPH_3" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Write the footer
echo "----------------------------------------------------------------" >> "$OUTPUT"
echo "  Signed: $AUTHOR | $DATE" >> "$OUTPUT"
echo "  Audited software: Python (PSF License)" >> "$OUTPUT"
echo "================================================================" >> "$OUTPUT"

# --- Display the manifesto in the terminal ---
echo ""
echo "  ==============================================================="
echo "  YOUR MANIFESTO HAS BEEN SAVED TO: $OUTPUT"
echo "  ==============================================================="
echo ""
cat "$OUTPUT"
echo ""
echo "  ==============================================================="
echo "  Share it. Fork it. It's yours. That's the point."
echo "  ==============================================================="
echo ""
