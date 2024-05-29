# MRI Ontology (MRIO)
An ontology for the representation of MRI acquisition and analysis.

MRIO builds on the Ontology for Biomedical Investigations (OBI) to flesh out 
the process of acquiring MR images, analyzing these images, and interpretting 
the results of these analyses.
A select set of terms from Uberon are imported to relate MRI analyses to the 
specific brain regions.
To cut down on complexity, OBI and Uberon were filtered to use only the terms 
and axioms we needed. These terms can be found in:
 - `src/ontology/imports/obi_terms.txt`
 - `src/ontology/imports/uberon_terms.txt`

The goal of this ontology is to help improve communication between 
neuroimaging scientists and researchers with little-to-no experience, 
standardize communication between neuroimagers, 
and serve as a backbone for full automation of the neuroimaging research process.
Because so much of neuroimaging research is conducted via programming, 
this ontology has the potential to integrate with established neuroimaging software 
and greatly simplify the neuroimaging research process.

### Publications

MRIO is now published in the journal [Neuroinformatics](https://link.springer.com/journal/12021)! 
The peer-reviewed article may be found [here](https://link.springer.com/article/10.1007/s12021-024-09664-8).
Additionally, the preprint is freely available on [bioRxiv](https://doi.org/10.1101/2023.08.04.552020).

----------------------------------

## Automated MRI acquisition type classification

This repo also contains scripts that may be used to automatically infer the 
acquisition type of an MRI using only a few acquisition parameters.
These parameters may be found in DICOM file headers or BIDS sidecars
if dcm2niix was used. To run the scripts, you must be in the 
./src/ontology directory and docker must be installed.

**Usage**

The following script inserts an individual with `URI=$new_individual_uri` into
a temporary OWL file, then runs the HermiT reasoner to infer the acquisition type.
The individual and its inferred acquisition type are then written to `./individuals.csv`.

To insert and reason over the new individual:

`./get_sequence_from_parameters.sh $new_individual_uri $flip_angle $echo_time $repetition_time $inversion_time`

To see the inferred results:

`grep "$new_individual_uri" individuals.csv`

---------------------------------

## Auomated assignment of analyses

Adapted from [a fully automated neuroimaging analysis platform](https://gitlab.com/abartnik/cbi-project).

Usage:

```{python}
python3 -m venv venv
pip install -r requirements.txt

cd src/scripts
python assign_analyses.py -h
  This tool automatically assigns neuroimaging analyses given a set of MRI
  acquisition sequences.

  positional arguments:
    acquisition_sequences
                          IRIs of acquisition sequences to assign analyses for.

  optional arguments:
    -h, --help            show this help message and exit

python assign_analyses.py MRIO_0000392 MRIO_0000678 # MRIO_0000392: FLAIR sequence, MRIO_0000678: MPRAGE sequence
```

-------------------------------

## Contributing

MRIO welcomes all meaningful contributions from the community! 
These include, but are not limited to, corrections to existing classes/axioms, 
expansion to bioinformatics data pertaining to fields beyond neuroimaging,
expansion of MRI acquisition types and parameters beyond neuroimaging, 
and alignment with other neuroimaging and OBO ontologies 
(e.g. [NIDM](https://github.com/incf-nidash/nidm-terms)).

The MRIO team meets biweekly via Zoom on Thursdays at 2:00pm EST to discuss ongoing development.
External contributers are more than welcome to join these meetings to discuss new terms 
or anything related to the ontology.
To obtain a link to the biweekly MRIO discussion, please contact Alexander Bartnik at adbartni@buffalo.edu.

For more information on how to contribute, please see [Contributing](./CONTRIBUTING.md) 
and [README-odk](./README-odk.md).
