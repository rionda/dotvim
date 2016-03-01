#! /opt/local/bin/bash

# from:
# https://sourceforge.net/p/skim-app/wiki/TeX_and_PDF_Synchronization/

# trimmed down to just do the view update

# the first argument should be the tex file, either with or without
# extension
file="$1"
[ "${file:0:1}" == "/" ] || file="${PWD}/${file}"
pdffile="${file%.tex}.pdf"

# reload the pdf in Skim
/usr/bin/osascript << EOF
set thePDFFile to POSIX file "${pdffile}" as alias
tell application "Skim"
set theDocument to get documents whose path is (get POSIX path of thePDFFile)
if (count of theDocument) > 0 then revert theDocument
open thePDFFile
end tell
EOF
