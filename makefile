MATHBOOK ?= ./mathbook
NAME = smc-python-tutorial

PHONY = clean default jupyter pdf build html sagews update

default: build

build: html

xml: $(NAME).xml

$(NAME).xml: $(NAME).pug $(wildcard *.pug)
	./node_modules/.bin/pug --pretty --extension xml $(NAME).pug

html: xml
	@echo building html
	xsltproc $(MATHBOOK)/xsl/mathbook-html.xsl $(NAME).xml

sagews: xml
	@echo building sagews
	xsltproc $(MATHBOOK)/xsl/mathbook-smc.xsl $(NAME).xml

jupyter: xml
	@echo building jupyter
	xsltproc $(MATHBOOK)/xsl/mathbook-jupyter.xsl $(NAME).xml

pdf: xml
	@echo building latex
	xsltproc $(MATHBOOK)/xsl/mathbook-latex.xsl $(NAME).xml
	latexmk -pdf -silent -interaction=batchmode $(NAME).tex

update:
	@echo update
	git pull
	git submodule update --recursive

clean:
	git clean -fx
	-rm -rf knowl/
