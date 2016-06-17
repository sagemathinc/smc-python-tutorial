MATHBOOK ?= ./mathbook
NAME = smc-python-tutorial

PHONY = clean default jupyter build html sagews update

default: build

build: html

xml: $(NAME).xml

$(NAME).xml: $(NAME).pug
	./node_modules/.bin/pug --pretty --extension xml $(NAME).pug

html: xml
	@echo building html
	xsltproc $(MATHBOOK)/xsl/mathbook-html.xsl $(NAME).xml

sagews:
	@echo building sagews
	xsltproc $(MATHBOOK)/xsl/mathbook-smc.xsl $(NAME).xml

jupyter:
	@echo building jupyter
	xsltproc $(MATHBOOK)/xsl/mathbook-jupyter.xsl $(NAME).xml

update:
	@echo update
	git pull
	git submodule update --recursive

clean:
	git clean -fx
	-rm -rf knowl/
