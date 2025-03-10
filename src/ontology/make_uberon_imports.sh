#!/bin/bash

#./run.sh robot filter -i mirror/uberon.owl \
robot filter -i mirror/uberon.owl \
    --term http://purl.obolibrary.org/obo/UBERON_0001897 \
    --term http://purl.obolibrary.org/obo/UBERON_0010225 \
    --term http://purl.obolibrary.org/obo/UBERON_0002129 \
    --term http://purl.obolibrary.org/obo/UBERON_0004703 \
    --term http://purl.obolibrary.org/obo/UBERON_0001873 \
    --term http://purl.obolibrary.org/obo/UBERON_0001874 \
    --term http://purl.obolibrary.org/obo/UBERON_0006514 \
    --term http://purl.obolibrary.org/obo/UBERON_0002421 \
    --term http://purl.obolibrary.org/obo/UBERON_0001876 \
    --term http://purl.obolibrary.org/obo/UBERON_0001882 \
    --term http://purl.obolibrary.org/obo/UBERON_0001898 \
    --term http://purl.obolibrary.org/obo/UBERON_0028622 \
    --term http://purl.obolibrary.org/obo/UBERON_0028715 \
    --term http://purl.obolibrary.org/obo/UBERON_0006445 \
    --term http://purl.obolibrary.org/obo/UBERON_0006092 \
    --term http://purl.obolibrary.org/obo/UBERON_0002728 \
    --term http://purl.obolibrary.org/obo/UBERON_0002766 \
    --term http://purl.obolibrary.org/obo/UBERON_0006088 \
    --term http://purl.obolibrary.org/obo/UBERON_0002751 \
    --term http://purl.obolibrary.org/obo/UBERON_0027061 \
    --term http://purl.obolibrary.org/obo/UBERON_0006114 \
    --term http://purl.obolibrary.org/obo/UBERON_0022716 \
    --term http://purl.obolibrary.org/obo/UBERON_0002943 \
    --term http://purl.obolibrary.org/obo/UBERON_0022352 \
    --term http://purl.obolibrary.org/obo/UBERON_0002771 \
    --term http://purl.obolibrary.org/obo/UBERON_0002973 \
    --term http://purl.obolibrary.org/obo/UBERON_0035933 \
    --term http://purl.obolibrary.org/obo/UBERON_0002980 \
    --term http://purl.obolibrary.org/obo/UBERON_0002624 \
    --term http://purl.obolibrary.org/obo/UBERON_0002629 \
    --term http://purl.obolibrary.org/obo/UBERON_0022534 \
    --term http://purl.obolibrary.org/obo/UBERON_0002581 \
    --term http://purl.obolibrary.org/obo/UBERON_0022353 \
    --term http://purl.obolibrary.org/obo/UBERON_0002703 \
    --term http://purl.obolibrary.org/obo/UBERON_0006093 \
    --term http://purl.obolibrary.org/obo/UBERON_0022438 \
    --term http://purl.obolibrary.org/obo/UBERON_0006446 \
    --term http://purl.obolibrary.org/obo/UBERON_0002661 \
    --term http://purl.obolibrary.org/obo/UBERON_0006094 \
    --term http://purl.obolibrary.org/obo/UBERON_0002769 \
    --term http://purl.obolibrary.org/obo/UBERON_0002688 \
    --term http://purl.obolibrary.org/obo/UBERON_0002795 \
    --term http://purl.obolibrary.org/obo/UBERON_0002576 \
    --term http://purl.obolibrary.org/obo/UBERON_0001393 \
    --term http://purl.obolibrary.org/obo/UBERON_0002022 \
    --term http://purl.obolibrary.org/obo/UBERON_0013683 \
    --term http://purl.obolibrary.org/obo/UBERON_0008884 \
    --term http://purl.obolibrary.org/obo/UBERON_0013684 \
    --term http://purl.obolibrary.org/obo/UBERON_0008885 \
    --term http://purl.obolibrary.org/obo/UBERON_0009898 \
    --term http://purl.obolibrary.org/obo/UBERON_0009897 \
    --term http://purl.obolibrary.org/obo/UBERON_0002285 \
    --term http://purl.obolibrary.org/obo/UBERON_0001896 \
    --term http://purl.obolibrary.org/obo/UBERON_0003544 \
    --term http://purl.obolibrary.org/obo/UBERON_0003528 \
    --term http://purl.obolibrary.org/obo/UBERON_0001900 \
    --select "annotations self ancestors" \
    --output uberon_filtered.owl

#docker run \
#    -v $PWD/../../:/work \
#    -w /work/src/ontology \
#    --rm -ti \
#    obolibrary/odkfull:v1.2.27 \
#        bash -c "cp uberon_filtered.owl imports/uberon_import.owl"
cp -v uberon_filtered.owl imports/uberon_import.owl

