MATHBOOK ?= ./mathbook
NAME = smc-python-tutorial

PHONY = default build html sagews update

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

update:
	@echo update: not implemented yet

