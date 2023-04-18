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
	robot filter -i mirror/pato.owl -T imports/pato_terms.txt -o imports/pato_import.owl

mondo:
	robot filter -i mirror/mondo.owl -T imports/mondo_terms.txt -o imports/mondo_import.owl

ncit:
	robot filter -i mirror/ncit.owl -T imports/ncit_terms.txt -o imports/ncit_import.owl

uberon:
	./make_uberon_imports.sh

