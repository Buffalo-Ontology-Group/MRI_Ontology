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
		-o MRIO.owl

