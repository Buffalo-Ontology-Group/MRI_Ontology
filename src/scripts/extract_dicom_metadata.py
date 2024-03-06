from pydicom import dcmread
import rdflib
from rdflib import URIRef, Namespace, BNode, Literal
from rdflib.namespace import CSVW, DC, DCAT, DCTERMS, DOAP, FOAF, ODRL2, ORG, OWL, \
                           PROF, PROV, RDF, RDFS, SDO, SH, SKOS, SOSA, SSN, TIME, \
                           VOID, XMLNS, XSD
import begin


mrio = Namespace("http://purl.obolibrary.org/obo/")

mri_metadata_uris = {
    'magnetic resonance imaging assay': URIRef(f"{mrio}OBI_0002985"),
    'magnetic resonance image data set': URIRef(f"{mrio}OBI_0003328"),
    'magnetic resonance imaging participant': URIRef(f"{mrio}OBI_0003329"),
    'acquisition matrix': URIRef(f"{mrio}MRIO_0000364"),
    'echo time': URIRef(f"{mrio}MRIO_0000358"),
    'echo train length': URIRef(f"{mrio}MRIO_0000359"),
    'field of view': URIRef(f"{mrio}MRIO_0000360"),
    'flip angle': URIRef(f"{mrio}MRIO_0000630"),
    'inversion time': URIRef(f"{mrio}MRIO_0000653"),
    'number of temporal positions': URIRef(f"{mrio}MRIO_0000687"),
    'phase FOV': URIRef(f"{mrio}MRIO_0000361"),
    "acquisition plane": {
        "coronal": URIRef(f"{mrio}MRIO_0000371"),
        "sagittal": URIRef(f"{mrio}MRIO_0000370"),
        "transverse": URIRef(f"{mrio}MRIO_0000372")
    },
    'repitition time': URIRef(f"{mrio}MRIO_0000357"),
    'slice gap': URIRef(f"{mrio}MRIO_0000363"),
    'slice thickness': URIRef(f"{mrio}MRIO_0000362"),
    'magnetic resonance pulse sequence protocol': "http://purl.obolibrary.org/obo/OBI_0003332",
    'gradient echo sequence': URIRef(f"{mrio}MRIO_0000628"),
    'spin echo sequence': URIRef(f"{mrio}MRIO_0000659"),
    'NMR instrument': URIRef(f"{mrio}OBI_0000566"),
    "manufacturer": URIRef(f"{mrio}OBI_0000835")
}

is_about = URIRef(f"{mrio}IAO_0000136")
has_specified_value = URIRef(f"{mrio}OBI_0002135")
has_specified_input = URIRef(f"{mrio}OBI_0000293")
has_specified_output = URIRef(f"{mrio}OBI_0000299")
is_specified_output_of = URIRef(f"{mrio}OBI_0000312")


@begin.start
def main(dcm: "Path to DICOM directory"):
    header = dcmread(dcm)

    mri_scan = URIRef(f"{mrio}{BNode()}")
    mri_participant = URIRef(f"{mrio}{BNode()}")
    mri_acquisition = URIRef(f"{mrio}{BNode()}")
    mri_scanner = URIRef(f"{mrio}{BNode()}")

    graph = rdflib.Graph()
    graph.bind("MRIO", mrio)

    graph.add(
        (mri_scan, RDF.type, mri_metadata_uris['magnetic resonance image data set'])
    )
    graph.add(
        (mri_scan, is_about, mri_participant)
    )
    graph.add(
        (mri_participant, RDF.type, mri_metadata_uris['magnetic resonance imaging participant'])
    )
    graph.add(
        (mri_participant, SDO.identifier, Literal(header.PatientID))
    )
    graph.add(
        (mri_acquisition, RDF.type, mri_metadata_uris['magnetic resonance imaging assay'])
    )
    graph.add(
        (mri_acquisition, has_specified_input, mri_participant)
    )
    graph.add(
        (mri_acquisition, has_specified_input, mri_scanner)
    )
    graph.add(
        (mri_scanner, RDF.type, mri_metadata_uris['manufacturer'])
    )
    graph.add(
        (mri_scanner, SDO.identifier, (Literal(header.Manufacturer)))
    )

    graph.add(
        (mri_metadata_uris['acquisition matrix'], is_about, mri_scanner)
    )
    graph.add(
        (mri_metadata_uris['acquisition matrix'], has_specified_value, Literal(header.AcquisitionMatrix))
    )
    
    graph.add(
        (mri_metadata_uris['echo time'], is_about, mri_scanner)
    )
    graph.add(
        (mri_metadata_uris['echo time'], has_specified_value, Literal(header.EchoTime))
    )

    graph.add(
        (mri_metadata_uris['echo train length'], is_about, mri_scanner)
    )
    graph.add(
        (mri_metadata_uris['echo train length'], has_specified_value, Literal(header.EchoTrainLength))
    )

    graph.add(
        (mri_metadata_uris['flip angle'], is_about, mri_scanner)
    )
    graph.add(
        (mri_metadata_uris['flip angle'], has_specified_value, Literal(header.FlipAngle))
    )

    graph.add(
        (mri_metadata_uris['inversion time'], is_about, mri_scanner)
    )
    graph.add(
        (mri_metadata_uris['inversion time'], has_specified_value, Literal(header.InversionTime))
    )

    graph.add(
        (mri_metadata_uris['phase FOV'], is_about, mri_scanner)
    )
    graph.add(
        (mri_metadata_uris['phase FOV'], has_specified_value, Literal(header.PercentPhaseFieldOfView))
    )

    graph.add(
        (mri_metadata_uris['repitition time'], is_about, mri_scanner)
    )
    graph.add(
        (mri_metadata_uris['repitition time'], has_specified_value, Literal(header.RepetitionTime))
    )

    graph.add(
        (mri_metadata_uris['slice gap'], is_about, mri_scanner)
    )
    graph.add(
        (mri_metadata_uris['slice gap'], has_specified_value, Literal(header.SpacingBetweenSlices))
    )

    graph.add(
        (mri_metadata_uris['slice thickness'], is_about, mri_scanner)
    )
    graph.add(
        (mri_metadata_uris['slice thickness'], has_specified_value, Literal(header.SliceThickness))
    )

    if "GR" in header.ScanningSequence:
        graph.add(
            (mri_metadata_uris['gradient echo sequence'], is_about, mri_scanner)
        )
        graph.add(
            (mri_metadata_uris['gradient echo sequence'], has_specified_value, XSD.boolean)
        )

    if "SE" in header.ScanningSequence:
        graph.add(
            (mri_metadata_uris['spin echo sequence'], is_about, mri_scanner)
        )
        graph.add(
            (mri_metadata_uris['spin echo sequence'], has_specified_value, XSD.boolean)
        )

    print(graph.serialize())
    

    # header_dict = header.to_json_dict()

    # print(header_dict['00180081']['Value'])

    # print(header_dict.items(())
    # for key, val in header.to_json_dict().items():
    #     print(key, val)
