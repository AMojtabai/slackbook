# $Id$

chapters := $(wildcard chapter_*.xml)

imgs_ps := $(wildcard ps-imgs/*.eps)
imgs_png := $(addsuffix .png,$(addprefix png/,$(basename $(notdir $(imgs_ps)))))

MAGICK := $(shell command -v magick 2>/dev/null || echo convert)

list_imgs:
	@echo $(imgs_ps)
	@echo $(imgs_png)

# cleaning up the voodoo a bit.
# now it matches a pattern instead of generating a bunch of rules
# -- vbatts
png/%.png: ps-imgs/%.eps .convert .gs | png
	gs -q -dSAFER -dBATCH -dNOPAUSE -dEPSCrop \
		-sDEVICE=pngalpha -r196 \
		-sOutputFile=$@.tmp.png $(firstword $^)
	$(MAGICK) $@.tmp.png -geometry 800x600 $@
	rm -f $@.tmp.png

png:
	mkdir -p $@

dummy:
	$(MAGICK) $(2) -geometry 800x600 -quality 100 -depth 24 -weight 10 -render -flatten $(1)

images: $(imgs_png)

#book.html: build.sh main.xml $(chapters) $(imgs_png) .clean.html
book.html: build.sh main.xml $(chapters) $(imgs_png)
	sh build.sh && \
	ls -l $@

book.pdf: main.xml $(chapters) $(imgs_png) .dblatex .clean.pdf
	dblatex \
		--pdf \
		-x'-xinclude' \
		-o $@ \
		$(firstword $^)

view.pdf: book.pdf
	xdg-open $(firstword $^)

view.html: book.html
	xdg-open $(firstword $^) || links $(firstword $^)

.PHONY: view
view: view.html

.convert:
	@command -v $(MAGICK) >/dev/null 2>&1 || { echo "ERROR: 'magick' or 'convert' REQUIRED, this is in imagemagick"; exit 1; }
	@touch $@

.gs:
	@command -v gs >/dev/null 2>&1 || { echo "ERROR: 'gs' REQUIRED, this is in ghostscript"; exit 1; }
	@touch $@

.dblatex:
	@command -v dblatex >/dev/null 2>&1 || { echo "ERROR: 'dblatex' REQUIRED, SEE http://github.com/vbatts/SlackBuilds/ FOR THE SlackBuild"; exit 1; }
	@touch $@


.PHONY: .clean.html
.clean.html:
	rm -f book.html

.PHONY: .clean.pdf
.clean.pdf:
	rm -f book.pdf

.PHONY: .clean.stuff
.clean.stuff:
	rm -fr .convert .gs .dblatex

.PHONY: .clean.images
.clean.images:
	rm -fr png/

.PHONY: dist-clean clean
dist-clean: clean .clean.images .clean.stuff

clean: .clean.pdf .clean.html
	

.DEFAULT_GOAL := book.html
