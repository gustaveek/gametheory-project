# Makefile for Game theory projekt: Extensive investigation of iterated Prisoner's Dilemma with mixed strategies and noise by L-H.\ Björnsson, G.\ Eek, and N. Jakobsson
# 
# Gustav Eek 2011

MAIN_INP = preamble.tex 010.introduction.tex 020.game.tex 030.genetic.tex 035.implem.tex 040.results.tex 050.bibliography.tex
OUTFILE = 2011\ -\ BEJ\ -\ extensive.pdf

main: $(OUTFILE)

$(OUTFILE): main.aux
	pdflatex main
	cp main.pdf $(OUTFILE)

main.aux: $(MAIN_INP) main.tex
	pdflatex main

020.game.tex: eepic/chromosome.eepic

eepic/chromosome.eepic: fig/chromosome.fig eepic/
	fig2dev -L eepic fig/chromosome.fig eepic/chromosome.eepic

eepic/:
	mkdir eepic

clean:
	rm eepic/*
	rmdir eepic