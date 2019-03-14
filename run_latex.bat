@echo off&cls
set /p pat=Please enter the path to the .tex file you would like to compile:

@echo Compiling %pat%
pdflatex "%pat%"
bibtex "%pat%"
pdflatex "%pat%"
pdflatex "%pat%"

pause
@echo off