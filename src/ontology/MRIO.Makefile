## Customize Makefile settings for MRIO
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile

# $(IMPORTDIR)/uberon_import.owl: $(MIRRORDIR)/uberon.owl $(IMPORTDIR)/uberon_terms_combined.txt
# if [ $(IMP) = true ]; then $(ROBOT) \
# 	filter -i mirror/uberon.owl \
# 	-T imports/uberon_terms.txt \
# 	--select "annotations self ancestors" \
# 	-o imports/uberon_import.owl


## ONTOLOGY: uberon
# .PHONY: mirror-uberon
# .PRECIOUS: $(MIRRORDIR)/uberon.owl
# mirror-uberon: | $(TMPDIR)
# 	curl -L http://purl.obolibrary.org/obo/uberon/nervous-minimal.owl --create-dirs -o $(TMPDIR)/uberon-download.owl --retry 4 --max-time 200 && \
# 	$(ROBOT) convert -i $(TMPDIR)/uberon-download.owl -o $(TMPDIR)/$@.owl

#--force true --copy-ontology-annotations true --individuals include
$(IMPORTDIR)/uberon_import.owl: $(MIRRORDIR)/uberon.owl $(IMPORTDIR)/uberon_terms_combined.txt
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		extract -T $(IMPORTDIR)/uberon_terms_combined.txt --force true --copy-ontology-annotations true --individuals include --method BOT \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/inject-synonymtype-declaration.ru --update ../sparql/postprocess-module.ru \
		$(ANNOTATE_CONVERT_FILE); fi

.PHONY: mirror-uberon
# .PRECIOUS: $(MIRRORDIR)/uberon.owl
mirror-uberon: | $(MIRRORDIR)
	curl -L $(URIBASE)/uberon/uberon-base.owl --create-dirs -o $(TMPDIR)/mirror-uberon.owl --retry 4 --max-time 200 && \
	$(ROBOT) convert -i $(TMPDIR)/mirror-uberon.owl -o $(MIRRORDIR)/uberon.owl

$(IMPORTDIR)/pato_import.owl: $(MIRRORDIR)/pato.owl $(IMPORTDIR)/pato_terms_combined.txt
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		annotate --ontology-iri "http://purl.obolibrary.org/obo/pato.owl" \
		extract -T $(IMPORTDIR)/uberon_terms_combined.txt --force true --copy-ontology-annotations true --individuals include --method BOT \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/inject-synonymtype-declaration.ru --update ../sparql/postprocess-module.ru \
		$(ANNOTATE_CONVERT_FILE); fi


.PHONY: all_mrio
all_mrio: pato mondo uberon 
	robot merge \
		-i MRIO-edit.owl \
		-i imports/mondo_import.owl \
		-i imports/uberon_import.owl \
		-i imports/pato_import.owl \
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

#ncit:
#	robot \
#		--catalog catalog-v001.xml \
#		filter -i mirror/ncit.owl \
#		-T imports/ncit_terms.txt \
#		--select "annotations self ancestors" \
#		-o imports/ncit_import.owl

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

