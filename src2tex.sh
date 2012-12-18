#!/bin/sh

## File type separated by space character.  This is a pattern to search files.
FILE_TYPE="h c cc cpp"

## listings options
LSTSET='
breaklines=true,
tabsize=2,
numbers=left,
stepnumber=1,
language=C++,
basicstyle=\\scriptsize\\ttfamily,
numberstyle=\\color[cmyk]{0.11,0.95,0.37,0.92},
stringstyle=\\color[cmyk]{0.11,0.95,0.37,0.92},
commentstyle=\\color[cmyk]{0.61,0.33,0,0},
keywordstyle=\\color[cmyk]{0.71,0.05,1,0.17},
'

## hyperref options
HYPERSEtUP='
bookmarks=true,
bookmarksnumbered=true
'

## A preamble
PREAMBLE='
\\documentclass[12pt]{article}
\\usepackage{listings}
\\usepackage{color}
\\usepackage{hyperref}
\\hypersetup{'"$HYPERSEtUP"'}
\\lstset{'"$LSTSET"'}
\\setlength{\\textwidth}{5.6in}
\\setcounter{secnumdepth}{-1}
'

if test $# -ne 1; then
  echo Bad argument!! 1>&2
  exit 1
fi

target=`echo $1 | sed -e 's/\/*$//g'`
output=`basename $1`.tex

for i in $FILE_TYPE; do
  pattern="${pattern}\|.*\.$i"
done
pattern=`echo $pattern | cut -b3-`

exec 1>$output
echo "$PREAMBLE"
echo '\\begin{document}'
echo '\\tableofcontents'
echo '\\clearpage'

target_len=`echo ${#target} + 2 | bc`
for f in `find . $target -regex $pattern`; do
  f=`ls -dF $f`
  name=`echo $f | cut -b${target_len}-`
  escaped_name=`echo $name | sed -e 's/_/\\\\_/g'`
  echo '\\subsection{'"$escaped_name"'}'
  echo '\\lstinputlisting[]{'"$f"'}'
  echo '\\clearpage'
done

echo "\end{document}"

