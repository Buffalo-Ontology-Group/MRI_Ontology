## Customize Makefile settings for MRIO
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile

.PHONY: all_mrio
all_mrio: 
	robot merge \
		-i MRIO-edit.owl \
		-i imports/mondo_import.owl \
		-i imports/obi_import.owl \
		-i imports/uberon_import.owl \
		-i imports/ncit_import.owl \
		-o MRIO.owl

pato:
	robot \
		--catalog catalog-v001.xml \
		filter \
		-i mirror/pato.owl \
		-T imports/pato_terms.txt \
		--select "annotations self ancestors" \
		-o imports/pato_import.owl

mondo:
	robot \
		--catalog catalog-v001.xml \
		filter \
		-i mirror/mondo.owl \
		-T imports/mondo_terms.txt \
		--select "annotations self ancestors" \
		-o imports/mondo_import.owl

ncit:
	robot \
		--catalog catalog-v001.xml \
		filter -i mirror/ncit.owl \
		-T imports/ncit_terms.txt \
		--select "annotations self ancestors" \
		-o imports/ncit_import.owl

uberon:
	robot \
		--catalog catalog-v001.xml \
		filter -i mirror/uberon.owl \
		-T imports/uberon_terms.txt \
		--select "annotations self ancestors" \
		-o imports/uberon_import.owl

iao:
	robot \
		--catalog catalog-v001.xml \
		filter -i mirror/iao.owl \
		-T imports/iao_terms.txt \
		--select "annotations self ancestors" \
		-o imports/iao_import.owl

.PHONY: mirror-stato
.PRECIOUS: $(MIRRORDIR)/stato.owl
mirror-stato: | $(TMPDIR)
	curl -L $(OBOBASE)/stato.owl --create-dirs -o $(TMPDIR)/stato-download.owl --retry 4 --max-time 200 && \
	$(ROBOT) convert -i $(TMPDIR)/stato-download.owl -o $(TMPDIR)/$@.owl

$(MIRRORDIR)/stato.owl: mirror-stato | $(MIRRORDIR)
	if [ -f $(TMPDIR)/mirror-stato.owl ]; then if cmp -s $(TMPDIR)/mirror-stato.owl $@ ; then echo "Mirror identical, ignoring."; else echo "Mirrors different, updating." &&\
		cp $(TMPDIR)/mirror-stato.owl $@; fi; fi

stato: mirror-stato
	robot \
		--catalog catalog-v001.xml \
		filter -i mirror/stato.owl \
		-T imports/stato_terms.txt \
		--select "annotations self ancestors" \
		-o imports/stato_import.owl

