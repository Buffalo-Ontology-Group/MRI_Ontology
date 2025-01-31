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

